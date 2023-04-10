import 'package:demo_app/domain/user/view_models/user_register.view_model.dart';
import 'package:demo_app/services/auth.service.dart';
import 'package:demo_app/shered/input_field.dart';
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
              Container(
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
              ),
              CustomInputField(
                onSaved: (value) => user.username = value!,
                validationCallback: FieldValidator.validateUsername,
                icon: const Icon(Icons.person),
                hintText: 'Username',
                labelText: 'Enter your username',
              ),
              CustomInputField(
                onSaved: (value) => user.email = value!,
                validationCallback: FieldValidator.validateEmail,
                icon: const Icon(Icons.email),
                hintText: "email@example.com",
                labelText: "E-mail Address",
              ),
              CustomInputField(
                onSaved: (value) => user.password = value!,
                validationCallback: FieldValidator.validatePassword,
                icon: const Icon(Icons.lock),
                hintText: "Password",
                labelText: "Enter your password",
                obscureText: true,
                controller: _pass,
              ),
              CustomInputField(
                onSaved: (value) => user.confirmPassword = value!,
                validationCallback: FieldValidator(passController: _pass)
                    .validateConfirmPassword,
                icon: const Icon(Icons.lock),
                hintText: "Confirm password",
                labelText: "Confirm your password",
                obscureText: true,
              ),
              CustomInputField(
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
