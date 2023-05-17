import 'package:demo_app/domain/cuisine/views/cuisines_list.dart';
import 'package:demo_app/pages/view_models/cuisines.dart';
import 'package:demo_app/shared/pagination_bar.dart';
import 'package:demo_app/shared/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CuisinesPage extends StatefulWidget {
  const CuisinesPage({super.key});

  @override
  State<CuisinesPage> createState() => _CuisinesPageState();
}

class _CuisinesPageState extends State<CuisinesPage> {
  int _page = 0;
  late Future<void> _future;

  set page(int page) {
    if (page < 0) return;
    _page = page;
  }

  void updatePageHandler(int page) {
    if (page == _page) return;

    setState(() {
      this.page = page;
      _future =
          Provider.of<CuisineListViewModel>(context, listen: false).fetchByPage(_page);
    });
  }

  @override
  void didChangeDependencies() {
    _future =
        Provider.of<CuisineListViewModel>(context, listen: false).fetchByPage(_page);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
      body: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
            snapshot.connectionState != ConnectionState.done
                ? const Center(
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const CuisineList(),
      ),
      bottomNavigationBar: Consumer<CuisineListViewModel>(
          builder: (context, viewModel, child) => PaginationBar(
                page: _page,
                hasNextPage: viewModel.hasNextPage,
                callback: updatePageHandler,
              )));
}
