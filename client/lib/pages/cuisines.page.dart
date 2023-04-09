import "package:demo_app/domain/cuisine/view_models/cuisine.view_model.dart";
import 'package:demo_app/domain/cuisine/views/cuisine_list.view.dart';
import "package:demo_app/shered/header.dart";
import "package:demo_app/shered/pagination_bar.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:demo_app/domain/cuisine/view_models/cuisine_list.view_model.dart";

class CuisinesPage extends StatefulWidget {
  const CuisinesPage({super.key});

  @override
  _CuisinesPageState createState() => _CuisinesPageState();
}

class _CuisinesPageState extends State<CuisinesPage> {
  int _page = 0;

  int get page => this._page;

  void set page(int page) {
    if (page < 0) return;
    this._page = page;
  }

  void updatePageHandler(int page) {
    if (page == this.page) return;

    setState(() {
      this.page = page;
      Provider.of<CuisineListViewModel>(context, listen: false)
          .fetchByPage(this.page);
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CuisineListViewModel>(context, listen: false)
        .fetchByPage(this.page);
  }

  @override
  Widget build(BuildContext context) {
    List<CuisineViewModel> cuisines =
        Provider.of<CuisineListViewModel>(context).cuisines;

    return Scaffold(
      appBar: const Header(),
      body: const CuisineList(),
      bottomNavigationBar: PaginationBar(
        page: this.page,
        callback: updatePageHandler,
      ),
    );
  }
}
