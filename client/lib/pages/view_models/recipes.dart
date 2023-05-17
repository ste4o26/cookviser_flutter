import 'package:demo_app/domain/recipe/models/recipe.dart';
import 'package:demo_app/pages/view_models/pagination_view_model.dart';
import 'package:demo_app/services/recipe.dart';

class RecipeListViewModel extends PaginationViewModel<RecipeService> {
  List<RecipeModel> recipes = [];

  RecipeListViewModel() : super(RecipeService());

  Future<void> fetchByPageAndByCuisine(String name, int page) async {
    recipes = await service.fetchByPageAndByCuisine(name, page);
    notifyListeners();
  }

  Future<void> fetchByPage(int page) async {
    recipes = await service.fetchByPage(page);
    await updateHasNextPage(page, recipes.length);
    notifyListeners();
  }

  Future<void> fetchAll() async {
    recipes = await service.fetchAll();
    notifyListeners();
  }

  Future<void> search(String value) async {
    recipes = await service.search(value);
    notifyListeners();
  }
}
