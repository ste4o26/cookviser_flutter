import 'dart:typed_data';

import 'package:demo_app/domain/cuisine/models/cuisine.dart';
import 'package:demo_app/domain/recipe/models/recipe.dart';
import 'package:demo_app/services/recipe.dart';
import 'package:flutter/material.dart';

class RecipeViewModel extends ChangeNotifier {
  RecipeModel? recipe;
  List<CuisineModel> cuisines = [];
  final RecipeService _service = RecipeService();

  Future<void> fetchById(String id) async {
    recipe = await _service.fetchById(id);
    notifyListeners();
  }

  Future<void> post(RecipeModel recipeModel, Uint8List webImage) async {
    RecipeModel? postedRecipe = await _service.post(recipeModel);
    String recipeId = postedRecipe!.id ?? "";
    recipe = await _service.uploadImage(webImage, recipeId);
    notifyListeners();
  }
}
