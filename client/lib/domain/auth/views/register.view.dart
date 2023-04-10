import 'package:demo_app/domain/user/view_models/user_register.view_model.dart';
import 'package:demo_app/services/auth.service.dart';
import 'package:flutter/material.dart';

import '../../../utils/field.validator.dart';

// TODO refactor

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({super.key});

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  final _formKey = GlobalKey<FormState>();
  final _pass = TextEditingController();
  final user = UserRegisterViewModel();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        height: MediaQuery.of(context).size.height / 1.5,
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const DialogTitle(),
              CustomTextField(
                onSaved: (value) => user.username = value!,
                validationCallback: FieldValidator.validateUsername,
                icon: const Icon(Icons.person),
                hintText: 'Username',
                labelText: 'Enter your username',
              ),
              CustomTextField(
                onSaved: (value) => user.email = value!,
                validationCallback: FieldValidator.validateEmail,
                icon: const Icon(Icons.email),
                hintText: "email@example.com",
                labelText: "E-mail Address",
              ),
              CustomTextField(
                onSaved: (value) => user.password = value!,
                validationCallback: FieldValidator.validatePassword,
                icon: const Icon(Icons.lock),
                hintText: "Password",
                labelText: "Enter your password",
                obscureText: true,
                controller: _pass,
              ),
              CustomTextField(
                onSaved: (value) => user.confirmPassword = value!,
                validationCallback: FieldValidator(passController: _pass)
                    .validateConfirmPassword,
                icon: const Icon(Icons.lock),
                hintText: "Confirm password",
                labelText: "Confirm your password",
                obscureText: true,
              ),
              CustomTextField(
                onSaved: (value) => user.description = value!,
                maxLines: 4,
                validationCallback: FieldValidator.validateDescription,
                icon: const Icon(Icons.description),
                hintText: 'Text here...',
                labelText: 'Description',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 50,
                      width: 150,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 40.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextButton(
                        onPressed: () => _performLogin(),
                        child: const Text("Sing up"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _performLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthService().register(user);
      Navigator.pushReplacementNamed(context, '/');
    }
  }
}

class CustomTextField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final String? Function(String?)? validationCallback;
  final String? hintText;
  final String? labelText;
  final Icon? icon;
  final int? maxLines;
  final bool? obscureText;
  final TextEditingController? controller;

  const CustomTextField(
      {super.key,
      required this.onSaved,
      this.hintText,
      this.labelText,
      this.icon,
      this.maxLines,
      this.obscureText,
      this.controller,
      this.validationCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        maxLines: maxLines ?? 1,
        onSaved: onSaved,
        validator: validationCallback,
        keyboardType: TextInputType.text,
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
  }
}

class DialogTitle extends StatelessWidget {
  const DialogTitle({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: const Center(
          child: Text(
            "Sing Up",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
