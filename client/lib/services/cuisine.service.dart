import "dart:convert";

import "package:demo_app/constants.dart";
import "package:demo_app/domain/cuisine/models/cuisine.model.dart";
import "package:http/http.dart" as http;

// TODO handle the requests properly!
class CuisineService {
  Future<List<CuisineModel>> fetchAll() async {
    Uri uri = Uri.parse("$DOMAIN_URL/cuisine/all");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((cuisine) => CuisineModel.fromJson(cuisine)).toList();
    }

    throw Exception("Unable to perform request!");
  }

  Future<List<CuisineModel>> mostPopulated() async {
    Uri uri = Uri.parse("$DOMAIN_URL/cuisine/first-four-most-populated");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((cuisine) => CuisineModel.fromJson(cuisine)).toList();
    }

    throw Exception("Unable to perform request!");
  }
}
