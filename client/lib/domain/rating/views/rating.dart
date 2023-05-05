import 'package:demo_app/domain/rating/models/rating.dart';
import 'package:demo_app/domain/rating/view_models/rating.dart';
import 'package:demo_app/domain/recipe/models/recipe.dart';
import 'package:demo_app/pages/view_models/auth.dart';
import 'package:demo_app/domain/user/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class Rating extends StatefulWidget {
  final Icon icon;
  final RecipeModel recipe;

  const Rating(
    this.recipe, {
    super.key,
    this.icon = const Icon(
      Icons.star,
      color: Colors.yellow,
    ),
  });

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  late Future<void> _future;

  @override
  void didChangeDependencies() {
    _future =
        Provider.of<AuthViewModel>(context, listen: false).loadLoggedInUser();
    super.didChangeDependencies();
  }

  // TODO check if it is okay to pass async functions as
  // callbacks to onPressed or other handler functions of that kind!!!
  void _rate(UserModel? user, int value) async {
    if (user == null) return;

    RatingModel rate = RatingModel(
      rating: value,
      user: user,
      recipe: widget.recipe,
    );

    double? overallRating = await Provider.of<RatingViewModel>(
      context,
      listen: false,
    ).rate(rate);
    if (overallRating == null) return;

    setState(() {
      widget.recipe.overallRating = overallRating;
    });
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<AuthViewModel>(
                  builder: (
                BuildContext context,
                AuthViewModel viewModel,
                child,
              ) =>
                      RatingBar.builder(
                        tapOnlyMode: true,
                        ignoreGestures: viewModel.user == null,
                        initialRating: widget.recipe.overallRating!,
                        itemSize: 25,
                        maxRating: 5,
                        minRating: 1,
                        itemBuilder: (context, _) => widget.icon,
                        onRatingUpdate: (rating) =>
                            _rate(viewModel.user, rating.toInt()),
                      )),
              const SizedBox(width: 8),
              Text(
                widget.recipe.overallRating!.toStringAsFixed(2),
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ));
}
