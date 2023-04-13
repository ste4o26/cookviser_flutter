import 'package:demo_app/domain/cuisine/view_models/cuisine.view_model.dart';
import 'package:demo_app/shered/card.dart';
import 'package:demo_app/shered/image.dart';
import 'package:flutter/material.dart';

class CuisineCard extends StatelessWidget {
  final CuisineViewModel cuisine;

  const CuisineCard({required this.cuisine, super.key});

  @override
  Widget build(BuildContext context) => CustomCard(
        children: [
          InkWell(
            onTap: () => Navigator.pushReplacementNamed(
              context,
              "/recipes_by_cuisine",
              arguments: {"cuisineName": cuisine.name},
            ),
            child: CustomImage(cuisine.imageUrl),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              cuisine.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      );
}
