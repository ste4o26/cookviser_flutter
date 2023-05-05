import 'dart:developer';

import 'package:demo_app/domain/recipe/models/step.dart';
import 'package:flutter/material.dart';

// TODO refactor so it can work with generic types instead of hardcoded StepModel !!!

class DynamicInputTable extends StatefulWidget {
  List<StepModel> data;

  DynamicInputTable({required this.data, super.key});

  @override
  State<StatefulWidget> createState() => _DynamicInputTableState();
}

class _DynamicInputTableState extends State<DynamicInputTable> {
  TextEditingController _controller = TextEditingController();

  void addRowHandler() {
    final step = StepModel(number: widget.data.length, content: '');
    // TODO figure out how to use the controller.
    setState(() => widget.data.add(step));
  }

  void removeRowHandler(StepModel step) {
    int index = widget.data.indexOf(step);
    for (int i = index; i < widget.data.length; i++) {
      widget.data[i].number -= 1;
    }

    setState(() {
      widget.data.removeWhere((currentStep) => currentStep.number == step.number);
    });
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
          constraints: BoxConstraints(
            maxWidth: constraints.maxWidth * 0.5,
            maxHeight: constraints.maxHeight * 0.4,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ...widget.data.map((step) => _getInputRow(step)).toList(),
            _getAddButton(),
          ])));

  Widget _getInputRow(StepModel step) {
    print("${step.number} ${step.content}");
    return LayoutBuilder(
        builder: (context, constraints) => Row(mainAxisSize: MainAxisSize.max, children: [
              Container(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.1),
                  child: TextButton(
                      onPressed: () => removeRowHandler(step),
                      child: const Icon(Icons.delete, color: Colors.black))),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                      constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.9),
                      child: TextFormField(
                        controller: _controller,
                        // onChanged: (val) => step.content = val,
                      )))
            ]));
  }

  Widget _getAddButton() => Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextButton(
          onPressed: addRowHandler,
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(width: 1, color: Colors.black)))),
          child: const Padding(
              padding: EdgeInsets.all(4),
              child: Text('Add Step',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )))));
}
