import 'package:flutter/material.dart';

import '../views_models/recipe.view_model.dart';

class RecipeModal extends StatefulWidget {
  final RecipeViewModel recipe;

  const RecipeModal(this.recipe, {super.key});

  @override
  _RecipeModalState createState() => _RecipeModalState(recipe);
}

class _RecipeModalState extends State<RecipeModal> {
  final RecipeViewModel recipe;
  int currentStep = 0;

  _RecipeModalState(this.recipe);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.network(
                recipe.imageUrl,
                height: 180,
                width: 250,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 36),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      recipe.description,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Text(
                    'Ingredients: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      recipe.ingredients
                          .toString()
                          .replaceAll('[', "")
                          .replaceAll("]", ""),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
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
                        Stepper(
                          currentStep: currentStep,
                          onStepTapped: (step) =>
                              setState(() => currentStep = step),
                          onStepContinue: () {
                            setState(() => currentStep =
                                currentStep < recipe.steps.length - 1
                                    ? currentStep + 1
                                    : currentStep);
                          },
                          onStepCancel: () {
                            setState(() => currentStep =
                                currentStep > 0 ? currentStep - 1 : 0);
                          },
                          steps: recipe.steps
                              .map((e) => Step(
                                  title: Text('Step ${e.number}'),
                                  content: Text(e.content!)))
                              .toList(),
                          controlsBuilder: (context, details) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      onPressed: details.onStepCancel,
                                      child: const Text("PREVIOUS")),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  TextButton(
                                    onPressed: details.onStepContinue,
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.blueAccent),
                                    ),
                                    child: const Text(
                                      "NEXT",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
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
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Back',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
