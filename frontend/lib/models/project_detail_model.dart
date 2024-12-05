class TicketDetailModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int price;

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
      title: json["title"] ?? "プロジェクトタイトル",
      description: json["description"] ?? "プロジェクトの詳細情報",
      imageUrl: json["imageUrl"] ?? "",
      price: json["supporterCount"] ?? 0,
    );
  }
}
