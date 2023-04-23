import 'package:flutter/material.dart';

class PaginationBar extends StatelessWidget {
  final int page;
  final Function callback;

  const PaginationBar({
    super.key,
    required this.page,
    required this.callback,
  });

  void prevPageHandler() => callback(page - 1);

  void nextPageHandler() => callback(page + 1);

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
                  onPressed: prevPageHandler,
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              Text('${page + 1}'),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: nextPageHandler,
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      );
}
