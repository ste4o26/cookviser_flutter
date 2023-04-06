import 'dart:convert';

import 'package:demo_app/domain/recipe/views/recipe_modal.dart';
import 'package:demo_app/domain/recipe/views_models/recipe.view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

import '../models/recipe.model.dart';

class RecipeListView extends StatefulWidget {
  final Uri uri;

  const RecipeListView(this.uri, {super.key});

  @override
  _RecipeListViewState createState() => _RecipeListViewState(uri);
}

class _RecipeListViewState extends State<RecipeListView> {
  final Uri uri;

  _RecipeListViewState(this.uri);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.get(uri),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) throw Exception();

        final recipes = (jsonDecode(snapshot.data!.body) as List)
            .map((element) => RecipeViewModel(RecipeModel.fromJson(element)))
            .toList();

        return SingleChildScrollView(
          child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(30),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: InkWell(
                          child: RecipeImage(recipes[index].imageUrl),
                          onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) => Center(
                                    child: RecipeModal(recipes[index]),
                                  )),
                        ),
                      ),
                      RecipeName(recipes[index].name),
                      RecipeCuisine(recipes[index].cuisineName),
                      RecipeRating(recipes[index]),
                    ],
                  ),
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width ~/ 350,
              childAspectRatio: 1.0,
              crossAxisSpacing: 50,
              mainAxisSpacing: 50,
              mainAxisExtent: 264,
            ),
          ),
        );
      },
    );
  }
}

class RecipeImage extends StatelessWidget {
  final String url;

  const RecipeImage(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.fill,
      height: 164,
    );
  }
}

class RecipeName extends StatelessWidget {
  final String name;

  const RecipeName(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class RecipeCuisine extends StatelessWidget {
  final String cuisineName;

  const RecipeCuisine(this.cuisineName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          'Cuisine: $cuisineName',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class RecipeRating extends StatefulWidget {
  final RecipeViewModel recipe;

  const RecipeRating(this.recipe, {super.key});

  @override
  _RecipeRatingState createState() => _RecipeRatingState(recipe);
}

class _RecipeRatingState extends State<RecipeRating> {
  final RecipeViewModel recipe;

  _RecipeRatingState(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RatingBar.builder(
          itemSize: 25,
          maxRating: 5,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          onRatingUpdate: (rating) {},
        )
      ],
    );
  }
}
