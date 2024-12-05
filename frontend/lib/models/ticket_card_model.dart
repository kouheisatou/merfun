class TicketCardModel {
  final String id;
  final String title;
  final String imageUrl;

  TicketCardModel({required this.id, required this.title, required this.imageUrl});

  // JSONデータからItemインスタンスを生成するファクトリメソッド
  factory TicketCardModel.fromJson(Map<String, dynamic> json) {
    return TicketCardModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "タイトルなし",
      imageUrl: json["imageUrl"] ?? "",
    );
  }
}
