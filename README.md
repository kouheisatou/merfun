# How to run Bakckend Server?

1. Run Blockchain Server
```
cd backend/blockchain_server
go run main.go blockchain_server.go -port <YOUR PORT> 
```
Default port is 5000

2. Run Wallet Server
```
cd backend/wallet_server
go run main.go wallet_server.go
```
Default port is 8080

<img width="850" alt="スクリーンショット 0006-12-06 14 07 44" src="https://github.com/user-attachments/assets/c5589188-8cc7-468d-ae8c-8e62b3ab15a8">

# Wallet Server API 
## 1. Create Wallet  
Endpoint
```
http://localhost:<YOUR WALLET PORT>/wallet
```
(1) Create a Wallet  
(2) Wallet includes Publickey, Privatekey, Blockchain Address  
(3) Response Wallet  

## 2. Create Transaction
Endpoint
```
http://localhost:<YOUR WALLET PORT>/transaction
```

(1) Require PublicKey, PrivateKey to generate a signature  
(2) Generate a request include Sender Address, Recipient Address, Signature, Transfer Amount, Sender Publickey  
(3) if Authentication(Signature confirm) passed , resp -> success | else -> failed  

## 3. Get Ticket List  
Endpoint
```
http://localhost:<YOUR WALLET PORT>/ticket/all
```
(1) Loop ticketMap  
(2) Response Slice of ticket which just include Ticket ID, Name, Description, Owner Address, Price, Images URL 

# How does Blockchain Server work?
1. Create Block  
2. Add Transaction  
3. If Signature has be confirmed -> Transaction will be put into Transaction Pool  
4. Blockchain server will begin to Mine when a transaction request be commited  
5. Mining will try to solve nonce which associate with PrevHash and Transactions  
6. After mining, transactions in Transaction pool will be included in a new block and add to Blockchain

# Blockchain Server API
## 1. Confirm Blockchain
Endpoint
```
http://localhost:<YOUR BLOCKCHAIN PORT>/
```
## 2. Confirm Transactions in Transaction Pool  
Endpoint
```
http://localhost:<YOUR BLOCKCHAIN PORT>/transactions
```

# Frontend
## Used Libraries
- Flutter(Dart)
- OpenAPI
## How to build
```shell
flutter pub get
flutter run
```
