import 'package:demo_app/domain/auth/view_models/auth.view_model.dart';
import 'package:demo_app/domain/recipe/views/recipe_card_view.dart';
import 'package:demo_app/shared/custom_scrollable_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: 800,
            maxWidth: constraints.maxWidth,
          ),
          margin: const EdgeInsets.only(top: 100),
          child: Consumer<AuthViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Username: ${viewModel.user!.username}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Email: ${viewModel.user!.email}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Rating: ${viewModel.user!.overallRating}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    viewModel.user!.description,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 400,
                      maxWidth: constraints.maxWidth,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "My Recipes",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomScrollableView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: viewModel.user!.myRecipes.length,
                            itemBuilder: (context, index) {
                              return RecipeCard(
                                recipe: viewModel.user!.myRecipes[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
