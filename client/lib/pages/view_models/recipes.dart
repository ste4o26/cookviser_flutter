import 'package:demo_app/domain/recipe/models/recipe.dart';
import 'package:demo_app/services/recipe.dart';
import 'package:flutter/material.dart';

class RecipeListViewModel extends ChangeNotifier {
  final RecipeService _service = RecipeService();
  List<RecipeModel> recipes = [];

  Future<void> fetchNextPageByCuisine(String name, int page) async {
    recipes = await _service.fetchNextPageByCuisine(name, page);
    notifyListeners();
  }

  Future<void> fetchNextPage(int page) async {
    recipes = await _service.fetchNextPage(page);
    notifyListeners();
  }

  Future<void> fetchAll() async {
    recipes = await _service.fetchAll();
    notifyListeners();
  }
}