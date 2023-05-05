import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validationCallback;
  final String? hintText;
  final String? labelText;
  final Icon? icon;
  final int? maxLines;
  final bool? obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: TextFormField(
          initialValue: initialValue ,
          maxLines: maxLines ?? 1,
          onChanged: onChanged,
          onSaved: onSaved,
          validator: validationCallback,
          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
            labelText: labelText,
            prefixIcon: icon,
          ),
        ),
      );

  final String? initialValue;

  const CustomInputField({
    super.key,
    required this.onSaved,
    required this.onChanged,
    this.hintText,
    this.labelText,
    this.icon,
    this.maxLines,
    this.obscureText,
    this.controller,
    this.validationCallback,
    this.keyboardType = TextInputType.text,
    this.initialValue,
  });
}
