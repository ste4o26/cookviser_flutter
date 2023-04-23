import 'package:demo_app/domain/recipe/models/recipe.model.dart';
import 'package:demo_app/domain/recipe/views/recipe_details.view.dart';
import 'package:demo_app/shared/card.dart';
import 'package:demo_app/shared/image.dart';
import 'package:demo_app/shared/rating.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeCard({required this.recipe, super.key});

  @override
  Widget build(BuildContext context) => CustomCard(
        children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => Center(
                  child: RecipeDialog(recipe),
                ),
              );
            },
            child: CustomImage(recipe.recipeThumbnail),
          ),
          Text(
            recipe.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            'Cuisine: ${recipe.cuisine.name}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Rating(recipe),
        ],
      );
}
