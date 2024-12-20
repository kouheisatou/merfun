import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/shared_resource.dart';
import 'package:frontend/view/buttons.dart';
import 'package:frontend/view/payment_modal.dart';
import 'package:http/http.dart' as http;
import 'package:openapi/api.dart';

/// チケット詳細ページ
class TicketDetailPage extends StatefulWidget {
  Ticket ticket;
  bool purchased = false;

  TicketDetailPage({required this.ticket, super.key});

  @override
  _TicketDetailPageState createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("詳細", style: TextStyle(fontSize: 15)),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 310,
              width: double.infinity,
              child: Image.network(
                widget.ticket.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                utf8.decode(base64Decode(widget.ticket.name)),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "商品の説明",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                utf8.decode(base64Decode(widget.ticket.description)),
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MercariButtonRed(
                onPressed: !widget.purchased
                    ? () async {
                        // 購入モーダルの表示
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                          ),
                          builder: (BuildContext context) {
                            return PaymentModal(ticket: widget.ticket);
                          },
                        );
                        widget.purchased = true;
                        setState(() {});
                      }
                    : null,
                text: "購入する",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
