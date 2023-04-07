import 'dart:core';

import 'package:demo_app/domain/recipe/views/recipe_description.dart';
import 'package:demo_app/domain/recipe/views/recipe_image.dart';
import 'package:demo_app/domain/recipe/views/recipe_ingredients.dart';
import 'package:demo_app/domain/recipe/views/recipe_name.dart';
import 'package:demo_app/domain/recipe/views/recipe_stepper.dart';
import 'package:flutter/material.dart';

import '../views_models/recipe.view_model.dart';

class RecipeModal extends StatefulWidget {
  final RecipeViewModel recipe;

  const RecipeModal(this.recipe, {super.key});

  @override
  State<RecipeModal> createState() => _RecipeModalState();
}

class _RecipeModalState extends State<RecipeModal> {
  @override
  Widget build(BuildContext context) {
    widget.recipe.steps.sort((e1, e2) => e1.number!.compareTo(e2.number!));
    return AlertDialog(
      content: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RecipeImage(widget.recipe.imageUrl),
              const SizedBox(
                height: 30,
              ),
              RecipeName(widget.recipe.name),
              const SizedBox(
                height: 30,
              ),
              RecipeDescription(widget.recipe.description),
              const SizedBox(
                height: 30,
              ),
              RecipeIngredients(widget.recipe.ingredients),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Steps',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ModalStepper(widget.recipe.steps
                            .map((e) => Step(
                                title: Text('Step ${e.number}'),
                                content: Text(e.content)))
                            .toList())
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Center(
          child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.blue)),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Back",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
