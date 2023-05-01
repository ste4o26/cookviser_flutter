import 'package:demo_app/domain/recipe/models/step.dart';
import 'package:flutter/material.dart';

// TODO refactor so it can work with generic types instead of hardcoded StepModel !!!

class DynamicInputTable extends StatefulWidget {
  final List<StepModel> data;

  const DynamicInputTable({required this.data, super.key});

  @override
  State<StatefulWidget> createState() => _DynamicInputTableState();
}

class _DynamicInputTableState extends State<DynamicInputTable> {
  void addRowHandler() {
    final step = StepModel(number: widget.data.length, content: '');
    setState(() => widget.data.add(step));
  }

  void removeRowHandler(int index) => setState(() {
        for (int i = index; i < widget.data.length; i++) {
          widget.data[i].number = widget.data[i].number - 1;
        }
        widget.data.removeAt(index);
      });

  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
          constraints: BoxConstraints(
            maxWidth: constraints.maxWidth * 0.5,
            maxHeight: constraints.maxHeight * 0.4,
          ),
          child: Column(
            children: [
              ...List.generate(
                  widget.data.length,
                  (index) => Row(mainAxisSize: MainAxisSize.max, children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.1),
                          child: TextButton(
                              onPressed: () => removeRowHandler(index),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.black,
                              )),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                                constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.9),
                                child: TextFormField(
                                  initialValue: widget.data[index].content,
                                  onChanged: (val) => widget.data[index].content = val,
                                  onSaved: (val) => widget.data[index].content = val!,
                                )))
                      ])),
              TextButton(
                  onPressed: addRowHandler,
                  child: const Text(
                    'Add Step',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ))
            ],
          )));
}
