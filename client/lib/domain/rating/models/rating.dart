import 'package:demo_app/domain/recipe/models/recipe.dart';
import 'package:demo_app/domain/user/models/user.dart';

class RatingModel {
  final int rating;
  final UserModel user;
  final RecipeModel recipe;

  RatingModel({required this.rating, required this.user, required this.recipe});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rating: json['rateValue'],
      user: UserModel.fromJson(json['user']),
      recipe: RecipeModel.fromJson(json['recipe']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['rateValue'] = rating;
    data['user'] = user.toJson();
    data['recipe'] = recipe.toJson();
    return data;
  }
}
