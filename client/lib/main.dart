import "package:demo_app/pages/cuisines.page.dart";
import "package:flutter/material.dart";

void main() {
  runApp(const CookviserApp());
}

class CookviserApp extends StatelessWidget {
  const CookviserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Test"),
        ),
        body: const Center(
          child: CuisinesPage()
        ),
      )
    );
  }
}
