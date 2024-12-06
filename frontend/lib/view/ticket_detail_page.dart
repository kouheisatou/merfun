import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/ticket_detail_model.dart';
import 'package:frontend/view/buttons.dart';
import 'package:frontend/view/payment_modal.dart';
import 'package:http/http.dart' as http;

class TicketDetailPage extends StatefulWidget {
  TicketDetailModel ticket;

  TicketDetailPage({required this.ticket, super.key});

  @override
  _TicketDetailPageState createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  // late Future<TicketDetailModel> ticket;

  @override
  void initState() {
    super.initState();
    // ticket = fetchTicketDetail();
  }

  Future<TicketDetailModel> fetchTicketDetail() async {
    // ダミーAPIからデータを取得
    final response = await http.get(Uri.parse('https://google.com'));
    // final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/${widget.ticketId}'));
    if (response.statusCode == 200) {
      // final data = json.decode(response.body);
      final data = json.decode('{}');
      return TicketDetailModel.fromJson(data);
    } else {
      throw Exception('データの取得に失敗しました');
    }
  }

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
                widget.ticket.title,
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
                widget.ticket.description,
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MercariButtonRed(
                onPressed: !widget.ticket.purchased
                    ? () async {
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
