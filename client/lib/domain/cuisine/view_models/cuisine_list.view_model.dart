import 'package:flutter/material.dart';
import 'package:demo_app/domain/cuisine/models/cuisine.model.dart';
import 'package:demo_app/services/cuisine.service.dart';
import 'package:demo_app/domain/cuisine/view_models/cuisine.view_model.dart';

class CuisineListViewModel extends ChangeNotifier {
  final CuisineService service = CuisineService();
  List<CuisineViewModel> cuisines = [];

  Future<void> fetchByPage(int page) async {
    // TODO implement the logic for pagination in the backend
    List<CuisineModel> cuisines = await this.service.fetchAll();
    this.cuisines = cuisines.map((cuisine) => CuisineViewModel(cuisine)).toList();
    notifyListeners();
  }
}
