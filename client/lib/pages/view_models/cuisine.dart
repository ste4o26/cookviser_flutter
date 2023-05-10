import 'package:demo_app/domain/cuisine/models/cuisine.dart';
import 'package:demo_app/services/cuisine.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CuisineViewModel extends ChangeNotifier {
  final CuisineService _service = CuisineService();

  Future<void> register(CuisineModel cuisine, XFile image) async {
    await _service.create(cuisine, image);
    notifyListeners();
  }
}
