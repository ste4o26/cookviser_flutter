import 'package:demo_app/domain/recipe/models/recipe.model.dart';
import 'package:demo_app/domain/user/models/role.model.dart';

import 'authority.model.dart';

class UserModel {
  String id;
  String username;
  String email;
  String profileImageUrl;
  String description;
  RoleModel role;
  List<AuthorityModel> authorities;
  List<String> myRecipes;
  List<String> myCookedRecipes;
  int overallRating;

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
    var authoritiesData =
        json["authorities"] is List ? json["authorities"] as List : [];

    var userAuthorities = authoritiesData
        .map((authData) => AuthorityModel.fromJson(authData))
        .toList();

    var recipesData = json["myRecipes"] is List ? json["myRecipes"] as List : [];
    var recipes = recipesData
        .map((recipeData) => RecipeModel.fromJson(recipeData))
        .map((recipe) => recipe.name)
        .toList();

    var cookedRecipesData = json["myCookedRecipes"] is List ? json["myCookedRecipes"] as List : [];
    var cookedRecipes = cookedRecipesData
        .map((recipeData) => RecipeModel.fromJson(recipeData))
        .map((recipe) => recipe.name)
        .toList();

    return UserModel(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      profileImageUrl: json["profileImageUrl"],
      description: json["description"],
      role: RoleModel.fromJson(json['role']),
      authorities: userAuthorities,
      myRecipes: recipes,
      myCookedRecipes: cookedRecipes, // TODO convert like myRecipes
      overallRating: json["overallRating"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    List userAuthorities =
        authorities.map((authority) => authority.toJson()).toList();

    data["id"] = id;
    data["username"] = username;
    data["email"] = email;
    data["profileImageUrl"] = profileImageUrl;
    data["description"] = description;
    data["role"] = role.toJson();
    data["authorities"] = userAuthorities;
    data["myRecipes"] = myRecipes;
    data["myCookedRecipes"] = myCookedRecipes;
    data["overallRating"] = overallRating;
    return data;
  }
}
