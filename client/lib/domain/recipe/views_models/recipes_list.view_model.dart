import "package:demo_app/domain/recipe/models/recipe.model.dart";
import "package:demo_app/domain/recipe/views_models/recipe.view_model.dart";
import "package:demo_app/services/recipe.service.dart";
import "package:flutter/material.dart";

class RecipeListViewModel extends ChangeNotifier {
  final RecipeService service = RecipeService();
  List<RecipeViewModel> recipes = [];

  Future<void> fetchNextPageByCuisine(String name, int page) async {
    List<RecipeModel> recipes =
        await this.service.fetchNextPageByCuisine(name, page);

    this.recipes = recipes.map((recipe) => RecipeViewModel(recipe)).toList();
    notifyListeners();
  }

  Future<void> fetchNextPage(int page) async {
    List<RecipeModel> recipes = await this.service.fetchNextPage(page);
    this.recipes = recipes.map((recipe) => RecipeViewModel(recipe)).toList();
    notifyListeners();
  }

  Future<void> fetchAll() async {
    List<RecipeModel> recipes = await this.service.fetchAll();
    this.recipes = recipes.map((recipe) => RecipeViewModel(recipe)).toList();
    notifyListeners();
  }
}
  