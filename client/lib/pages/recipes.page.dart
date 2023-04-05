import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/recipe/views/recipes_list.dart';
import 'package:flutter/material.dart';

const recipesUrl = '/recipe/next-by-cuisine';

class RecipesPage extends StatefulWidget {
  final String cuisineName;

  const RecipesPage(this.cuisineName, {super.key});

  @override
  _RecipesState createState() => _RecipesState(cuisineName);
}

class _RecipesState extends State<RecipesPage> {
  final String cuisineName;
  final int page = 0;
  final int count = 10;

  _RecipesState(this.cuisineName);

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse(
        '$DOMAIN_URL$recipesUrl?cuisineName=$cuisineName&pageNumber=$page&recipesCount=$count');
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
        child: RecipeListView(uri),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.navigate_before,
              color: Colors.blue,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          Text('$page'),
          const SizedBox(
            width: 40,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.navigate_next,
              color: Colors.blue,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
