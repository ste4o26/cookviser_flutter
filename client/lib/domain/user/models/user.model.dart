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
        json["autorities"] is List ? json["autorities"] as List : [];

    List<AuthorityModel> userAuthorities =
        authoritiesData.map((authData) => AuthorityModel.fromJson(authData))
            as List<AuthorityModel>;

    return UserModel(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      profileImageUrl: json["profileImageUrl"],
      description: json["description"],
      role: RoleModel.fromJson(json['role']),
      authorities: userAuthorities,
      myRecipes: json["myRecipes"],
      myCookedRecipes: json["myCookedRecipes"],
      overallRating: json["overallRating"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["username"] = username;
    data["email"] = email;
    data["profileImageUrl"] = profileImageUrl;
    data["description"] = description;
    data["role"] = role.toJson();
    data["authorities"] = authorities.map((authority) => authority.toJson()).toList();
    data["myRecipes"] = myRecipes;
    data["myCookedRecipes"] = myCookedRecipes;
    data["overallRating"] = overallRating;
    return data;
  }
}
