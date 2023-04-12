import 'package:demo_app/domain/rating/models/rating_model.dart';
import 'package:demo_app/domain/rating/view_models/rating_view_model.dart';
import 'package:demo_app/domain/recipe/models/recipe.model.dart';
import 'package:demo_app/domain/user/models/user.model.dart';
import 'package:demo_app/domain/user/view_models/user.view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class Rating extends StatefulWidget {
  final Icon icon;
  final RecipeModel recipe;

  const Rating(
    this.recipe, {
    this.icon = const Icon(
      Icons.star,
      color: Colors.yellow,
    ),
    super.key,
  });

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  late UserModel? _loggedUser;

  @override
  void didChangeDependencies() {
    _loggedUser = Provider.of<AuthViewModel>(context, listen: true).user;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatingBar.builder(
          tapOnlyMode: true,
          ignoreGestures: _loggedUser == null,
          initialRating: widget.recipe.overallRating,
          itemSize: 25,
          maxRating: 5,
          minRating: 1,
          itemBuilder: (context, _) => widget.icon,
          onRatingUpdate: (rating) => _rate(rating.toInt()),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          "${widget.recipe.overallRating}",
          style: const TextStyle(fontSize: 18),
        )
      ],
    );
  }

  _rate(int value) async {
    final token = Provider.of<AuthViewModel>(context, listen: false).token;
    var rate =
        RatingModel(rating: value, user: _loggedUser!, recipe: widget.recipe);
    rate = await Provider.of<RatingViewModel>(context, listen: false)
        .rate(rate, token);
    setState(() {
      widget.recipe.overallRating = rate.recipe.overallRating;
    });
  }
}
