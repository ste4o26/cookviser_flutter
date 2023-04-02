import 'package:demo_app/domain/cuisine/models/cuisine.model.dart';

class CuisineViewModel {
  final CuisineModel cuisine;

  CuisineViewModel({required this.cuisine});

  String get name {
    return this.cuisine.name;
  }

  String get iamgeUrl {
    return this.cuisine.imageThumbnailUrl;
  }
}
