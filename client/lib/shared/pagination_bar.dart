import 'package:flutter/material.dart';

class PaginationBar extends StatelessWidget {
  final int page;
  final bool hasNextPage;
  final Function callback;

  const PaginationBar({
    super.key,
    required this.page,
    required this.hasNextPage,
    required this.callback,
  });

  void prevPageHandler() async => await callback(page - 1);

  void nextPageHandler() async => await callback(page + 1);

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          width: 400,
          height: 50,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: page == 0 ? null : prevPageHandler,
                    child: const Icon(Icons.arrow_back),
                  )),
              Text('${page + 1}'),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                      onPressed: hasNextPage ? nextPageHandler : null,
                      child: const Icon(Icons.arrow_forward))),
            ],
          )));

//TODO make sure to sperate the logic for the pagination of the cuisines and the recipes
// A solutiion would be to make this widget statefull and to make it keep all the state needed for the pagination bar.
// For example to keep the current page number, instead of rece=ieving it also to keep it callbacks here
}
