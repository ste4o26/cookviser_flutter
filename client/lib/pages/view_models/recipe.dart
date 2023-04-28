import 'dart:io';

import 'package:demo_app/domain/recipe/models/recipe.dart';
import 'package:demo_app/services/recipe.dart';
import 'package:flutter/material.dart';

class RecipeViewModel extends ChangeNotifier {
  RecipeModel? recipe = null;
  final RecipeService _service = RecipeService();

  Future<void> post(RecipeModel recipeModel) async {
    RecipeModel? postedRecipe = await _service.post(recipeModel);
    // recipe = await _service.uploadImage(image, postedRecipe.id ?? "");
    notifyListeners();
  }
}