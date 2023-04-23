import 'dart:convert';

import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/cuisine/models/cuisine.dart';
import 'package:demo_app/services/base.dart';
import 'package:http/http.dart' as http;

// TODO handle the requests properly!
class CuisineService with BaseService {
  Future<List<CuisineModel>> fetchAll() async {
    Uri uri = constructURI(CuisineEndpoints.all.endpoint);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((cuisine) => CuisineModel.fromJson(cuisine)).toList();
    }

    throw Exception('Unable to perform request!');
  }

  Future<List<CuisineModel>> fetchMostPopulated() async {
    Uri uri = constructURI(CuisineEndpoints.mostPopulated.endpoint);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((cuisine) => CuisineModel.fromJson(cuisine)).toList();
    }

    throw Exception('Unable to perform request!');
  }
}
