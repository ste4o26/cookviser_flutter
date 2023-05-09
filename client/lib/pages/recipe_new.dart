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
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RecipePage extends StatefulWidget {
  final String recipeId;

  const RecipePage({this.recipeId = '', super.key});

  @override
  State<StatefulWidget> createState() => _RecipePage();
}

class _RecipePage extends State<RecipePage> {
  final _formKey = GlobalKey<FormState>();
  final RecipeModel _recipe = RecipeModel.create();

  late XFile _image;
  late Future _recipeFuture;
  late Future _cuisinesFuture;
  bool _isCreated = false;

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
      _isCreated = true;
    });
  }

  void nameSaveHandler(String? name) => setState(() => _recipe.name = name);

  void categoryChangeHandler(String category) =>
      setState(() => _recipe.category = category);

  void cuisineChangeHandler(CuisineModel cuisine) =>
      setState(() => _recipe.cuisine = cuisine);

  void saveIngredientsHandler(String ingredients) =>
      setState(() => _recipe.ingredients = ingredients.split(", ").toList());

  void selectImageHandler() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() => _image = image);
  }

  @override
  void didChangeDependencies() {
    String id = widget.recipeId != '' ? widget.recipeId : _recipe.id ?? '';
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
                                  Text(
                                      _isCreated
                                          ? viewModel.recipe.name ?? 'New Recipe'
                                          : _recipe.name ?? 'New Recipe',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 20)),
                                  Container(
                                      constraints: BoxConstraints(
                                          maxWidth: constraints.maxWidth * 0.5),
                                      child: const Divider(
                                        height: 10,
                                        thickness: 1,
                                      )),
                                  _getRecipeForm(constraints),
                                ],
                              ))))));

  Widget _getRecipeForm(BoxConstraints constraints) => Consumer<RecipeViewModel>(
      builder: (context, viewModel, child) => Form(
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
                      initialValue: viewModel.recipe.name ?? '',
                      enabled: !_isCreated,
                      labelText: 'Name',
                      hintText: 'Recipe name',
                      onChanged: (val) => setState(() => _recipe.name = val),
                      onSaved: (val) => setState(() => _recipe.name = val)),
                  CustomInputField(
                      icon: const Icon(Icons.description),
                      initialValue: _recipe.description ?? '',
                      enabled: !_isCreated,
                      labelText: 'Description',
                      hintText: 'Recipe description',
                      validationCallback: FieldValidator.descriptionValidator,
                      onChanged: validationHandler,
                      onSaved: (val) => _recipe.description = val),
                  CustomInputField(
                      icon: const Icon(Icons.groups),
                      initialValue: viewModel.recipe.portions.toString(),
                      enabled: !_isCreated,
                      labelText: 'Portions',
                      hintText: 'Number of portions',
                      keyboardType: TextInputType.number,
                      validationCallback: FieldValidator.isNumberValidator,
                      onChanged: validationHandler,
                      onSaved: (val) => _recipe.portions = int.parse(val ?? '1')),
                  CustomInputField(
                      icon: const Icon(Icons.timer),
                      initialValue: viewModel.recipe.duration.toString(),
                      enabled: !_isCreated,
                      labelText: 'Duration',
                      hintText: 'Total cooking time in minutes',
                      keyboardType: TextInputType.number,
                      validationCallback: FieldValidator.isNumberValidator,
                      onChanged: validationHandler,
                      onSaved: (val) => _recipe.duration = int.parse(val ?? '1')),
                  CustomInputField(
                      icon: const Icon(Icons.format_list_numbered),
                      initialValue: viewModel.recipe.ingredients?.join(', ') ?? '',
                      enabled: !_isCreated,
                      labelText: 'Ingredients',
                      hintText: 'All ingredients separated by ", "',
                      keyboardType: TextInputType.number,
                      validationCallback: FieldValidator.descriptionValidator,
                      onChanged: validationHandler,
                      onSaved: (val) => saveIngredientsHandler(val ?? '')),
                  _getCategoryDropDown(viewModel.recipe.category ?? 'hi'),
                  _getCuisinesDropdown(viewModel.recipe.cuisine),
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: DynamicInputTable(data: _recipe.steps ?? [])),
                  _getImageSelector(),
                  FormButton(content: 'Create', callback: _isCreated ? null : createHandler)
                ],
              ))));

  Widget _getCategoryDropDown(String category) => Padding(
      padding: const EdgeInsets.only(top: 20),
      child: DropdownButton(
          hint: const Text('Recipe category'),
          value: _isCreated ? category : _recipe.category,
          isExpanded: true,
          onChanged: (val) => categoryChangeHandler(val!),
          items: _isCreated
              ? null
              : constants.Category.values
                  .map((category) => DropdownMenuItem(
                        value: category.name,
                        child: Text(category.name),
                      ))
                  .toSet()
                  .toList()));

  Widget _getCuisinesDropdown(CuisineModel? cuisine) => FutureBuilder(
      future: _cuisinesFuture,
      builder: (context, snapshot) => Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Consumer<CuisineListViewModel>(
              builder: (
            BuildContext context,
            CuisineListViewModel cuisineViewModel,
            child,
          ) =>
                  DropdownButton(
                    hint: const Text('Recipe cuisine'),
                    value: _isCreated ? cuisine : _recipe.cuisine,
                    isExpanded: true,
                    onChanged: (val) => cuisineChangeHandler(val as CuisineModel),
                    items: _isCreated
                        ? null
                        : cuisineViewModel.cuisines
                            .map((cuisine) => DropdownMenuItem(
                                  value: cuisine,
                                  child: Text(cuisine.name!),
                                ))
                            .toSet()
                            .toList(),
                  ))));

  Widget _getImageSelector() => Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(children: [
        TextButton(
            onPressed: _isCreated ? null : selectImageHandler,
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(width: 1, color: Colors.black)))),
            child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Select Image',
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 20),
                ))),
      ]));
}
