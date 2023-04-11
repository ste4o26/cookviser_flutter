import "dart:convert";
import "package:demo_app/domain/auth/view_models/login.view_model.dart";
import "package:demo_app/domain/auth/view_models/register.view_model.dart";
import "package:demo_app/domain/user/models/user.model.dart";
import "package:demo_app/services/base.service.dart";
import "package:http/http.dart" as http;

// TODO handle the requests properly!
class AuthService with BaseService {
  static const commonHeaders = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  static const Map<String, String> endpoints = {
    "login": "auth/login",
    "register": "auth/register",
  };

  Future<UserModel> register(UserRegisterViewModel user) async {
    Uri uri = this.constructURI(endpoints["register"] ?? "");
    final requestBody = jsonEncode(user.toJson());
    final response =
        await http.post(uri, body: requestBody, headers: commonHeaders);

    final data = jsonDecode(response.body);
    if (response.statusCode != 201) throw Exception(data);
    return UserModel.fromJson(data);
  }

  Future<Map<String, dynamic>> login(UserLoginViewModel user) async {
    Uri uri = this.constructURI(endpoints["login"] ?? "");
    final requestBody = jsonEncode(user.toJson());
    final response =
        await http.post(uri, body: requestBody, headers: commonHeaders);

    if (response.statusCode == 401) throw Exception("Invalid credentials!");
    
    final data = jsonDecode(response.body);
    final token = response.headers["jwttoken"];
    return <String, dynamic> {
      "token": token,
      "user": UserModel.fromJson(data),
    };
  }
}
