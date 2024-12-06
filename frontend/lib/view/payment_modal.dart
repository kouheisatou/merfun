import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/shared_resource.dart';
import 'package:openapi/api.dart';

import 'confirmation_dialog.dart';
import 'buttons.dart';

class PaymentModal extends StatefulWidget {
  Ticket ticket;

  PaymentModal({required this.ticket, super.key});

  @override
  State<PaymentModal> createState() => _PaymentModalState();
}

class _PaymentModalState extends State<PaymentModal> {
  bool isLoading = false;

  Future<void> send() async {
    setState(() {
      isLoading = true;
    });

    myWallet ??= await walletServerApi.walletPost();
    var resp = await walletServerApi.transactionPost(
      TransactionPostRequest(
        senderPrivateKey: widget.ticket.ownerAddress,
        senderBlockchainAddress: myWallet!.blockchainAddress,
        recipientBlockchainAddress: widget.ticket.ownerAddress,
        senderPublicKey: myWallet!.publicKey,
        value: widget.ticket.price.toString(),
      ),
    );
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.86,
      minChildSize: 0.4,
      maxChildSize: 0.86,
      builder: (BuildContext context, ScrollController scrollController) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Stack(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text(
                          "購入手続き",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          "images/payment_base.png", // 画像パス
                          fit: BoxFit.cover, // 画像を横幅に合わせる
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    child: Container(
                      color: Colors.white,
                      height: 85,
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 13,
                    child: Container(
                      color: Colors.white,
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.network(widget.ticket.imageUrl),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 87,
                    top: 23,
                    child: Text(utf8.decode(base64Decode(widget.ticket.name))),
                  ),
                  Positioned(
                    left: 89,
                    top: 44,
                    child: Text(
                      "¥ ${widget.ticket.price}",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MerucariButtonWhite(
                            text: " 分割払いで購入 ",
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: !isLoading ? Colors.red : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0), // 角丸
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                            onPressed: !isLoading ? send : null,
                            child: Text(
                              "  購入手続きへ  ",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    child: Center(
                      child: isLoading ? CircularProgressIndicator(color: Colors.red,) : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
