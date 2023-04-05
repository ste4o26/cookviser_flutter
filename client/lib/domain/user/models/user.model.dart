import 'package:demo_app/domain/user/models/role.model.dart';

import 'authority.model.dart';

class User {
  String? id;
  String? username;
  String? email;
  String? profileImageUrl;
  String? description;
  RoleModel? role;
  List<AuthorityModel>? authorities;
  List<String>? myRecipes;
  List<String>? myCookedRecipes;
  int? overallRating;

  User(
      {this.id,
        this.username,
        this.email,
        this.profileImageUrl,
        this.description,
        this.role,
        this.authorities,
        this.myRecipes,
        this.myCookedRecipes,
        this.overallRating});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    profileImageUrl = json['profileImageUrl'];
    description = json['description'];
    role = json['role'] != null ? RoleModel.fromJson(json['role']) : null;
    if (json['authorities'] != null) {
      authorities = <AuthorityModel>[];
      json['authorities'].forEach((v) {
        authorities!.add(AuthorityModel.fromJson(v));
      });
    }
    myRecipes = json['myRecipes'].cast<String>();
    myCookedRecipes = json['myCookedRecipes'].cast<String>();
    overallRating = json['overallRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['profileImageUrl'] = profileImageUrl;
    data['description'] = description;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    if (authorities != null) {
      data['authorities'] = authorities!.map((v) => v.toJson()).toList();
    }
    data['myRecipes'] = myRecipes;
    data['myCookedRecipes'] = myCookedRecipes;
    data['overallRating'] = overallRating;
    return data;
  }
}