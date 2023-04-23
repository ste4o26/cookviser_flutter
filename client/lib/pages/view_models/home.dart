import 'package:demo_app/domain/cuisine/models/cuisine.dart';
import 'package:demo_app/domain/recipe/models/recipe.dart';
import 'package:demo_app/domain/user/models/user.dart';
import 'package:demo_app/services/cuisine.dart';
import 'package:demo_app/services/recipe.dart';
import 'package:demo_app/services/user.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  final _cuisineService = CuisineService();
  final _recipeService = RecipeService();
  final _userService = UserService();

  List<CuisineModel> cuisines = [];
  List<RecipeModel> recipes = [];
  List<UserModel> users = [];

  Future<void> fetchInfo() async {
    users = await _userService.fetchBestThree();
    cuisines = await _cuisineService.fetchMostPopulated();
    recipes = await _recipeService.fetchBestFour();
    notifyListeners();
  }
}
