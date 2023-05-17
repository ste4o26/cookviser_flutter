import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/recipe/views/recipes_list.dart';
import 'package:demo_app/pages/view_models/auth.dart';
import 'package:demo_app/pages/view_models/recipes.dart';
import 'package:demo_app/shared/pagination_bar.dart';
import 'package:demo_app/shared/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipesPage extends StatefulWidget {
  final String cuisine;

  const RecipesPage({required this.cuisine, super.key});

  @override
  State<RecipesPage> createState() => _RecipesState();
}

class _RecipesState extends State<RecipesPage> {
  int _page = 0;
  late Future<void> _future;

  // TODO keep state for is last page.

  void updatePageHandler(int page) => setState(() {
        _page = page;
        executeProvider();
      });

  @override
  void didChangeDependencies() {
    executeProvider();
    super.didChangeDependencies();
  }

  void executeProvider() {
    widget.cuisine != 'all' ? fetchByCuisine() : fetchByPage();
  }

  void fetchByCuisine() =>
      _future = Provider.of<RecipeListViewModel>(context, listen: false)
          .fetchByPageAndByCuisine(widget.cuisine, _page);

  void fetchByPage() => _future =
      Provider.of<RecipeListViewModel>(context, listen: false).fetchByPage(_page);

  void search(String value) =>
      _future = Provider.of<RecipeListViewModel>(context, listen: false).search(value);

  @override
  Widget build(BuildContext context) => AppScaffold(
      body: LayoutBuilder(
          builder: (context, constraints) => Consumer<AuthViewModel>(
              builder: (context, viewModel, child) => FutureBuilder(
                  future: _future,
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                      snapshot.connectionState != ConnectionState.done
                          ? const Center(
                              child: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: CircularProgressIndicator()))
                          : Container(
                              constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  if (viewModel.token != null && widget.cuisine == 'all')
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [_getSearchBar()],
                                    ),
                                  const RecipeListView(),
                                ],
                              ))))),
      bottomNavigationBar: Consumer<RecipeListViewModel>(
          builder: (context, viewModel, child) => PaginationBar(
                page: _page,
                hasNextPage: viewModel.hasNextPage,
                callback: updatePageHandler,
              )));

  Widget _getSearchBar() => Container(
      constraints: const BoxConstraints(maxWidth: CUSTOM_CARD_SIZE * 2),
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: TextFormField(
          onChanged: (value) => value.trim().length >= 5 ? search(value) : fetchByPage(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
          )));
}
