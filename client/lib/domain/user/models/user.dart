import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/recipe/models/recipe.dart';

class UserModel {
  String id;
  String username;
  String email;
  String profileImageUrl;
  String description;
  Role role;
  List<Authority> authorities;
  List<RecipeModel> myRecipes;
  List<RecipeModel> myCookedRecipes;
  double overallRating;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.profileImageUrl,
    required this.description,
    required this.role,
    required this.authorities,
    required this.myRecipes,
    required this.myCookedRecipes,
    required this.overallRating,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final authoritiesData =
        json['authorities'] is List ? json['authorities'] as List : [];

    final userAuthorities = authoritiesData.map((authData) {
      switch (authData['authority']) {
        case 'UPDATE':
          return Authority.update;
        case 'DELETE':
          return Authority.delete;
        case 'WRITE':
          return Authority.write;
        default:
          return Authority.read;
      }
    }).toList();

    final recipesData =
        json['myRecipes'] is List ? json['myRecipes'] as List : [];
    final recipes = recipesData
        .map((recipeData) => RecipeModel.fromJson(recipeData))
        .toList();

    final cookedRecipesData =
        json['myCookedRecipes'] is List ? json['myCookedRecipes'] as List : [];
    final cookedRecipes = cookedRecipesData
        .map((recipeData) => RecipeModel.fromJson(recipeData))
        .toList();
    final role = json['role']['roleName'] == Role.admin.name
        ? Role.admin
        : json['role']['roleName'] == Role.moderator.name
            ? Role.moderator
            : Role.user;

    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      profileImageUrl: json['profileImageUrl'],
      description: json['description'],
      role: role,
      authorities: userAuthorities,
      myRecipes: recipes,
      myCookedRecipes: cookedRecipes,
      overallRating: json['overallRating'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    List userAuthorities =
        authorities.map((authority) => {'authority': authority.name}).toList();

    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['profileImageUrl'] = profileImageUrl;
    data['description'] = description;
    data['role'] = { "role": role.name};
    data['authorities'] = userAuthorities;
    data['myRecipes'] = myRecipes.map((e) => e.toJson()).toList();
    data['myCookedRecipes'] = myCookedRecipes.map((e) => e.toJson()).toList();
    data['overallRating'] = overallRating;
    return data;
  }
}
