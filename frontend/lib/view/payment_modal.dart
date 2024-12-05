import 'package:flutter/material.dart';
import 'package:frontend/models/project_detail_model.dart';

import 'confirmation_dialog.dart';
import 'mercari_button.dart';

class PaymentModal extends StatelessWidget {
  TicketDetailModel ticket;

  PaymentModal({required this.ticket, super.key});

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
            Stack(
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
                Positioned(child: Container(color: Colors.white,height: 85,),),
                Positioned(
                  left: 15,
                  top: 13,
                  child: Container(
                    color: Colors.white,
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.network(ticket.imageUrl),
                    ),
                  ),
                ),
                Positioned(
                  left: 87,
                  top: 23,
                  child: Text(ticket.title),
                ),
                Positioned(
                  left: 89,
                  top: 44,
                  child: Text("¥ ${ticket.price}", style: TextStyle(fontWeight: FontWeight.w700),),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomOutlinedButton(
                          text: " 分割払いで購入 ",
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CustomElevatedButton(
                          text: "  購入手続きへ  ",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
