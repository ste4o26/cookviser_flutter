import 'package:demo_app/domain/rating/models/rating_model.dart';
import 'package:demo_app/services/auth.service.dart';
import 'package:demo_app/services/recipe.service.dart';
import 'package:flutter/cupertino.dart';

class RatingViewModel with ChangeNotifier{
  final _recipeService = RecipeService();
  final _authService = AuthService();
  
  Future<double?> rate(RatingModel rating) async {
    String? token = await _authService.getToken();
    if (token == null) return null;
    RatingModel ratingModel = await _recipeService.rate(rating, token);
    return ratingModel.recipe.overallRating;
  }
}