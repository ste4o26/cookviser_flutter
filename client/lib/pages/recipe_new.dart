import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/cuisine/models/cuisine.dart';
import 'package:demo_app/domain/recipe/models/recipe.dart';
import 'package:demo_app/pages/view_models/cuisines.dart';
import 'package:demo_app/pages/view_models/recipe.dart';
import 'package:demo_app/shared/form/input_field.dart';
import 'package:demo_app/shared/form/submit_button.dart';
import 'package:demo_app/shared/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecipePage();
}

class _RecipePage extends State<RecipePage> {
  final _formKey = GlobalKey<FormState>();
  final RecipeModel _recipe = RecipeModel.create();
  late final Future _future;

  void createHandler() async {
    await Provider.of<RecipeViewModel>(context, listen: false).post(_recipe);
  }

  void categoryChangeHandler(String category) => setState(() {
        _recipe.category = category;
      });

  void cuisineChangeHandler(CuisineModel cuisine) {
    setState(() {
      _recipe.cuisine = cuisine;
    });
  }

  @override
  void didChangeDependencies() {
    _future =
        Provider.of<CuisineListViewModel>(context, listen: false).fetchAll();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot snapshot) =>
              AppScaffold(
            body: Consumer<RecipeViewModel>(
              builder: (
                BuildContext context,
                RecipeViewModel viewModel,
                child,
              ) =>
                  Center(
                child: Form(
                  key: _formKey,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth * 0.6,
                      maxHeight: constraints.maxHeight * 0.8,
                    ),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        CustomInputField(
                            labelText: 'Name',
                            onChanged: (val) => _recipe.name = val,
                            onSaved: (val) => _recipe.name = val),
                        CustomInputField(
                            labelText: 'Description',
                            onChanged: (val) => _recipe.description = val,
                            onSaved: (val) => _recipe.description = val),
                        CustomInputField(
                            labelText: 'Portions',
                            keyboardType: TextInputType.number,
                            onChanged: (val) => _recipe.portions = val as int?,
                            onSaved: (val) => _recipe.portions = val as int?),
                        CustomInputField(
                            labelText: 'Duration',
                            keyboardType: TextInputType.number,
                            onChanged: (val) => _recipe.duration = val as int?,
                            onSaved: (val) => _recipe.duration = val as int?),
                        DropdownButton(
                            value: _recipe.category,
                            onChanged: (category) =>
                                categoryChangeHandler(category!),
                            items: Category.values
                                .map((category) => DropdownMenuItem(
                                      value: category.name,
                                      child: Text(category.name),
                                    ))
                                .toList()),
                        Consumer<CuisineListViewModel>(
                          builder: (
                            BuildContext context,
                            CuisineListViewModel viewModel,
                            child,
                          ) =>
                              DropdownButton(
                            value: _recipe.cuisine,
                            onChanged: (cuisine) =>
                                cuisineChangeHandler(cuisine as CuisineModel),
                            items: viewModel.cuisines
                                .map((cuisine) => DropdownMenuItem(
                                      value: cuisine,
                                      child: Text(cuisine.name),
                                    ))
                                .toSet()
                                .toList(),
                          ),
                        ),
                        FormButton(
                          content: 'Create',
                          callback: createHandler,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
