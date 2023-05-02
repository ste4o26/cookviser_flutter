import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/cuisine/models/cuisine.dart';
import 'package:demo_app/shared/card.dart';
import 'package:demo_app/shared/image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CuisineCard extends StatelessWidget {
  final CuisineModel cuisine;

  const CuisineCard({required this.cuisine, super.key});

  @override
  Widget build(BuildContext context) => CustomCard(
        children: [
          InkWell(
            onTap: () => context.go(
              "${Routes.recipes.name}/${cuisine.name}",
            ),
            child: CustomImage(cuisine.imageThumbnailUrl!),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Text(cuisine.name!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ))),
        ],
      );
}
