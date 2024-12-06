package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"html/template"
	"io"
	"log"
	"net/http"
	"os"
	"path"
	"strconv"
	"time"

	"merfun/block"
	"merfun/ticket"

	"merfun/utils"

	"merfun/wallet"
)

const tempDir = "./templates"

var ticketMap = make(map[int]*ticket.NFTTicket)
var dummyWallet = make([]*wallet.Wallet, 0)

type WalletServer struct {
	port    uint16
	gateway string
}

func (ws *WalletServer) init() {
	err := loadTicketsToMap("dummy.json")
	if err != nil {
		fmt.Println("Failed to load tickets:", err)
		return
	}
	var wal *wallet.Wallet
	for i := 1; i <= 5; i++ {
		wal = wallet.NewWallet()
		dummyWallet = append(dummyWallet, wal)
		ticketMap[i].OwnerAddress = wal.BlockchainAddress()
		ticketMap[i].TimeStamp = time.Now().UnixNano()
	}

}

func loadTicketsToMap(filePath string) error {
	data, err := os.ReadFile(filePath)
	if err != nil {
		return err
	}

	var tickets []ticket.NFTTicket
	err = json.Unmarshal(data, &tickets)
	if err != nil {
		return err
	}

	for i := range tickets {
		ticketMap[tickets[i].TicketID] = &tickets[i]
	}

	return nil
}

func NewWalletServer(port uint16, gateway string) *WalletServer {
	return &WalletServer{port: port,
		gateway: gateway}
}

func (ws *WalletServer) Port() uint16 {
	return ws.port
}

func (ws *WalletServer) Gateway() string {
	return ws.gateway
}

// Read Template API
func (ws *WalletServer) Index(w http.ResponseWriter, req *http.Request) {
	switch req.Method {
	case http.MethodGet:
		t, err := template.ParseFiles(path.Join(tempDir, "index.html"))
		if err != nil {
			log.Printf("Index Error : %s", err.Error())
		}
		t.Execute(w, "")
	default:
		log.Printf("Error: Invalid http method")
	}
}

// Create Wallet Info API
func (ws *WalletServer) Wallet(w http.ResponseWriter, req *http.Request) {
	switch req.Method {
	case http.MethodPost:
		w.Header().Add("Content-Type", "application/json")
		myWallet := wallet.NewWallet()
		m, _ := myWallet.MarshalJSON()
		io.Writer.Write(w, m[:])
	default:
		w.WriteHeader(http.StatusBadRequest)
		log.Println("Error: Invalid http method")
	}
}

/*
Create Ticket API
1. Decode Request: json -> go
2. Input Validationg
3. Create a Wallet for Project (wallet include publickey, privatekey, address)
4. Generate a Project, append to ProjectMap
5. Response Project Wallet
*/
func (ws *WalletServer) CreateTicket(w http.ResponseWriter, req *http.Request) {
	switch req.Method {
	case http.MethodPost:
		dec := json.NewDecoder(req.Body)
		var tr ticket.TicketRequest
		err := dec.Decode(&tr)
		if err != nil {
			log.Printf("Error: %v", err)
			io.Writer.Write(w, utils.JsonStatus("failed"))
			return
		}

		if !tr.Validate() {
			log.Printf("Error: missing field")
			io.Writer.Write(w, utils.JsonStatus("failed"))
			return
		}

		num := len(ticketMap) + 1

		price, _ := strconv.Atoi(*tr.Price)

		url := ""

		newTicket := ticket.NewNFTTicket(num, *tr.Name, *tr.OwnerAddress, *tr.Description, price, url)

		ticketMap[num] = newTicket

		fmt.Printf("newT: %v", newTicket)

		cr := ticket.CreationResponse{
			TicketID: &num,
		}

		m, _ := json.Marshal(cr)

		w.Header().Add("Content-Type", "application/json")
		io.Writer.Write(w, m)

	default:
		w.WriteHeader(http.StatusBadRequest)
		log.Println("Error: Invalid http method")
	}
}

