import 'package:demo_app/domain/cuisine/models/cuisine.model.dart';

class CuisineViewModel {
  final CuisineModel cuisine;

  CuisineViewModel(this.cuisine);

  String get name => this.cuisine.name;

  String get imageUrl => this.cuisine.imageThumbnailUrl;
}
