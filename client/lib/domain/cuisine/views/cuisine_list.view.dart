import "package:demo_app/domain/cuisine/view_models/cuisine.view_model.dart";
import "package:demo_app/domain/cuisine/view_models/cuisine_list.view_model.dart";
import "package:demo_app/shered/image.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../../shered/card.dart";

class CuisineList extends StatelessWidget {
  const CuisineList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CuisineListViewModel>(builder: (context, viewModel, child) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width ~/ 350,
          crossAxisSpacing: 10,
          mainAxisSpacing: 50,
        ),
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        itemCount: viewModel.cuisines.length,
        itemBuilder: (context, index) {
          CuisineViewModel cuisine = viewModel.cuisines[index];
  
          return CustomCard(
            children: [
              InkWell(
                onTap: () => Navigator.pushNamed(
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
        },
      );
    });
  }
}
