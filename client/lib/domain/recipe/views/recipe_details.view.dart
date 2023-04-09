import "dart:core";
import "package:flutter/material.dart";

import 'package:demo_app/domain/recipe/views/recipe_ingredients.view.dart';
import 'package:demo_app/domain/recipe/views/recipe_stepper.view.dart';
import "package:demo_app/domain/recipe/views_models/recipe.view_model.dart";
import "package:demo_app/shered/image.dart";

class RecipeDialog extends StatelessWidget {
  final RecipeViewModel recipe;

  RecipeDialog(this.recipe, {super.key}) {
    recipe.steps.sort((first, second) => first.number.compareTo(second.number));
  }

  get steps => recipe.steps
      .map((step) => Step(
            title: const Text(""),
            content: Text(step.content),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                recipe.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(color: Colors.amber, height: 30),
              CustomImage(recipe.imageUrl, height: 200),
              const SizedBox(height: 30),
              Center(child: Text(recipe.description)),
              const SizedBox(height: 30),
              RecipeIngredients(recipe.ingredients),
              const SizedBox(height: 30),
              Column(
                children: [
                  const Text(
                    "Steps",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  ModalStepper(this.steps)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
