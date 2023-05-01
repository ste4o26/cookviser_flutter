import 'dart:convert';

import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/rating/models/rating.dart';
import 'package:demo_app/domain/recipe/models/recipe.dart';
import 'package:demo_app/services/auth.dart';
import 'package:demo_app/services/base.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// TODO handle the requests properly!
class RecipeService with BaseService {
  final AuthService _service = AuthService();
  static const commonHeaders = {'Content-Type': 'application/json; charset=UTF-8'};

  Future<List<RecipeModel>> fetchNextPageByCuisine(String name, int page,
      {int count = 10}) async {
    final Map<String, String> args = {
      'cuisineName': name,
      'pageNumber': page.toString(),
      'recipesCount': count.toString()
    };

    Uri uri = constructURI(RecipeEndpoints.nextPageByCuisine.endpoint, args: args);
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

// TODO remove the user token parameter since it can be accessed via Auth service
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

  Future<RecipeModel?> post(RecipeModel recipe) async {
    final uri = constructURI(RecipeEndpoints.create.endpoint);
    final requestBody = jsonEncode(recipe.toJson());
    final String? token = await _service.getToken();
    final headers = {'Authorization': 'Bearer $token'};

    headers.addAll(commonHeaders);
    final response = await http.post(uri, body: requestBody, headers: headers);
    if (response.statusCode != 201) {
      throw Exception('Unable to perform request!');
    }

    final data = jsonDecode(response.body);
    return RecipeModel.fromJson(data);
  }

  Future<RecipeModel?> uploadImage(Uint8List webImage, String recipeId) async {
    Uri uri = constructURI(
      RecipeEndpoints.uploadImage.endpoint,
      args: {'recipeId': recipeId},
    );

    var request = http.MultipartRequest('POST', uri);
    final String? token = await _service.getToken();
    final headers = {'Authorization': 'Bearer $token'};
    request.headers.addAll(headers);

    final image = http.MultipartFile.fromBytes(
      'image',
      webImage,
      filename: 'recipe_image.jpg',
    );
    request.files.add(image);

    final http.StreamedResponse responseStream = await request.send();
    final response = await http.Response.fromStream(responseStream);
    final data = jsonDecode(response.body);
    return RecipeModel.fromJson(data);
  }

  Future<RecipeModel> fetchById(String recipeId) async {
    Uri uri = constructURI(
      RecipeEndpoints.byId.endpoint,
      args: {'recipeId': recipeId},
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Unable to perform request!');
    }

    final data = jsonDecode(response.body);
    return RecipeModel.fromJson(data);
  }
}
