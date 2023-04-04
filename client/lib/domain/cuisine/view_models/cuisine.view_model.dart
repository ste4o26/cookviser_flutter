import 'package:demo_app/domain/cuisine/models/cuisine.model.dart';

class CuisineViewModel {
  final CuisineModel cuisine;

  CuisineViewModel(this.cuisine);

  String get name {
    return this.cuisine.name;
  }

  String get imageUrl {
    return this.cuisine.imageThumbnailUrl;
  }
}
