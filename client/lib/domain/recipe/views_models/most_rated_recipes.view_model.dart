import 'package:demo_app/domain/recipe/models/recipe.model.dart';
import 'package:demo_app/domain/recipe/views_models/recipe.view_model.dart';
import 'package:demo_app/services/recipe.service.dart';
import 'package:flutter/material.dart';

class MostRatedRecipesViewModel extends ChangeNotifier {
  final service = RecipeService();
  List<RecipeViewModel> recipes = [];

  Future<void> fetch() async {
    List<RecipeModel> recipes = await service.mostRated();
    this.recipes = recipes.map((recipe) => RecipeViewModel(recipe)).toList();
    notifyListeners();
  }
}
