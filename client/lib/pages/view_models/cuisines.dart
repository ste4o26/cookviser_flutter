import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/cuisine/models/cuisine.dart';
import 'package:demo_app/services/cuisine.dart';
import 'package:flutter/material.dart';

class CuisineListViewModel extends ChangeNotifier {
  final CuisineService _service = CuisineService();
  bool hasNextPage = true;
  List<CuisineModel> cuisines = [];

  Future<bool> hasNextCuisinePage(int page) async {
    if (cuisines.length >= MAX_RECIPES_PER_PAGE_COUNT) {
      // final nextPageCuisines = await _service.fetchNextPage(page + 1);
      final nextPageCuisines =
          []; // hardoced couse pagination is not supported for cuisines yet.
      return nextPageCuisines.isNotEmpty;
    } else {
      return false;
    }
  }

  Future<void> fetchByPage(int page) async {
    // TODO implement the logic for pagination in the backend
    cuisines = await _service.fetchAll();
    hasNextPage = await hasNextCuisinePage(page);
    notifyListeners();
  }

  Future<void> fetchAll() async {
    cuisines = await _service.fetchAll();
    notifyListeners();
  }
}
