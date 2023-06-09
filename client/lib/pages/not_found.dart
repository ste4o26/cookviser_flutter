import 'package:demo_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundPage extends StatelessWidget {
  final String? error;
  const NotFoundPage({this.error, super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color.fromRGBO(227, 222, 209, 0.5),
      body: Column(children: [
        const NotFoundCode(),
        Container(
            alignment: Alignment.center,
            child: const Text(
              'Page Not Found',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            )),
        const Text('The page you are looking for does not seem to exists'),
        Text('Error: $error'),
        TextButton(
            child: const Text('Home Page'),
            onPressed: () => context.go(Routes.home.name)),
      ]));
}

class NotFoundCode extends StatelessWidget {
  const NotFoundCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
      Text('4',
          style: TextStyle(
            fontSize: 350,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 19, 194, 254),
          )),
      Text('0',
          style: TextStyle(
            fontSize: 350,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 19, 194, 254),
          )),
      Text('4',
          style: TextStyle(
            fontSize: 350,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 19, 194, 254),
          )),
    ]);
  }
}
