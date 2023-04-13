import "package:demo_app/domain/recipe/models/recipe.model.dart";
import "package:demo_app/domain/recipe/models/step.model.dart";

class RecipeViewModel {
  final RecipeModel recipe;

  RecipeViewModel(this.recipe);

  String get name => recipe.name;
  String get cuisineName=> recipe.cuisine.name;
  String get description => recipe.description;
  List<StepModel> get steps => recipe.steps;
  List<String> get ingredients => recipe.ingredients;
  String get imageUrl => recipe.recipeThumbnail;
  double get ratingOverall => recipe.overallRating;
}