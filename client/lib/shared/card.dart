import 'package:demo_app/constants.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final List<Widget> children;

  const CustomCard({required this.children, super.key});

  @override
  Widget build(BuildContext context) => Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(
        minHeight: CUSTOM_CARD_SIZE,
        maxHeight: CUSTOM_CARD_SIZE,
        minWidth: CUSTOM_CARD_SIZE,
        maxWidth: CUSTOM_CARD_SIZE,
      ),
      child: Card(
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: children,
              ),
            ],
          )));
}
