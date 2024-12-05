class TicketDetailModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int price;
  bool purchased = false;

  TicketDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  // JSONデータから生成するファクトリメソッド
  factory TicketDetailModel.fromJson(Map<String, dynamic> json) {
    return TicketDetailModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "チケットタイトル",
      description: json["description"] ?? "チケットの詳細情報",
      imageUrl: json["imageUrl"] ?? "",
      price: json["supporterCount"] ?? 0,
    );
  }
}
