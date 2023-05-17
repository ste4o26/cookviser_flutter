import 'package:demo_app/domain/rating/views/rating.dart';
import 'package:demo_app/pages/view_models/recipes.dart';
import 'package:demo_app/shared/pagination_bar.dart';
import 'package:demo_app/shared/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

class PlutoRecipesPage extends StatefulWidget {
  final String cuisine;

  const PlutoRecipesPage({required this.cuisine, super.key});

  @override
  State<PlutoRecipesPage> createState() => PlutoRecipesPageState();
}

class PlutoRecipesPageState extends State<PlutoRecipesPage> {
  int _page = 0;
  late Future<void> _future;

  int get page => _page;

  set page(int page) {
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
    widget.cuisine != 'all' ? fetchByCuisine() : fetchAll();
  }

  void fetchByCuisine() =>
      _future = Provider.of<RecipeListViewModel>(context, listen: false)
          .fetchByPageAndByCuisine(widget.cuisine, page);

  void fetchAll() =>
      _future = Provider.of<RecipeListViewModel>(context, listen: false)
          .fetchByPage(page);

  void search(String value) => _future =
      Provider.of<RecipeListViewModel>(context, listen: false).search(value);

  @override
  Widget build(BuildContext context) => AppScaffold(
      body: LayoutBuilder(
          builder: (context, constraints) => FutureBuilder(
              future: _future,
              builder: (BuildContext context,
                      AsyncSnapshot<dynamic> snapshot) =>
                  snapshot.connectionState != ConnectionState.done
                      ? const Center(
                          child: SizedBox(
                              height: 150,
                              width: 150,
                              child: CircularProgressIndicator()))
                      : Consumer<RecipeListViewModel>(
                          builder: (context, viewModel, child) => PlutoGrid(
                            configuration: const PlutoGridConfiguration(
                                columnSize: PlutoGridColumnSizeConfig(
                                    autoSizeMode: PlutoAutoSizeMode.none)),
                            columns: [
                              PlutoColumn(
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  readOnly: true,
                                  title: 'Image',
                                  field: 'Image',
                                  type: PlutoColumnType.text(),
                                  renderer: (contextR) => Image(
                                      // fit: BoxFit.fill,
                                      image:
                                          NetworkImage(contextR.cell.value))),
                              PlutoColumn(
                                titleTextAlign: PlutoColumnTextAlign.center,
                                textAlign: PlutoColumnTextAlign.center,
                                readOnly: true,
                                title: 'Recipe name',
                                field: 'Name',
                                type: PlutoColumnType.text(),
                              ),
                              PlutoColumn(
                                titleTextAlign: PlutoColumnTextAlign.center,
                                textAlign: PlutoColumnTextAlign.center,
                                readOnly: true,
                                title: 'Cuisine',
                                field: 'Cuisine',
                                type: PlutoColumnType.text(),
                              ),
                              PlutoColumn(
                                titleTextAlign: PlutoColumnTextAlign.center,
                                textAlign: PlutoColumnTextAlign.center,
                                readOnly: true,
                                title: 'Description',
                                field: 'Description',
                                type: PlutoColumnType.text(),
                              ),
                              PlutoColumn(
                                readOnly: true,
                                titleTextAlign: PlutoColumnTextAlign.center,
                                textAlign: PlutoColumnTextAlign.center,
                                title: 'Publisher',
                                field: 'Publisher',
                                type: PlutoColumnType.text(),
                              ),
                              PlutoColumn(
                                titleTextAlign: PlutoColumnTextAlign.center,
                                textAlign: PlutoColumnTextAlign.center,
                                readOnly: true,
                                title: 'Potions',
                                field: 'Portions',
                                type: PlutoColumnType.number(),
                              ),
                              PlutoColumn(
                                titleTextAlign: PlutoColumnTextAlign.center,
                                textAlign: PlutoColumnTextAlign.center,
                                readOnly: true,
                                title: 'Duration',
                                field: 'Duration',
                                type: PlutoColumnType.number(),
                              ),
                              PlutoColumn(
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  title: 'Rating',
                                  field: 'Rating',
                                  readOnly: true,
                                  type: PlutoColumnType.text(),
                                  renderer: (contextR) =>
                                      Rating(contextR.cell.value)),
                            ],
                            rows: viewModel.recipes
                                .map(
                                  (e) => PlutoRow(
                                    cells: {
                                      "Image":
                                          PlutoCell(value: e.recipeThumbnail),
                                      'Name': PlutoCell(value: e.name),
                                      'Description':
                                          PlutoCell(value: e.description),
                                      'Cuisine':
                                          PlutoCell(value: e.cuisine!.name),
                                      'Publisher':
                                          PlutoCell(value: e.publisherUsername),
                                      'Portions': PlutoCell(value: e.portions),
                                      'Duration': PlutoCell(value: e.duration),
                                      'Rating': PlutoCell(value: e),
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ))),
      bottomNavigationBar:
          Consumer<RecipeListViewModel>(builder: (context, viewModel, _) {
        return PaginationBar(
          page: page,
          callback: updatePageHandler,
          hasNextPage: viewModel.hasNextPage,
        );
      }));
}
