import 'package:demo_app/domain/cuisine/views/cuisine_list.view.dart';
import 'package:demo_app/shared/header.dart';
import 'package:demo_app/shared/pagination_bar.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_app/domain/cuisine/view_models/cuisine_list.view_model.dart';

class CuisinesPage extends StatefulWidget {
  const CuisinesPage({super.key});

  @override
  State<CuisinesPage> createState() => _CuisinesPageState();
}

class _CuisinesPageState extends State<CuisinesPage> {
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
      _future = Provider.of<CuisineListViewModel>(context, listen: false)
          .fetchByPage(this.page);
    });
  }

  @override
  void didChangeDependencies() {
    _future = Provider.of<CuisineListViewModel>(context, listen: false)
        .fetchByPage(page);
    super.didChangeDependencies();
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
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const CuisineList(),
        ),
        bottomNavigationBar: PaginationBar(
          page: page,
          callback: updatePageHandler,
        ),
      );
}
