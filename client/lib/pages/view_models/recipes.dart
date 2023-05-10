import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/recipe/models/recipe.dart';
import 'package:demo_app/services/recipe.dart';
import 'package:flutter/material.dart';

class RecipeListViewModel extends ChangeNotifier {
  final RecipeService _service = RecipeService();
  bool hasNextPage = true;
  List<RecipeModel> recipes = [];

  Future<void> fetchNextPageByCuisine(String name, int page) async {
    final recipes = await _service.fetchNextPageByCuisine(name, page);
    notifyListeners();
  }

  Future<void> fetchNextPage(int page) async {
    final currentPageRecipes = await _service.fetchNextPage(page);
    if (currentPageRecipes.isNotEmpty && currentPageRecipes.length < MAX_RECIPES_PER_PAGE_COUNT) {
      hasNextPage = false;
      recipes = currentPageRecipes;
    } else if (currentPageRecipes.length >= MAX_RECIPES_PER_PAGE_COUNT) {
      hasNextPage = true;
      recipes = currentPageRecipes;
    } else {
      hasNextPage = false;
      recipes = [];
    }
    notifyListeners();
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
