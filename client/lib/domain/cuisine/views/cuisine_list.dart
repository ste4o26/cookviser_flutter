import "package:demo_app/domain/cuisine/view_models/cuisine.view_model.dart";
import "package:flutter/material.dart";

class CuisineList extends StatelessWidget {
  final List<CuisineViewModel> cuisines;

  const CuisineList({required this.cuisines});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cuisines.length,
      itemBuilder: (BuildContext context, int index) {
        CuisineViewModel cuisine = cuisines[index];
        return Column(
          children: [Text(cuisine.name)],
        );
      },
    );
  }
}
