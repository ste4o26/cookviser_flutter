import 'package:demo_app/domain/rating/models/rating_model.dart';
import 'package:demo_app/services/recipe.service.dart';
import 'package:flutter/cupertino.dart';

class RatingViewModel with ChangeNotifier{
  final service = RecipeService();
  
  Future<RatingModel> rate(rating,token){
    return service.rate(rating, token);
  }
}