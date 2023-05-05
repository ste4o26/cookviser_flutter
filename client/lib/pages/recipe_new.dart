import 'dart:io';

import 'package:demo_app/constants.dart' as constants;
import 'package:demo_app/domain/cuisine/models/cuisine.dart';
import 'package:demo_app/domain/recipe/models/recipe.dart';
import 'package:demo_app/pages/view_models/cuisines.dart';
import 'package:demo_app/pages/view_models/recipe.dart';
import 'package:demo_app/shared/dynamic_input_table.dart';
import 'package:demo_app/shared/form/input_field.dart';
import 'package:demo_app/shared/form/submit_button.dart';
import 'package:demo_app/shared/scaffold.dart';
import 'package:demo_app/utils/validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// TODO refactor this page to support editing of a recipe!!!
class RecipePage extends StatefulWidget {
  final String recipeId;

  const RecipePage({this.recipeId = "", super.key});

  @override
  State<StatefulWidget> createState() => _RecipePage();
}

class _RecipePage extends State<RecipePage> {
  final _formKey = GlobalKey<FormState>();
  final RecipeModel _recipe = RecipeModel.create();

  late XFile _image;
  late Future _recipeFuture;
  late Future _cuisinesFuture;

  FormState get state => _formKey.currentState!;

  bool validationHandler(String? arg) {
    if (!state.validate()) return false;
    state.save();
    return true;
  }

  void createHandler() {
    setState(() {
      _recipeFuture =
          Provider.of<RecipeViewModel>(context, listen: false).post(_recipe, _image);
    });
    context.go(constants.Routes.home.name);
  }

  void nameSaveHandler(String? name) => setState(() => _recipe.name = name);

  void categoryChangeHandler(String category) => setState(() {
        _recipe.category = category;
      });

  void cuisineChangeHandler(CuisineModel cuisine) =>
      setState(() => _recipe.cuisine = cuisine);

  void saveIngredientsHandler(String? ingredients) {
    if (ingredients == null) return;
    setState(() => _recipe.ingredients = ingredients.split(", ").toList());
  }

  void selectImageHandler() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() => _image = image);
  }

  @override
  void didChangeDependencies() {
    String id = widget.recipeId != '' ? widget.recipeId : _recipe.id ?? "";
    _recipeFuture = Provider.of<RecipeViewModel>(context, listen: false).fetchById(id);

    _cuisinesFuture =
        Provider.of<CuisineListViewModel>(context, listen: false).fetchAll();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => FutureBuilder(
          future: _recipeFuture,
          builder: (
            BuildContext context,
            AsyncSnapshot snapshot,
          ) =>
              snapshot.connectionState != ConnectionState.done
                  ? const Center(
                      child: SizedBox(
                      height: 150,
                      width: 150,
                      child: CircularProgressIndicator(),
                    ))
                  : AppScaffold(
                      body: Consumer<RecipeViewModel>(
                      builder: (
                        BuildContext context,
                        RecipeViewModel viewModel,
                        child,
                      ) =>
                          Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_recipe.name ?? "New Recipe",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                            Container(
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth * 0.5,
                                ),
                                child: const Divider(
                                  height: 10,
                                  thickness: 1,
                                )),
                            Form(
                              key: _formKey,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth * 0.4,
                                  maxHeight: constraints.maxHeight * 0.6,
                                ),
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    CustomInputField(
                                        icon: const Icon(Icons.label),
                                        labelText: 'Name',
                                        hintText: 'Recipe name',
                                        onChanged: (val) =>
                                            setState(() => _recipe.name = val),
                                        onSaved: (val) =>
                                            setState(() => _recipe.name = val)),
                                    CustomInputField(
                                        icon: const Icon(Icons.description),
                                        labelText: 'Description',
                                        hintText: 'Recipe description',
                                        validationCallback:
                                            FieldValidator.descriptionValidator,
                                        onChanged: validationHandler,
                                        onSaved: (val) => _recipe.description = val),
                                    CustomInputField(
                                        icon: const Icon(Icons.groups),
                                        labelText: 'Portions',
                                        hintText: 'Number of portions',
                                        keyboardType: TextInputType.number,
                                        validationCallback:
                                            FieldValidator.isNumberValidator,
                                        onChanged: validationHandler,
                                        onSaved: (val) =>
                                            _recipe.portions = int.parse(val ?? '1')),
                                    CustomInputField(
                                        icon: const Icon(Icons.timer),
                                        labelText: 'Duration',
                                        hintText: 'Total cooking time in minutes',
                                        keyboardType: TextInputType.number,
                                        validationCallback:
                                            FieldValidator.isNumberValidator,
                                        onChanged: validationHandler,
                                        onSaved: (val) =>
                                            _recipe.duration = int.parse(val ?? '1')),
                                    CustomInputField(
                                        icon: const Icon(Icons.format_list_numbered),
                                        labelText: 'Ingredients',
                                        hintText: 'All ingredients separated by ", "',
                                        keyboardType: TextInputType.number,
                                        validationCallback:
                                            FieldValidator.descriptionValidator,
                                        onChanged: validationHandler,
                                        onSaved: saveIngredientsHandler),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: DropdownButton(
                                            hint: const Text('Recipe category'),
                                            isExpanded: true,
                                            value: _recipe.category,
                                            onChanged: (category) =>
                                                categoryChangeHandler(category!),
                                            items: constants.Category.values
                                                .map((category) => DropdownMenuItem(
                                                      value: category.name,
                                                      child: Text(category.name),
                                                    ))
                                                .toList())),
                                    FutureBuilder(
                                        future: _cuisinesFuture,
                                        builder: (context, snapshot) => Padding(
                                            padding: const EdgeInsets.only(top: 20),
                                            child: Consumer<CuisineListViewModel>(
                                                builder: (
                                              BuildContext context,
                                              CuisineListViewModel viewModel,
                                              child,
                                            ) =>
                                                    DropdownButton(
                                                      hint: const Text('Recipe cuisine'),
                                                      isExpanded: true,
                                                      value: _recipe.cuisine,
                                                      onChanged: (cuisine) =>
                                                          cuisineChangeHandler(
                                                              cuisine as CuisineModel),
                                                      items: viewModel.cuisines
                                                          .map((cuisine) =>
                                                              DropdownMenuItem(
                                                                value: cuisine,
                                                                child: Text(cuisine.name!),
                                                              ))
                                                          .toSet()
                                                          .toList(),
                                                    )))),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: DynamicInputTable(data: _recipe.steps ?? [])),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Column(children: [
                                          TextButton(
                                              onPressed: selectImageHandler,
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(8),
                                                          side: const BorderSide(
                                                              width: 1,
                                                              color: Colors.black)))),
                                              child: const Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Text(
                                                    'Select Image',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20),
                                                  ))),
                                        ])),
                                    FormButton(
                                      content: 'Create',
                                      callback: createHandler,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))));
}
