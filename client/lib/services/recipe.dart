import 'dart:convert';

import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/rating/models/rating.dart';
import 'package:demo_app/domain/recipe/models/recipe.dart';
import 'package:demo_app/services/base.dart';
import 'package:http/http.dart' as http;

// TODO handle the requests properly!
class RecipeService with BaseService {
  static const commonHeaders = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  Future<List<RecipeModel>> fetchNextPageByCuisine(String name, int page,
      {int count = 10}) async {
    final Map<String, String> args = {
      'cuisineName': name,
      'pageNumber': page.toString(),
      'recipesCount': count.toString()
    };

    Uri uri =
        constructURI(RecipeEndpoints.nextPageByCuisine.endpoint, args: args);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Unable to perform request!');
    }

    final data = jsonDecode(response.body) as List;
    return data.map((cuisine) => RecipeModel.fromJson(cuisine)).toList();
  }

  Future<List<RecipeModel>> fetchNextPage(int page, {int count = 10}) async {
    final Map<String, String> args = {
      'pageNumber': page.toString(),
      'recipesCount': count.toString(),
    };

    Uri uri = constructURI(RecipeEndpoints.nextPage.endpoint, args: args);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Unable to perform request!');
    }

    final data = jsonDecode(response.body) as List;
    return data.map((cuisine) => RecipeModel.fromJson(cuisine)).toList();
  }

  Future<List<RecipeModel>> fetchAll() async {
    Uri uri = constructURI(RecipeEndpoints.all.endpoint);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Unable to perform request!');
    }

    final data = jsonDecode(response.body) as List;
    return data.map((cuisine) => RecipeModel.fromJson(cuisine)).toList();
  }

  Future<List<RecipeModel>> fetchBestFour() async {
    Uri uri = constructURI(RecipeEndpoints.bestFour.endpoint);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Unable to perform request!');
    }

    final data = jsonDecode(response.body) as List;
    return data.map((recipe) => RecipeModel.fromJson(recipe)).toList();
  }

  Future<RatingModel> rate(RatingModel rating, String userToken) async {
    final uri = constructURI(RecipeEndpoints.rate.endpoint);
    final requestBody = jsonEncode(rating.toJson());
    final headers = {'Authorization': 'Bearer $userToken'};
    headers.addAll(commonHeaders);
    final response = await http.post(uri, body: requestBody, headers: headers);
    if (response.statusCode != 201) {
      throw Exception('Unable to perform request!');
    }
    final data = jsonDecode(response.body);
    return RatingModel.fromJson(data);
  }
}
