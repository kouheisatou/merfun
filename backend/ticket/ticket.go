package ticket

import "time"

type NFTTicket struct {
	TicketID     int
	Name         string
	Description  string
	Price        int
	OwnerAddress string
	timeStamp    int64
}

type TicketRequest struct {
	Name         *string `json:"name"`
	Description  *string `json:"description"`
	Price        *string `json:"price"`
	OwnerAddress *string `json:"owner_address"`
}
type TicketResponse struct {
	TicketId     *int    `json:"ticket_id"`
	Name         *string `json:"name"`
	Description  *string `json:"description"`
	OwnerAddress *string `json:"owner_address"`
	Price        *int    `json:"price"`
}

type CreationResponse struct {
	TicketID *int `json:"ticket_id"`
}

type ProjectAmountResponse struct {
	Amount float32 `json:"project_amount"`
}

func NewNFTTicket(ticketID int, name, ownerAddress string, description string, price int) *NFTTicket {
	return &NFTTicket{
		TicketID:     ticketID,
		Name:         name,
		Description:  description,
		Price:        price,
		OwnerAddress: ownerAddress,
		timeStamp:    time.Now().UnixNano(),
	}
}

func (tr *TicketRequest) Validate() bool {
	if tr.Description == nil || tr.Name == nil || tr.Price == nil {

		return false

	}
	return true
}
