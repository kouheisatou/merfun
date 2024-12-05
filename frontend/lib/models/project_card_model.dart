class ProjectCardModel {
  final String title;
  final String imageUrl;

  ProjectCardModel({required this.title, required this.imageUrl});

  // JSONデータからItemインスタンスを生成するファクトリメソッド
  factory ProjectCardModel.fromJson(Map<String, dynamic> json) {
    return ProjectCardModel(
      title: json["title"] ?? "タイトルなし",
      imageUrl: json["imageUrl"] ?? "",
    );
  }
}
