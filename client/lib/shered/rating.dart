import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatefulWidget {
  final Icon icon;

  const Rating({
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
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RatingBar.builder(
          itemSize: 25,
          maxRating: 5,
          itemBuilder: (context, _) => widget.icon,
          onRatingUpdate: (rating) {},
        )
      ],
    );
  }
}
