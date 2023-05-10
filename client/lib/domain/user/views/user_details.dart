import 'package:demo_app/domain/recipe/views/recipe_card.dart';
import 'package:demo_app/domain/user/models/user.dart';
import 'package:demo_app/shared/custom_scrollable_view.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final UserModel user;

  const UserDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (context, BoxConstraints constraints) => SingleChildScrollView(
            child: Container(
                constraints: BoxConstraints(
                  maxHeight: 800,
                  maxWidth: constraints.maxWidth,
                ),
                margin: const EdgeInsets.only(top: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Username: ${user.username}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Text('Email: ${user.email}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Text('Rating: ${user.overallRating}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      user.description,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Container(
                        constraints: BoxConstraints(
                          maxHeight: 400,
                          maxWidth: constraints.maxWidth,
                        ),
                        child: Column(
                          children: [
                            const Text('My Recipes',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            CustomScrollableView(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: user.myRecipes.length,
                                    itemBuilder: (context, index) => RecipeCard(
                                          recipe: user.myRecipes[index],
                                        ))),
                          ],
                        ))
                  ],
                )),
          ));
}
