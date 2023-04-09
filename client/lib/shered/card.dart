import "package:flutter/material.dart";

class CustomCard extends StatelessWidget {
  final List<Widget> children;

  const CustomCard({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(
        minHeight: 320,
        maxHeight: 350,
        minWidth: 350,
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
              children: this.children,
            ),
          ],
        ),
      ),
    );
  }
}
