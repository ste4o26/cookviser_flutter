import 'dart:convert';
import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/user/models/user.dart';
import 'package:demo_app/services/auth.dart';
import 'package:demo_app/services/base.dart';
import 'package:http/http.dart' as http;

class UserService extends BaseService {
  final AuthService service = AuthService();

  Future<UserModel?> fetchByUsername(String username) async {
    final Map<String, String> args = {'username': username};
    Uri uri = constructURI(UserEndpoints.byUsername.endpoint, args: args);
    final token = await service.getToken();
    if (token == null) return null;

    final response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode != 200) {
      throw Exception('Unable to perform request!');
    }

    final data = jsonDecode(response.body);
    return UserModel.fromJson(data);
  }

  Future<List<UserModel>> fetchBestThree() async {
    Uri uri = constructURI(UserEndpoints.betsThree.endpoint);
    final response = await http.get(uri, headers: Headers.contentType.header);
    final data = jsonDecode(response.body) as List;
    if (response.statusCode != 200) {
      throw Exception('Unable to perform request!');
    }
    return data.map((e) => UserModel.fromJson(e)).toList();
  }
}
