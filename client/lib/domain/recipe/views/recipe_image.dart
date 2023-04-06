import 'package:flutter/material.dart';

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
