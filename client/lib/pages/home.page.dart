import 'package:demo_app/domain/cuisine/views/most_populated_cuisine.view.dart';
import 'package:demo_app/domain/recipe/views/most_rated_recipes.view.dart';
import 'package:demo_app/domain/user/views/most_liked_users_view.dart';
import 'package:demo_app/shered/header.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: const [
            BestThreeUsers(),
            MostPopulatedCuisines(),
            MostRatedRecipes(),
          ],
        ),
      ),
    );
  }
}
