import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/recipe/models/recipe.dart';
import 'package:demo_app/services/recipe.dart';
import 'package:flutter/material.dart';

class RecipeListViewModel extends ChangeNotifier {
  final RecipeService _service = RecipeService();
  bool hasNextPage = true;
  List<RecipeModel> recipes = [];

  Future<void> fetchNextPageByCuisine(String name, int page) async {
    recipes = await _service.fetchNextPageByCuisine(name, page);
    notifyListeners();
  }

  Future<void> fetchNextPage(int page) async {
    recipes = await _service.fetchNextPage(page);
    hasNextPage = await hasNextRecipePage(page);
    notifyListeners();
  }

  Future<bool> hasNextRecipePage(int page) async {
    if (recipes.length >= MAX_RECIPES_PER_PAGE_COUNT) {
      final nextPageRecipes = await _service.fetchNextPage(page + 1);
      return  nextPageRecipes.isNotEmpty;
    } else {
      return false;
    }
  }

  Future<void> fetchAll() async {
    recipes = await _service.fetchAll();
    notifyListeners();
  }

  Future<void> search(String value) async {
    recipes = await _service.search(value);
    notifyListeners();
  }
}
