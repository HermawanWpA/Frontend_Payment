class TipsModel {
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnail;

  TipsModel({
    this.id,
    this.thumbnail,
    this.title,
    this.url,
  });

  factory TipsModel.fromJson(Map<String, dynamic> json) => TipsModel(
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnail: json['thumbnail'],
      );
}
