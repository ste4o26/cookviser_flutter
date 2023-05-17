import 'package:demo_app/constants.dart';
import 'package:demo_app/services/pagination.dart';
import 'package:flutter/material.dart';

class PaginationViewModel<S extends PaginationService> extends ChangeNotifier {
  final S service;
  bool hasNextPage = true;

  PaginationViewModel(this.service);

  Future<void> updateHasNextPage(int page, int entitiesCount) async {
    if (entitiesCount >= MAX_ENITITIES_PER_PAGE_COUNT) {
      final nextPageData = await service.fetchByPage(page + 1);
      hasNextPage = nextPageData.isNotEmpty;
    } else {
      hasNextPage = false;
    }
    notifyListeners();
  }
}
