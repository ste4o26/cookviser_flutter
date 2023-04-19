import 'dart:ui';

import 'package:demo_app/domain/recipe/views_models/most_rated_recipes.view_model.dart';
import 'package:demo_app/shered/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MostRatedRecipes extends StatelessWidget {
  const MostRatedRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<MostRatedRecipesViewModel>(context, listen: false).fetch();
    return Container(
      margin: const EdgeInsets.only(top: 50),
      width: MediaQuery.of(context).size.width / 1.2,
      height: 450,
      child: Column(
        children: [
          const Expanded(
            child: Text(
              "Most Rated Recipes: ",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 350,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Consumer<MostRatedRecipesViewModel>(
                    builder: (context, viewModel, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.recipes.length,
                    itemBuilder: (context, index) {
                      return RecipeCard(recipe: viewModel.recipes[index]);
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
