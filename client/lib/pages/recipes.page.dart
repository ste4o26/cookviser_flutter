import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/recipe/views/recipes_list.dart';
import 'package:flutter/material.dart';

class RecipesPage extends StatefulWidget {
  final String cuisineName;

  const RecipesPage(this.cuisineName, {super.key});

  @override
  State<RecipesPage> createState() => _RecipesState();
}

class _RecipesState extends State<RecipesPage> {
  int page = 0;
  int count = 10;

  @override
  Widget build(BuildContext context) {
    final url =
        '$RECIPE_URL/next-by-cuisine?cuisineName=${widget.cuisineName}&pageNumber=$page&recipesCount=$count';
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                'https://t4.ftcdn.net/jpg/05/73/60/21/240_F_573602169_n3iiMOh9Vu1iMDh2psCrpvNvZ7lK83QN.jpg',
              ),
              fit: BoxFit.cover),
        ),
        child: RecipeListView(url),
      ),
      bottomSheet: SizedBox(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              splashRadius: 1,
              onPressed: () {
                if (page > 0) {
                  setState(() {
                    page--;
                  });
                }
              },
              icon: const Icon(
                Icons.navigate_before,
                color: Colors.blue,
                size: 40,
              ),
            ),
            Text(
              '$page',
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              splashRadius: 1,
              onPressed: () {
                setState(() {
                  page++;
                });
              },
              icon: const Icon(
                Icons.navigate_next,
                color: Colors.blue,
                size: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
}
