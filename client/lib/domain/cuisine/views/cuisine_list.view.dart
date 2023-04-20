import "package:demo_app/domain/cuisine/view_models/cuisine_list.view_model.dart";
import 'package:demo_app/domain/cuisine/views/cuisine_card_view.dart';
import "package:flutter/material.dart";
import "package:provider/provider.dart";

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
          return CuisineCard(cuisine: viewModel.cuisines[index]);
        },
      );
    });
  }
}
