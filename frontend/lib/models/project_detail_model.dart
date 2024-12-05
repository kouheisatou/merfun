class ProjectDetailModel {
  final String title;
  final String description;
  final String imageUrl;
  final int totalSupportAmount;
  final int supporterCount;

  ProjectDetailModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.totalSupportAmount,
    required this.supporterCount,
  });

  // JSONデータから生成するファクトリメソッド
  factory ProjectDetailModel.fromJson(Map<String, dynamic> json) {
    return ProjectDetailModel(
      title: json["title"] ?? "プロジェクトタイトル",
      description: json["description"] ?? "プロジェクトの詳細情報",
      imageUrl: json["imageUrl"] ?? "",
      totalSupportAmount: json["totalSupportAmount"] ?? 0,
      supporterCount: json["supporterCount"] ?? 0,
    );
  }
}
