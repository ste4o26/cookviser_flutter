import 'package:demo_app/pages/view_models/recipes.dart';
import 'package:demo_app/domain/recipe/views/recipes_list.dart';
import 'package:demo_app/shared/navigation/header.dart';
import 'package:demo_app/shared/pagination_bar.dart';
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
    if (widget.cuisine != "all") {
      _future = Provider.of<RecipeListViewModel>(context, listen: false)
          .fetchNextPageByCuisine(widget.cuisine ?? '', page);
    } else {
      _future = Provider.of<RecipeListViewModel>(context, listen: false)
          .fetchNextPage(page);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const Header(),
        body: FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
              snapshot.connectionState != ConnectionState.done
                  ? const Center(
                      child: SizedBox(
                          height: 150,
                          width: 150,
                          child: CircularProgressIndicator()))
                  : const RecipeListView(),
        ),
        bottomNavigationBar: PaginationBar(
          page: page,
          callback: updatePageHandler,
        ),
      );
}
