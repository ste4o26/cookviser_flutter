import "package:flutter/material.dart";

class RecipeIngredients extends StatelessWidget {
  final List<String> ingredients;

  const RecipeIngredients(this.ingredients, {super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Text(
            "Ingredients: ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 25),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ingredients.length,
            itemBuilder: (context, index) => ListTile(
              title: Center(child: Text(ingredients[index])),
            ),
          ),
        ],
      );
}
