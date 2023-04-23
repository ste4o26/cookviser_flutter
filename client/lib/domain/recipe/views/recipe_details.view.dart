import 'dart:core';
import 'package:demo_app/domain/recipe/models/recipe.model.dart';
import 'package:demo_app/shared/image.dart';
import 'package:flutter/material.dart';

import 'package:demo_app/domain/recipe/views/recipe_ingredients.view.dart';
import 'package:demo_app/domain/recipe/views/recipe_stepper.view.dart';

class RecipeDialog extends StatelessWidget {
  final RecipeModel recipe;

  RecipeDialog(this.recipe, {super.key}) {
    recipe.steps.sort((first, second) => first.number.compareTo(second.number));
  }

  get steps => recipe.steps
      .map((step) => Step(
            title: const Text(''),
            content: Text(step.content),
          ))
      .toList();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Dialog(
          child: Container(
            width: constraints.maxWidth * 0.5,
            height: constraints.maxHeight * 0.5,
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
                  CustomImage(recipe.recipeThumbnail),
                  const SizedBox(height: 30),
                  Center(child: Text(recipe.description)),
                  const SizedBox(height: 30),
                  RecipeIngredients(recipe.ingredients),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      const Text(
                        'Steps',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      ModalStepper(steps)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
