import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 購入したチケットの確認画面
class TicketResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 2,
            ),
            Image.asset(
              "images/ticket_sample.png",
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
