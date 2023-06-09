import 'package:demo_app/constants.dart';
import 'package:demo_app/pages/view_models/cuisines.dart';
import 'package:demo_app/domain/cuisine/views/cuisine_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CuisineList extends StatelessWidget {
  const CuisineList({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
          builder: (
        BuildContext context,
        BoxConstraints constraints,
      ) =>
              Consumer<CuisineListViewModel>(
                  builder: (
                BuildContext context,
                CuisineListViewModel viewModel,
                child,
              ) =>
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              constraints.maxWidth ~/ CUSTOM_CARD_SIZE,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 50,
                        ),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        itemCount: viewModel.cuisines.length,
                        itemBuilder: (context, index) =>
                            CuisineCard(cuisine: viewModel.cuisines[index]),
                      )));
}
