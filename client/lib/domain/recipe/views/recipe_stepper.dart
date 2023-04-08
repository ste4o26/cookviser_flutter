import 'package:flutter/material.dart';

class ModalStepper extends StatefulWidget {
  final List<Step> steps;

  const ModalStepper(this.steps, {super.key});

  @override
  State<StatefulWidget> createState() => _ModalStepperState();
}

class _ModalStepperState extends State<ModalStepper> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) => Stepper(
        currentStep: currentStep,
        onStepTapped: (step) => setState(() => currentStep = step),
        onStepContinue: () {
          setState(() => currentStep = currentStep < widget.steps.length - 1
              ? currentStep + 1
              : currentStep);
        },
        onStepCancel: () {
          setState(() => currentStep = currentStep > 0 ? currentStep - 1 : 0);
        },
        steps: widget.steps,
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text("PREVIOUS"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      onPressed: details.onStepContinue,
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.blue),
                      ),
                      child: const Text(
                        "NEXT",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
}
