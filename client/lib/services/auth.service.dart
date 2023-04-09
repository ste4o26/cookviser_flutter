import "dart:convert";
import "package:demo_app/domain/user/models/user.model.dart";
import "package:demo_app/services/base.service.dart";
import "package:http/http.dart" as http;

// TODO handle the requests properly!
class AuthService with BaseService {
  static const Map<String, String> endpoints = {
    "login": "auth/login",
    "register": "auth/register",
  };

  Future<void> register(userModel) async {
    // TODO refactor the register modal and then uncoment this
    // Uri uri = this.constructURI(endpoints["register"] ?? "");
    // final requestBody = jsonEncode(userModel.toJson());
    // final response = await http.post(
    //   uri,
    //   body: requestBody,
    //   headers: {"Content-Type": "application/json; charset=UTF-8"},
    // );
  
    // final body = jsonDecode(response.body);
    // if (response.statusCode != 201) throw Exception(body);
  }
}
