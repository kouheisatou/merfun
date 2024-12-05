class ProjectCardModel {
  final String id;
  final String title;
  final String imageUrl;

  ProjectCardModel({required this.id, required this.title, required this.imageUrl});

  // JSONデータからItemインスタンスを生成するファクトリメソッド
  factory ProjectCardModel.fromJson(Map<String, dynamic> json) {
    return ProjectCardModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "タイトルなし",
      imageUrl: json["imageUrl"] ?? "",
    );
  }
}
