import 'package:demo_app/domain/recipe/models/recipe.model.dart';
import 'package:demo_app/services/recipe.service.dart';
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