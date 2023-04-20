import "dart:convert";
import "package:demo_app/domain/auth/view_models/login.view_model.dart";
import "package:demo_app/domain/auth/view_models/register.view_model.dart";
import "package:demo_app/domain/user/models/user.model.dart";
import "package:demo_app/services/base.service.dart";
import "package:demo_app/services/preferences.service.dart";
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

  final PreferencesService preferencesService = PreferencesService();

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
    final userModel = UserModel.fromJson(data);
    
    final token = response.headers["jwttoken"];
    if (token == null) return const <String, dynamic>{};

    await this.preferencesService.setString("token", token);
    await this.preferencesService.setString("username", userModel.username);

    return <String, dynamic> {
      "token": token,
      "user": userModel,
    };
  }

  Future<void> logout() async {
    await this.preferencesService.remove("token");
    await this.preferencesService.remove("username");
  }

  Future<String?> getToken() async {
    return await this.preferencesService.getString("token");
  }

  Future<String?> getUsername() async {
    return await this.preferencesService.getString("username");
  }
}
