import 'package:demo_app/domain/cuisine/models/cuisine.model.dart';
import 'package:demo_app/services/cuisine.service.dart';
import 'package:flutter/material.dart';

class CuisineListViewModel extends ChangeNotifier {
  final CuisineService service = CuisineService();
  List<CuisineModel> cuisines = [];

  Future<void> fetchByPage(int page) async {
    // TODO implement the logic for pagination in the backend
    cuisines = await service.fetchAll();
    notifyListeners();
  }
}
