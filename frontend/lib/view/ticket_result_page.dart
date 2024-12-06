import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicketResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(2)),
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
