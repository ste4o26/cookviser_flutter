import 'package:demo_app/domain/cuisine/views/cuisine_card.dart';
import 'package:demo_app/domain/home/views/most_rated.dart';
import 'package:demo_app/domain/recipe/views/recipe_card.dart';
import 'package:demo_app/domain/user/views/user_card.dart';
import 'package:demo_app/pages/view_models/home.dart';
import 'package:demo_app/shared/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<void> _future;

  @override
  void didChangeDependencies() {
    _future = Provider.of<HomeViewModel>(context, listen: false).fetchInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
      body: FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
              snapshot.connectionState != ConnectionState.done
                  ? const Center(
                      child: SizedBox(
                          height: 150,
                          width: 150,
                          child: CircularProgressIndicator()))
                  : ListView(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      children: <Widget>[
                        MostRated(
                            title: 'Best chefs',
                            child: Consumer<HomeViewModel>(
                                builder: (context, viewModel, child) =>
                                    ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: viewModel.users.length,
                                      itemBuilder: (context, index) => UserCard(
                                          user: viewModel.users[index]),
                                    ))),
                        MostRated(
                            title: 'Best cuisines',
                            child: Consumer<HomeViewModel>(
                                builder: (context, viewModel, child) =>
                                    ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: viewModel.cuisines.length,
                                      itemBuilder: (context, index) =>
                                          CuisineCard(
                                              cuisine:
                                                  viewModel.cuisines[index]),
                                    ))),
                        MostRated(
                            title: 'Best recipes',
                            child: Consumer<HomeViewModel>(
                                builder: (context, viewModel, child) =>
                                    ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: viewModel.recipes.length,
                                      itemBuilder: (context, index) =>
                                          RecipeCard(
                                              recipe: viewModel.recipes[index]),
                                    )))
                      ],
                    )));
}
