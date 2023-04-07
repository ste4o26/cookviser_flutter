import 'dart:convert';

import 'package:demo_app/constants.dart';
import 'package:http/http.dart' as http;

class RegisterService {
  Future<void> register(userData) async {
    final requestBody = jsonEncode(userData);
    final response = await http.post(
      Uri.parse(REGISTER_URL),
      body: requestBody,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    final body = jsonDecode(response.body);
    if (response.statusCode != 201) {
      throw Exception(body);
    }
  }
}
