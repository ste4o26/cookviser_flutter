import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:demo_app/domain/recipe/views_models/recipes_list.view_model.dart";
import "package:demo_app/shered/image.dart";
import 'package:demo_app/domain/recipe/views/recipe_details.view.dart';
import "package:demo_app/domain/recipe/views_models/recipe.view_model.dart";
import "package:demo_app/shered/card.dart";
import "package:demo_app/shered/rating.dart";

class RecipeListView extends StatelessWidget {
  const RecipeListView({super.key});

  void openDialogHandler(BuildContext context, RecipeViewModel recipe) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Center(
        child: RecipeDialog(recipe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeListViewModel>(
      builder: (context, viewModel, child) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 350,
            crossAxisSpacing: 10,
            mainAxisSpacing: 50,
          ),
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          itemCount: viewModel.recipes.length,
          itemBuilder: (context, index) {
            RecipeViewModel recipe = viewModel.recipes[index];

            return CustomCard(
              children: [
                InkWell(
                  onTap: () => this.openDialogHandler(context, recipe),
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
                const Rating(),
                //TODO make this a statefull widget and pass calback to rating to update the rate of the recipe.
              ],
            );
          },
        );
      },
    );
  }
}


// 