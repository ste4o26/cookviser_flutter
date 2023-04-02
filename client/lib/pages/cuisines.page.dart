import 'package:demo_app/domain/cuisine/views/cuisine_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_app/domain/cuisine/view_models/cuisine_list.view_model.dart';

class CuisinesPage extends StatefulWidget {
  const CuisinesPage({super.key});

  @override
  _CuisinesPageState createState() => _CuisinesPageState();
}

class _CuisinesPageState extends State<CuisinesPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CuisineListViewModel>(context, listen: false).fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CuisineListViewModel>(context);

    return Scaffold(
        appBar: AppBar(title: Text("Cookviser demo app")),
        body: Container(
            child: Column(children: [
          Expanded(child: CuisineList(cuisines: viewModel.cuisines))
        ])));
  }
}
