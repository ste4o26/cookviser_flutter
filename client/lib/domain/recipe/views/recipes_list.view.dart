import 'package:demo_app/domain/recipe/views/recipe_details.view.dart';
import "package:demo_app/domain/recipe/views_models/recipe.view_model.dart";
import "package:demo_app/domain/recipe/views_models/recipes_list.view_model.dart";
import "package:demo_app/shered/recipe_card.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

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
            return RecipeCard(recipe: viewModel.recipes[index]);
          },
        );
      },
    );
  }
}

//
