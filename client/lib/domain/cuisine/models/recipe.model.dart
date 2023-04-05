import 'package:demo_app/domain/cuisine/models/cuisine.model.dart';
import 'package:demo_app/domain/cuisine/models/step.model.dart';
import 'package:demo_app/domain/cuisine/models/user.model.dart';

class RecipeModel {
  String? id;
  String? name;
  String? description;
  String? recipeThumbnail;
  int? portions;
  int? duration;
  String? category;
  List<String>? ingredients;
  String? publisherUsername;
  CuisineModel? cuisine;
  int? overallRating;
  List<StepModel>? steps;
  List<User>? cookedBy;

  RecipeModel(
      {this.id,
        this.name,
        this.description,
        this.recipeThumbnail,
        this.portions,
        this.duration,
        this.category,
        this.ingredients,
        this.publisherUsername,
        this.cuisine,
        this.overallRating,
        this.steps,
        this.cookedBy});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    recipeThumbnail = json['recipeThumbnail'];
    portions = json['portions'];
    duration = json['duration'];
    category = json['category'];
    ingredients = json['ingredients'].cast<String>();
    publisherUsername = json['publisherUsername'];
    cuisine =
    json['cuisine'] != null ? CuisineModel.fromJson(json['cuisine']) : null;
    overallRating = json['overallRating'];
    if (json['steps'] != null) {
      steps = <StepModel>[];
      json['steps'].forEach((v) {
        steps!.add(StepModel.fromJson(v));
      });
    }
    if (json['cookedBy'] != null) {
      cookedBy = <User>[];
      json['cookedBy'].forEach((v) {
        cookedBy!.add(User.fromJson(v));
      });
    }
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
    if (cuisine != null) {
      data['cuisine'] = cuisine!.toJson();
    }
    data['overallRating'] = overallRating;
    if (steps != null) {
      data['steps'] = steps!.map((v) => v.toJson()).toList();
    }
    if (cookedBy != null) {
      data['cookedBy'] = cookedBy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}






