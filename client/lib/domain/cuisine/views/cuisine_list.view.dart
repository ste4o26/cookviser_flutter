import "package:demo_app/constants.dart";
import "package:demo_app/domain/cuisine/view_models/cuisine_list.view_model.dart";
import 'package:demo_app/domain/cuisine/views/cuisine_card_view.dart';
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class CuisineList extends StatelessWidget {
  const CuisineList({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            Consumer<CuisineListViewModel>(
          builder: (context, viewModel, child) => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:constraints.maxWidth ~/ customCardSize,
              crossAxisSpacing: 10,
              mainAxisSpacing: 50,
            ),
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            itemCount: viewModel.cuisines.length,
            itemBuilder: (context, index) =>
                CuisineCard(cuisine: viewModel.cuisines[index]),
          ),
        ),
      );
}
