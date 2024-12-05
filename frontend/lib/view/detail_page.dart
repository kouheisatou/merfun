import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/project_detail_model.dart';
import 'package:frontend/view/payment_modal.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  String ticketId;

  DetailPage({required this.ticketId, super.key});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<TicketDetailModel> ticket;

  @override
  void initState() {
    super.initState();
    ticket = fetchTicketDetail();
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
        title: Text("詳細"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<TicketDetailModel>(
        future: ticket,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("エラーが発生しました"));
          } else if (snapshot.hasData) {
            final ticket = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    ticket.imageUrl,
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      ticket.title,
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
                      ticket.description,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                          ),
                          builder: (BuildContext context) {
                            return PaymentModal(ticket: ticket);
                          },
                        );
                      },
                      child: Text(
                        "このプロジェクトを応援する",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text("データがありません"));
          }
        },
      ),
    );
  }
}
