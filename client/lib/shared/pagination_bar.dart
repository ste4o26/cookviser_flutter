import 'package:flutter/material.dart';

class PaginationBar extends StatelessWidget {
  final int page;
  final Function callback;

  const PaginationBar({required this.page, required this.callback, super.key});

  void prevPageHandler() => this.callback(this.page - 1);

  void nextPageHandler() => this.callback(this.page + 1);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                onPressed: this.prevPageHandler,
                child: const Icon(Icons.arrow_back),
              ),
            ),
            Text('${this.page + 1}'),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: this.nextPageHandler,
                child: const Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
