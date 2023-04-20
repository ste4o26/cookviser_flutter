import 'dart:ui';

import 'package:flutter/material.dart';

class CustomScrollableView extends StatelessWidget {
  final Widget child;

  const CustomScrollableView({required this.child, super.key});

  @override
  Widget build(BuildContext context) => Expanded(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: child,
          ),
        ),
      );
}
