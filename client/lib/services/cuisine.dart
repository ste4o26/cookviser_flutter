import 'dart:convert';
import 'dart:io';

import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/cuisine/models/cuisine.dart';
import 'package:demo_app/services/auth.dart';
import 'package:demo_app/services/base.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// TODO handle the requests properly!
class CuisineService with BaseService {
  final AuthService service = AuthService();

  Future<List<CuisineModel>> fetchAll() async {
    Uri uri = constructURI(CuisineEndpoints.all.endpoint);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((cuisine) => CuisineModel.fromJson(cuisine)).toList();
    }

    throw Exception('Unable to perform request!');
  }

  Future<List<CuisineModel>> fetchMostPopulated() async {
    Uri uri = constructURI(CuisineEndpoints.mostPopulated.endpoint);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((cuisine) => CuisineModel.fromJson(cuisine)).toList();
    }

    throw Exception('Unable to perform request!');
  }

  Future<CuisineModel> create(CuisineModel cuisine, XFile image) async {
    Uri uri = constructURI(CuisineEndpoints.create.endpoint);

    final headers = <String, String>{};
    headers.addAll(Headers.authorization.header);
    headers.addAll(Headers.contentType.header);
    final token = await service.getToken();
    headers['Authorization'] = '${headers['Authorization']}$token';

    final imageData = await image.readAsBytes();
    final file =
        http.MultipartFile.fromBytes('cuisineImage', imageData, filename: 'cuisineImage');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(file);
    request.fields.addAll({'name': cuisine.name!});
    request.headers.addAll(headers);

    final stream = await request.send();
    final response = await http.Response.fromStream(stream);

    final data = jsonDecode(response.body);
    if (response.statusCode != 201) throw Exception(data);
    return CuisineModel.fromJson(data);
  }
}
