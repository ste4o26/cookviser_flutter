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
}
