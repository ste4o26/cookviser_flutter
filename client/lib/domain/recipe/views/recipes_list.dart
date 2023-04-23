import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/recipe/models/recipe.dart';
import 'package:demo_app/pages/view_models/recipes.dart';
import 'package:demo_app/domain/recipe/views/recipe_details.dart';
import 'package:demo_app/domain/recipe/views/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                crossAxisCount: constraints.maxWidth ~/ CUSTOM_CARD_SIZE,
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
