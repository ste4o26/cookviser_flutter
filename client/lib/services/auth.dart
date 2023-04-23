import 'dart:convert';
import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/auth/models/login.dart';
import 'package:demo_app/domain/auth/models/register.dart';
import 'package:demo_app/domain/user/models/user.dart';
import 'package:demo_app/services/base.dart';
import 'package:demo_app/services/preference.dart';
import 'package:http/http.dart' as http;

class AuthService with BaseService {
  final PreferencesService preferencesService = PreferencesService();

  Future<UserModel> register(UserRegisterViewModel user) async {
    Uri uri = constructURI(AuthEndpoints.register.endpoint);
    final requestBody = jsonEncode(user.toJson());
    final response = await http.post(
      uri,
      body: requestBody,
      headers: Headers.contentType.header,
    );

    final data = jsonDecode(response.body);
    if (response.statusCode != 201) throw Exception(data);
    return UserModel.fromJson(data);
  }

  Future<Map<String, dynamic>> login(UserLoginViewModel user) async {
    Uri uri = constructURI(AuthEndpoints.login.endpoint);
    final requestBody = jsonEncode(user.toJson());
    final response = await http.post(
      uri,
      body: requestBody,
      headers: Headers.contentType.header,
    );

    if (response.statusCode == 401) throw Exception('Invalid credentials!');

    final data = jsonDecode(response.body);
    final userModel = UserModel.fromJson(data);

    final token = response.headers['jwttoken'];
    if (token == null) return const <String, dynamic>{};

    await preferencesService.setString('token', token);
    await preferencesService.setString('username', userModel.username);

    return <String, dynamic>{
      'token': token,
      'user': userModel,
    };
  }

  Future<void> logout() async {
    await preferencesService.remove('token');
    await preferencesService.remove('username');
  }

  Future<String?> getToken() async {
    return await preferencesService.getString('token');
  }

  Future<String?> getUsername() async {
    return await preferencesService.getString('username');
  }
}
