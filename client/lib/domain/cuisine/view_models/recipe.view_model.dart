import 'package:demo_app/domain/cuisine/models/recipe.model.dart';

class RecipeViewModel {
  final RecipeModel recipe;

  RecipeViewModel(this.recipe);

  String get name => recipe.name!;
  String get cuisineName=> recipe.cuisine!.name;
}