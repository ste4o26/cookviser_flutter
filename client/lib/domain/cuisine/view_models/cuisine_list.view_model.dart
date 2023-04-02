import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_app/domain/cuisine/models/cuisine.model.dart';
import 'package:demo_app/domain/cuisine/services/cuisine.service.dart';
import 'package:demo_app/domain/cuisine/view_models/cuisine.view_model.dart';

class CuisineListViewModel extends ChangeNotifier{
  final CuisineService service = CuisineService();
  List<CuisineViewModel> cuisines = [];

  Future<void> fetchAll() async {
    List<CuisineModel> cuisines = await this.service.fetchAll();
    this.cuisines = cuisines.map((item) => CuisineViewModel(cuisine: item)).toList();
    notifyListeners();
  }
}
