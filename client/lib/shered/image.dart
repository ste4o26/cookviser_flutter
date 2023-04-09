import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  const CustomImage(
    this.imageUrl, {
    this.height = 250,
    this.width = 300,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Image(
              width: this.width,
              height: this.height,
              fit: BoxFit.fill,
              image: NetworkImage(this.imageUrl),
            )));
  }
}
