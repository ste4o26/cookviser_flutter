import 'package:demo_app/domain/cuisine/models/cuisine.model.dart';
import 'package:demo_app/domain/recipe/models/step.model.dart';
import 'package:demo_app/domain/user/models/user.model.dart';

class RecipeModel {
  String id;
  String name;
  String description;
  String? recipeThumbnail;
  int portions;
  int duration;
  String category;
  List<String> ingredients;
  String publisherUsername;
  CuisineModel cuisine;
  int overallRating;
  List<StepModel> steps;
  List<User>? cookedBy;

  RecipeModel(
      {required this.id,
      required this.name,
      required this.description,
      this.recipeThumbnail,
      required this.portions,
      required this.duration,
      required this.category,
      required this.ingredients,
      required this.publisherUsername,
      required this.cuisine,
      required this.overallRating,
      required this.steps,
      this.cookedBy});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      recipeThumbnail: json['recipeThumbnail'] ?? json['recipeThumbnail'],
      portions: json['portions'],
      duration: json['duration'],
      category: json['category'],
      ingredients:
          (json['ingredients'] as List).map((i) => i.toString()).toList(),
      publisherUsername: json['publisherUsername'],
      cuisine: CuisineModel.fromJson(json['cuisine']),
      overallRating: json['overallRating'],
      steps: (json['steps'] as List)
          .map((step) => StepModel.fromJson(step))
          .toList(),
      cookedBy: json['cookedBy'] != null
          ? (json['cookedBy'] as List).map((u) => User.fromJson(u)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['recipeThumbnail'] = recipeThumbnail;
    data['portions'] = portions;
    data['duration'] = duration;
    data['category'] = category;
    data['ingredients'] = ingredients;
    data['publisherUsername'] = publisherUsername;
    data['cuisine'] = cuisine.toJson();
    data['overallRating'] = overallRating;
    data['steps'] = steps.map((v) => v.toJson()).toList();
    data['cookedBy'] = cookedBy!.map((v) => v.toJson()).toList();
    return data;
  }
}
