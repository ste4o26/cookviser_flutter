import "dart:convert";
import "package:demo_app/domain/recipe/models/recipe.model.dart";
import "package:demo_app/services/base.service.dart";
import "package:http/http.dart" as http;

// TODO handle the requests properly!
class RecipeService with BaseService {
  static const endpoints = <String, String>{
    "next_page": "recipe/next-recipes",
    "next_by_cuisine": "recipe/next-by-cuisine",
    "all": "recipe/all",
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
    if (response.statusCode != 200) throw Exception("Unable to perform request!");

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
    if (response.statusCode != 200) throw Exception("Unable to perform request!");

    final data = jsonDecode(response.body) as List;
    return data.map((cuisine) => RecipeModel.fromJson(cuisine)).toList();
  }

  Future<List<RecipeModel>> fetchAll() async {
    Uri uri = this.constructURI(endpoints["all"] ?? "");
    final response = await http.get(uri);
    if (response.statusCode != 200) throw Exception("Unable to perform request!");

    final data = jsonDecode(response.body) as List;
    return data.map((cuisine) => RecipeModel.fromJson(cuisine)).toList();
  }
}