/*
Create Transaction API:
1. Require PublicKey, PrivateKey to generate a signature
2. Generate a request include Sender Address, Recipient Address, Signature, Transfer Amount, Sender Publickey
3. if Authentication(Signature confirm) passed , resp -> success | else -> failed
*/
func (ws *WalletServer) CreateTransaction(w http.ResponseWriter, req *http.Request) {
	switch req.Method {
	case http.MethodPost:
		dec := json.NewDecoder(req.Body)
		var t wallet.TransactionRequest
		err := dec.Decode(&t)
		if err != nil {
			log.Printf("Error: %v", err)
			io.Writer.Write(w, utils.JsonStatus("Failed"))
			return
		}
		if !t.Validate() {
			log.Println("Error: missing field")
			return
		}

		publicKey := utils.PublickKeyFromString(*t.SenderPublicKey)
		privateKey := utils.PrivateKeyFromString(*t.SenderPrivateKey, publicKey)
		value, err := strconv.ParseFloat(*t.Value, 32)
		if err != nil {
			log.Println("Error: Parse Float Error")
			io.Writer.Write(w, utils.JsonStatus("Failed"))
			return
		}
		value32 := float32(value)

		w.Header().Add("Conten-Type", "application/json")

		transaction := wallet.NewTransaction(privateKey, publicKey, *t.SenderBlockChainAddress, *t.RecipientBlockChainAddress, value32)
		signature := transaction.GenerateSignature()
		signatureStr := signature.String()

		bt := &block.TransactionRequest{
			SenderBlockChainAddress:    t.SenderBlockChainAddress,
			RecipientBlockChainAddress: t.RecipientBlockChainAddress,
			SenderPublicKey:            t.SenderPublicKey,
			Value:                      &value32,
			Signature:                  &signatureStr,
		}

		fmt.Println(*bt.RecipientBlockChainAddress, *bt.SenderBlockChainAddress, *bt.SenderPublicKey, *bt.Signature, *bt.Value)

		m, _ := json.Marshal(bt)
		buf := bytes.NewBuffer(m)

		resp, _ := http.Post(ws.Gateway()+"/transactions", "application/json", buf)
		if resp.StatusCode == 201 {
			id := new(int)
			for _, ticket := range ticketMap {
				if ticket.OwnerAddress == *bt.RecipientBlockChainAddress {
					*id = ticket.TicketID
				}
			}
			ticketMap[*id].OwnerAddress = *bt.SenderBlockChainAddress
			io.Writer.Write(w, utils.JsonStatus("success"))
			return
		} else {

			io.Writer.Write(w, utils.JsonStatus("failed"))
		}

	default:
		w.WriteHeader(http.StatusBadRequest)
		log.Println("Error: Invalid http method")
	}
}

/*
	Get Project List

1. Loop ProjectMap
2. Response Slice of Project which just include Name, Description, ProjectAddress, CurrentAmount
*/
func (ws *WalletServer) GetAllTicket(w http.ResponseWriter, req *http.Request) {
	switch req.Method {
	case http.MethodGet:
		tresp := make([]ticket.TicketResponse, 0, len(ticketMap))

		if len(ticketMap) == 0 {
			log.Println("Error: No project exist")
			io.Writer.Write(w, utils.JsonStatus("failed"))
		}

		for _, tic := range ticketMap {

			tresp = append(tresp, ticket.TicketResponse{
				TicketId:     &tic.TicketID,
				Name:         &tic.Name,
				Description:  &tic.Description,
				OwnerAddress: &tic.OwnerAddress,
				Price:        &tic.Price,
				ImageURL:     &tic.ImageURL,
			})
		}
		w.Header().Add("Content-Type", "application/json")

		m, _ := json.Marshal(tresp)

		io.Writer.Write(w, m[:])

	default:
		w.WriteHeader(http.StatusBadRequest)
		log.Println("Error: Invalid http method")
	}

}

func (ws *WalletServer) WalletAmount(w http.ResponseWriter, req *http.Request) {
	switch req.Method {
	case http.MethodGet:
		blockchainAddress := req.URL.Query().Get("blockchain_address")
		endpoint := fmt.Sprintf("%s/amount", ws.Gateway())

		client := &http.Client{}
		bcsReq, _ := http.NewRequest("GET", endpoint, nil)
		q := bcsReq.URL.Query()
		q.Add("blockchain_address", blockchainAddress)
		bcsReq.URL.RawQuery = q.Encode()

		bcsResp, err := client.Do(bcsReq)
		if err != nil {
			log.Printf("Error: %v", err)
			io.Writer.Write(w, utils.JsonStatus("failed"))
			return
		}

		w.Header().Add("Content-Type", "application/json")
		if bcsResp.StatusCode == 200 {
			decoder := json.NewDecoder(bcsResp.Body)
			var bar block.AmountRespone
			err := decoder.Decode(&bar)
			if err != nil {
				log.Printf("Error: %v", err)
				io.Writer.Write(w, utils.JsonStatus("failed"))
				return
			}
			m, _ := json.Marshal(struct {
				Message string  `json:"message"`
				Amount  float32 `json:"amount"`
			}{
				Message: "success",
				Amount:  bar.Amount,
			})
			io.Writer.Write(w, m)

		} else {
			io.Writer.Write(w, utils.JsonStatus("failed"))
		}
	default:
		log.Println("Error: Invalid http method")
		w.WriteHeader(http.StatusBadRequest)

	}

}

func (ws *WalletServer) Run() {
	ws.init()
	http.HandleFunc("/", ws.Index)
	http.HandleFunc("/wallet", ws.Wallet)
	http.HandleFunc("/ticket", ws.CreateTicket)
	http.HandleFunc("/ticket/all", ws.GetAllTicket)
	http.HandleFunc("/wallet/amount", ws.WalletAmount)
	http.HandleFunc("/transaction", ws.CreateTransaction)
	log.Fatal(http.ListenAndServe("0.0.0.0:"+strconv.Itoa(int(ws.port)), nil))
}
