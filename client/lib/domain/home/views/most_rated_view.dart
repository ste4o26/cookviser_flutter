import 'package:demo_app/shared/custom_scrollable_view.dart';
import 'package:flutter/material.dart';

class MostRated extends StatelessWidget {
  const MostRated({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Container(
          margin: const EdgeInsets.only(top: 50),
          width: constraints.maxWidth * 0.8,
          height: 450,
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomScrollableView(child: child),
            ],
          ),
        ),
      );
}
