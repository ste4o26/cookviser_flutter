class CuisineModel {
  String id;
  String name;
  String imageThumbnailUrl;

  CuisineModel({required this.id, required this.name, required this.imageThumbnailUrl});

  factory CuisineModel.fromJson(Map<String, dynamic> json) {
    return CuisineModel(
        id: json["id"],
        name: json["name"],
        imageThumbnailUrl: json["imageThumbnailUrl"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageThumbnailUrl'] = imageThumbnailUrl;
    return data;
  }
}
