import "package:demo_app/constants.dart";
import "package:demo_app/domain/recipe/models/recipe.model.dart";
import "package:demo_app/domain/recipe/view_models/recipes_list.view_model.dart";
import 'package:demo_app/domain/recipe/views/recipe_details.view.dart';
import 'package:demo_app/domain/recipe/views/recipe_card_view.dart';
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class RecipeListView extends StatelessWidget {
  const RecipeListView({super.key});

  void openDialogHandler(BuildContext context, RecipeModel recipe) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Center(
        child: RecipeDialog(recipe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            Consumer<RecipeListViewModel>(
          builder: (context, viewModel, child) => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth ~/ customCardSize,
                crossAxisSpacing: 10,
                mainAxisSpacing: 50,
              ),
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: viewModel.recipes.length,
              itemBuilder: (context, index) =>
                  RecipeCard(recipe: viewModel.recipes[index])),
        ),
      );
}
