import 'package:flutter/cupertino.dart';

class RecipeDescription extends StatelessWidget {
  final String description;

  const RecipeDescription(this.description, {super.key});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ],
      );
}
