import 'dart:convert';

import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/user/models/user.dart';
import 'package:demo_app/services/auth.dart';
import 'package:demo_app/services/base.dart';
import 'package:http/http.dart' as http;

class AdminService extends BaseService {
  final AuthService service = AuthService();

  Future<List<UserModel>> fetchAll() async {
    Uri uri = constructURI(UserEndpoints.allUsers.endpoint);
    final headers = <String, String>{};
    headers.addAll(Headers.authorization.header);
    headers.addAll(Headers.contentType.header);
    await service.getToken().then((value) =>
        headers["Authorization"] = '${headers["Authorization"]}$value');
    final response = await http.get(uri, headers: headers);
    final data = jsonDecode(response.body) as List;
    if (response.statusCode != 200) {
      throw Exception('Unable to perform request!');
    }
    return data.map((e) => UserModel.fromJson(e)).toList();
  }

  Future<UserModel> promote(String username) async {
    Uri uri = constructURI(UserEndpoints.promote.endpoint);
    final headers = <String, String>{};
    headers.addAll(Headers.authorization.header);
    headers.addAll(Headers.contentType.header);
    await service.getToken().then((value) =>
        headers["Authorization"] = '${headers["Authorization"]}$value');
    final response = await http.put(
      uri,
      body: username,
      headers: headers,
    );
    final data = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw Exception('Unable to perform request!');
    }
    return UserModel.fromJson(data);
  }

  Future<UserModel> demote(String username) async {
    Uri uri = constructURI(UserEndpoints.demote.endpoint);
    final headers = <String, String>{};
    headers.addAll(Headers.authorization.header);
    headers.addAll(Headers.contentType.header);
    await service.getToken().then((value) =>
    headers["Authorization"] = '${headers["Authorization"]}$value');
    final response = await http.put(
      uri,
      body: username,
      headers: headers,
    );
    final data = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw Exception('Unable to perform request!');
    }
    return UserModel.fromJson(data);
  }
}
