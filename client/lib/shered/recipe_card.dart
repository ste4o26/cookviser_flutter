import 'package:demo_app/domain/recipe/views/recipe_details.view.dart';
import 'package:demo_app/domain/recipe/views_models/recipe.view_model.dart';
import 'package:demo_app/shered/card.dart';
import 'package:demo_app/shered/image.dart';
import 'package:demo_app/shered/rating.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final RecipeViewModel recipe;

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
            child: CustomImage(recipe.imageUrl),
          ),
          Text(
            recipe.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            "Cuisine: ${recipe.cuisineName}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
           Rating(recipe.recipe),
        ],
      );
}
