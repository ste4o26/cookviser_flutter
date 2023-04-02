import 'dart:convert';

import 'package:demo_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:demo_app/domain/cuisine/models/cuisine.model.dart';

class CuisineService {
  Future<List<CuisineModel>> fetchAll() async {
    Uri uri = Uri.http("${DOMAIN_URL}/cuisine/all");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data.map((cuisine) => CuisineModel.fromJson(cuisine)).toList();
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
