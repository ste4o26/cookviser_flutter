import 'package:flutter/material.dart';
import 'package:demo_app/domain/cuisine/models/cuisine.model.dart';
import 'package:demo_app/services/cuisine.service.dart';
import 'package:demo_app/domain/cuisine/view_models/cuisine.view_model.dart';

class MostPopulatedCuisineViewModel extends ChangeNotifier {
  final CuisineService service = CuisineService();
  List<CuisineViewModel> cuisines = [];

  Future<void> fetch() async {
    List<CuisineModel> cuisines = await service.mostPopulated();
    this.cuisines = cuisines.map((cuisine) => CuisineViewModel(cuisine)).toList();
    notifyListeners();
  }
}