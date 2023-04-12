import 'dart:ui';

import 'package:demo_app/domain/cuisine/view_models/most_populated_cuisine.view_model.dart';
import 'package:demo_app/shered/cuisine_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MostPopulatedCuisines extends StatelessWidget {
  const MostPopulatedCuisines({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<MostPopulatedCuisineViewModel>(context, listen: false).fetch();
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 450,
      child: Column(
        children: [
           const Expanded(
             child: Text(
               "Most Populated Cuisines: ",
               style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold,),
             ),
           ),
          SizedBox(
            height: 350,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Consumer<MostPopulatedCuisineViewModel>(
                    builder: (context, viewModel, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.cuisines.length,
                    itemBuilder: (context, index) {
                      return CuisineCard(cuisine: viewModel.cuisines[index]);
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
