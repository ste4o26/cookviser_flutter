import 'package:demo_app/domain/cuisine/models/cuisine.model.dart';
import 'package:demo_app/domain/recipe/models/recipe.model.dart';
import 'package:demo_app/domain/user/models/user.model.dart';
import 'package:demo_app/services/cuisine.service.dart';
import 'package:demo_app/services/recipe.service.dart';
import 'package:demo_app/services/user_service.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  final cuisineService = CuisineService();
  final recipeService = RecipeService();
  final userService = UserService();

  List<CuisineModel> cuisines = [];
  List<RecipeModel> recipes = [];
  List<UserModel> users = [];

  Future<void> fetchInfo() async {
    users = await userService.fetchBestThree();
    cuisines = await cuisineService.mostPopulated();
    recipes = await recipeService.mostRated();
    notifyListeners();
  }
}
