import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final String content;
  final Function callback;
  final Map<String, dynamic> args;

  const FormButton({
    required this.content,
    required this.callback,
    this.args = const <String, dynamic>{},
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 40.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton(
        onPressed: () => this.callback(this.args),
        child: Text(this.content),
      ),
    );
  }
}
