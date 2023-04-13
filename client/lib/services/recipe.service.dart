import "dart:convert";

import 'package:demo_app/domain/rating/models/rating_model.dart';
import "package:demo_app/domain/recipe/models/recipe.model.dart";
import "package:demo_app/services/base.service.dart";
import "package:http/http.dart" as http;
import "package:provider/provider.dart";

// TODO handle the requests properly!
class RecipeService with BaseService {
  static const commonHeaders = {
    "Content-Type": "application/json; charset=UTF-8"
  };
  static const endpoints = <String, String>{
    "next_page": "recipe/next-recipes",
    "next_by_cuisine": "recipe/next-by-cuisine",
    "all": "recipe/all",
    "most_rated": "recipe/best-four",
    "rate": "recipe/rate",
  };

  Future<List<RecipeModel>> fetchNextPageByCuisine(String name, int page,
      {int count = 10}) async {
    final Map<String, String> args = {
      "cuisineName": name,
      "pageNumber": page.toString(),
      "recipesCount": count.toString()
    };

    Uri uri = this.constructURI(endpoints["next_by_cuisine"] ?? "", args: args);
    final response = await http.get(uri);
    if (response.statusCode != 200)
      throw Exception("Unable to perform request!");

    final data = jsonDecode(response.body) as List;
    return data.map((cuisine) => RecipeModel.fromJson(cuisine)).toList();
  }

  Future<List<RecipeModel>> fetchNextPage(int page, {int count = 10}) async {
    final Map<String, String> args = {
      "pageNumber": page.toString(),
      "recipesCount": count.toString(),
    };

    Uri uri = this.constructURI(endpoints["next_page"] ?? "", args: args);
    final response = await http.get(uri);
    if (response.statusCode != 200)
      throw Exception("Unable to perform request!");

    final data = jsonDecode(response.body) as List;
    return data.map((cuisine) => RecipeModel.fromJson(cuisine)).toList();
  }

  Future<List<RecipeModel>> fetchAll() async {
    Uri uri = this.constructURI(endpoints["all"] ?? "");
    final response = await http.get(uri);
    if (response.statusCode != 200)
      throw Exception("Unable to perform request!");

    final data = jsonDecode(response.body) as List;
    return data.map((cuisine) => RecipeModel.fromJson(cuisine)).toList();
  }

  Future<List<RecipeModel>> mostRated() async {
    Uri uri = constructURI(endpoints["most_rated"] ?? "");
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Unable to perform request!");
    }

    final data = jsonDecode(response.body) as List;
    return data.map((recipe) => RecipeModel.fromJson(recipe)).toList();
  }

  Future<RatingModel> rate(RatingModel rating, String token) async {
    final uri = constructURI(endpoints["rate"]!);
    final requestBody = jsonEncode(rating.toJson());
    final headers = {"Authorization": "Bearer $token"};
    headers.addAll(commonHeaders);
    final response = await http.post(uri, body: requestBody, headers: headers);
    if (response.statusCode != 201) {
      throw Exception("Unable to perform request!");
    }
    final data = jsonDecode(response.body);
    return RatingModel.fromJson(data);
  }
}
