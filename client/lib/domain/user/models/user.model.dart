import 'package:demo_app/domain/recipe/models/recipe.model.dart';
import 'package:demo_app/domain/user/models/role.model.dart';

import 'authority.model.dart';

class User {
  String id;
  String username;
  String email;
  String profileImageUrl;
  String description;
  RoleModel role;
  List<AuthorityModel> authorities;
  List<RecipeModel> myRecipes;
  List<RecipeModel> myCookedRecipes;
  int overallRating;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.profileImageUrl,
      required this.description,
      required this.role,
      required this.authorities,
      required this.myRecipes,
      required this.myCookedRecipes,
      required this.overallRating});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      profileImageUrl: json['profileImageUrl'],
      description: json['description'],
      role: RoleModel.fromJson(json['role']),
      authorities: (json['authorities'] as List)
          .map((a) => AuthorityModel.fromJson(a))
          .toList(),
      myRecipes: (json['myRecipes'] as List)
          .map((e) => RecipeModel.fromJson(e))
          .toList(),
      myCookedRecipes: (json['myCookedRecipes'] as List)
          .map((e) => RecipeModel.fromJson(e))
          .toList(),
      overallRating: json['overallRating'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['profileImageUrl'] = profileImageUrl;
    data['description'] = description;
    data['role'] = role.toJson();
    data['authorities'] = authorities.map((v) => v.toJson()).toList();
    data['myRecipes'] = myRecipes;
    data['myCookedRecipes'] = myCookedRecipes;
    data['overallRating'] = overallRating;
    return data;
  }
}
