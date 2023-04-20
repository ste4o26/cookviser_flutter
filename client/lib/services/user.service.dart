import 'dart:convert';
import 'package:demo_app/domain/user/models/user.model.dart';
import 'package:demo_app/services/auth.service.dart';
import 'package:demo_app/services/base.service.dart';
import "package:http/http.dart" as http;


class UserService extends BaseService {
  final AuthService service = AuthService();

  static const Map<String, String> endpoints = {
    "by_username": "user/by-username",
  };

  // TODO think of a better way to attach the token whenever is needed!
  Future<UserModel?> fetchByUsername(String username) async {
    final Map<String, String> args = {"username": username};
    Uri uri = this.constructURI(endpoints["by_username"] ?? "", args: args);
    final token = await this.service.getToken();
    if (token == null) return null;

    final response = await http.get(uri, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode != 200) {
      throw Exception("Unable to perform request!");
    }

    final data = jsonDecode(response.body);
    return UserModel.fromJson(data);
  }
}
