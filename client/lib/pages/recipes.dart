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

  int get page => _page;

  void set page(int page) {
    if (page < 0) return;
    _page = page;
  }

  void updatePageHandler(int page) {
    if (page == this.page) return;

    setState(() {
      this.page = page;
      executeProvider();
    });
  }

  @override
  void didChangeDependencies() {
    executeProvider();
    super.didChangeDependencies();
  }

  void executeProvider() {
    widget.cuisine != "all" ? fetchByCuisine() : fetchAll();
  }

  void fetchByCuisine() =>
      _future = Provider.of<RecipeListViewModel>(context, listen: false)
          .fetchNextPageByCuisine(widget.cuisine, page);

  void fetchAll() =>
      _future = Provider.of<RecipeListViewModel>(context, listen: false)
          .fetchNextPage(page);

  void search(String value) => _future =
      Provider.of<RecipeListViewModel>(context, listen: false).search(value);

  @override
  Widget build(BuildContext context) => AppScaffold(
      body: Consumer<AuthViewModel>(
        builder: (context, viewModel, child) => FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
              snapshot.connectionState != ConnectionState.done
                  ? const Center(
                      child: SizedBox(
                          height: 150,
                          width: 150,
                          child: CircularProgressIndicator()))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (viewModel.token != null && widget.cuisine == 'all')
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            width: CUSTOM_CARD_SIZE * 2,
                            child: TextFormField(
                              onChanged: (value) => value.trim().length >= 5
                                  ? search(value)
                                  : fetchAll(),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Search",
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                        const RecipeListView()
                      ],
                    ),
        ),
      ),
      bottomNavigationBar: PaginationBar(
        page: page,
        callback: updatePageHandler,
      ));
}
