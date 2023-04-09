import 'package:demo_app/domain/recipe/views/recipes_list.view.dart';
import "package:demo_app/domain/recipe/views_models/recipes_list.view_model.dart";
import "package:demo_app/shered/header.dart";
import "package:demo_app/shered/pagination_bar.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class RecipesPage extends StatefulWidget {
  final String? cuisineName;

  const RecipesPage({this.cuisineName, super.key});

  @override
  State<RecipesPage> createState() => _RecipesState();
}

class _RecipesState extends State<RecipesPage> {
  int _page = 0;
  // TODO keep state for is last page.

  int get page => this._page;

  void set page(int page) {
    if (page < 0) return;
    this._page = page;
  }

  void updatePageHandler(int page) {
    if (page == this.page) return;

    setState(() {
      this.page = page;
      this.executeProvider();
    });
  }

  @override
  void initState() {
    super.initState();
    this.executeProvider();
  }

  void executeProvider() {
    if (widget.cuisineName != null) {
      Provider.of<RecipeListViewModel>(context, listen: false)
          .fetchNextPageByCuisine(widget.cuisineName ?? "", this.page);
    } else {
      Provider.of<RecipeListViewModel>(context, listen: false)
          .fetchNextPage(this.page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Header(),
        body: const RecipeListView(),
        bottomNavigationBar: PaginationBar(
          page: this.page,
          callback: this.updatePageHandler,
        ));
  }
}
