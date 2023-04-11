import "package:flutter/material.dart";

class HeaderItem extends StatelessWidget {
  final String name;
  final Function callback;
  final Map<String, dynamic> args;
  final Icon? icon;

  const HeaderItem(
    this.name, {
    required this.callback,
    required this.args,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 15,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          padding: const EdgeInsets.all(8),
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () => this.callback(context, args),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            this.icon ??
                Container(
                  alignment: Alignment.center,
                  width: 0,
                  height: 0,
                ),
          ],
        ),
      ),
    );
  }
}
