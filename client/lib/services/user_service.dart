import 'dart:convert';

import 'package:demo_app/domain/user/models/user.model.dart';
import 'package:demo_app/services/base.service.dart';
import 'package:http/http.dart' as http;

class UserService with BaseService {
  static const Map<String, String> endpoints = {
    "top3": "user/best-three",
  };
  static const commonHeaders = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  Future<List<UserModel>> fetchBestThree() async {
    Uri uri = constructURI(endpoints["top3"] ?? "");
    final response = await http.get(uri, headers: commonHeaders);
    final data = jsonDecode(response.body) as List;
    if (response.statusCode != 200) throw Exception(data);
    return data.map((e) => UserModel.fromJson(e)).toList();
  }
}
