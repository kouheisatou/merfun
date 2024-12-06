import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/shared_resource.dart';
import 'package:http/http.dart' as http;
import 'package:openapi/api.dart';

class TicketListPage extends StatefulWidget {
  @override
  _TicketListPageState createState() => _TicketListPageState();
}

class _TicketListPageState extends State<TicketListPage> {
  List<Ticket> tickets = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    tickets = (await wallet_server_api.ticketAllGet()) ?? [];
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("メルカリ チケット", style: TextStyle(fontSize: 15)),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1,
              ),
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticketItem = tickets[index]; // データクラスのインスタンスを取得
                return InkWell(
                  borderRadius: BorderRadius.circular(12), // 角丸
                  onTap: () {
                    Navigator.pushNamed(context, '/details', arguments: tickets[index]);
                  },
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                ticketItem.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 40,
                              child: Text(
                                utf8.decode(base64Decode(ticketItem.name)),
                                style: TextStyle(fontSize: 12),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 8,
                        top: 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(90),
                            borderRadius: BorderRadius.circular(8.0), // 角丸の設定
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                            child: Text(
                              "¥${ticketItem.price.toString()}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold, // 太字に設定
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
