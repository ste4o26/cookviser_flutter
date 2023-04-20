import "package:demo_app/domain/recipe/models/recipe.model.dart";
import "package:demo_app/services/recipe.service.dart";
import "package:flutter/material.dart";

class RecipeListViewModel extends ChangeNotifier {
  final RecipeService service = RecipeService();
  List<RecipeModel> recipes = [];

  Future<void> fetchNextPageByCuisine(String name, int page) async {
  recipes =
        await this.service.fetchNextPageByCuisine(name, page);
    notifyListeners();
  }

  Future<void> fetchNextPage(int page) async {
    recipes = await this.service.fetchNextPage(page);
    notifyListeners();
  }

  Future<void> fetchAll() async {
     recipes = await this.service.fetchAll();
    notifyListeners();
  }
}
  