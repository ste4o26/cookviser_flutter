import "package:demo_app/domain/cuisine/models/cuisine.model.dart";
import "package:demo_app/domain/recipe/models/step.model.dart";
import "package:demo_app/domain/user/models/user.model.dart";

class RecipeModel {
  String id;
  String name;
  String description;
  String recipeThumbnail;
  int portions;
  int duration;
  String category;
  List<String> ingredients;
  String publisherUsername;
  CuisineModel cuisine;
  int overallRating;
  List<StepModel> steps;
  List<UserModel> cookedBy;

  RecipeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.recipeThumbnail,
    required this.portions,
    required this.duration,
    required this.category,
    required this.ingredients,
    required this.publisherUsername,
    required this.cuisine,
    required this.overallRating,
    required this.steps,
    required this.cookedBy,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    var ingredientsData = json["ingredients"] as List;
    var ingredients =
        ingredientsData.map((ingredient) => ingredient.toString()).toList();

    var stepsData = json["steps"] is List ? json["steps"] as List : [];
    var steps = stepsData.map((step) => StepModel.fromJson(step)).toList();

    var usersData = json["cookedBy"] is List ? json["cookedBy"] as List : [];
    var users = usersData.map((user) => UserModel.fromJson(user)).toList();

    return RecipeModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      //TODO remove the hardcoded url once the images publishing functionality is reade
      recipeThumbnail: json["recipeThumbnail"] ?? "https://picsum.photos/200/300",
      portions: json["portions"],
      duration: json["duration"],
      category: json["category"],
      ingredients: ingredients,
      publisherUsername: json["publisherUsername"],
      cuisine: CuisineModel.fromJson(json["cuisine"]),
      overallRating: json["overallRating"],
      steps: steps,
      cookedBy: users,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["recipeThumbnail"] = recipeThumbnail;
    data["portions"] = portions;
    data["duration"] = duration;
    data["category"] = category;
    data["ingredients"] = ingredients;
    data["publisherUsername"] = publisherUsername;
    data["cuisine"] = cuisine.toJson();
    data["overallRating"] = overallRating;
    data["steps"] = steps.map((v) => v.toJson()).toList();
    data["cookedBy"] = cookedBy.map((v) => v.toJson()).toList();
    return data;
  }
}
