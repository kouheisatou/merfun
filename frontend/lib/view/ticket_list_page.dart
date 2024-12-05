import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/ticket_card_model.dart';
import 'package:http/http.dart' as http;

class TicketListPage extends StatefulWidget {
  @override
  _TicketListPageState createState() => _TicketListPageState();
}

class _TicketListPageState extends State<TicketListPage> {
  List<TicketCardModel> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    // ダミーAPIからデータを取得
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos?_limit=8'));

    if (response.statusCode == 200) {
      // final data = json.decode(response.body);
      final data = json.decode('[{"id": "id1", "title": "title", "imageUrl": ""},{"id": "id1", "title": "title", "imageUrl": ""},{"id": "id1", "title": "title", "imageUrl": ""},{"id": "id1", "title": "title", "imageUrl": ""},{"id": "id1", "title": "title", "imageUrl": ""}]');
      setState(() {
        _items = (data as List).map((item) => TicketCardModel.fromJson(item)).toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('データの取得に失敗しました');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("メルカリ ファン"),
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
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final ticketItem = _items[index]; // データクラスのインスタンスを取得
                return InkWell(
                  borderRadius: BorderRadius.circular(12), // 角丸
                  onTap: () {
                    Navigator.pushNamed(context, '/details', arguments: _items[index].id);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            ticketItem.imageUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 40,
                          child: Text(
                            ticketItem.title,
                            style: TextStyle(fontSize: 12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
