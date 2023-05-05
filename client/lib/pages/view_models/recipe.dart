import 'dart:io';
import 'dart:typed_data';

import 'package:demo_app/domain/cuisine/models/cuisine.dart';
import 'package:demo_app/domain/recipe/models/recipe.dart';
import 'package:demo_app/services/recipe.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class RecipeViewModel extends ChangeNotifier {
  RecipeModel? recipe;
  List<CuisineModel> cuisines = [];
  final RecipeService _service = RecipeService();

  Future<void> fetchById(String id) async {
    recipe = await _service.fetchById(id);
    notifyListeners();
  }

  Future<void> post(RecipeModel recipeModel, XFile sourceImage) async {
    RecipeModel? postedRecipe = await _service.post(recipeModel);
    String recipeId = postedRecipe!.id ?? "";
    final image = await _convertImage(sourceImage);
    if (image == null) return;

    recipe = await _service.uploadImage(image, recipeId);
    notifyListeners();
  }

  Future<dynamic> _convertImage(XFile sourceImage) async {
    if (!kIsWeb) return File(sourceImage.path);
    if (kIsWeb) return await sourceImage.readAsBytes();
    return null;
  }
}
