import 'package:demo_app/domain/cuisine/models/cuisine.dart';
import 'package:demo_app/pages/view_models/pagination_view_model.dart';
import 'package:demo_app/services/cuisine.dart';

class CuisineListViewModel extends PaginationViewModel<CuisineService> {
  List<CuisineModel> cuisines = [];

  CuisineListViewModel() : super(CuisineService());

  Future<void> fetchByPage(int page) async {
    // TODO implement the logic for pagination in the backend
    cuisines = await service.fetchAll();
    await updateHasNextPage(page, cuisines.length);
    notifyListeners();
  }

  Future<void> fetchAll() async {
    cuisines = await service.fetchAll();
    notifyListeners();
  }
}
