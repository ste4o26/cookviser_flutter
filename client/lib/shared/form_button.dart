import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final String content;
  final dynamic callback;

  const FormButton({
    required this.content,
    required this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
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
          child: Text(content),
          onPressed: () => callback(),
        ),
      );
}
