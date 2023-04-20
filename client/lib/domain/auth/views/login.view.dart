import 'package:demo_app/domain/auth/view_models/login.view_model.dart';
import 'package:demo_app/domain/auth/views/register.view.dart';
import 'package:demo_app/domain/user/view_models/user.view_model.dart';
import 'package:demo_app/services/auth.service.dart';
import 'package:demo_app/shared/form_button.dart';
import 'package:demo_app/shared/input_field.dart';
import 'package:demo_app/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final user = UserLoginViewModel();
  final service = AuthService();
  final _formKey = GlobalKey<FormState>();

  FormState? get state => _formKey.currentState;

  void login(Map? args) {
    if (!state!.validate()) return;

    state!.save();
    Provider.of<AuthViewModel>(context, listen: false).login(user);
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Dialog(
          child: Container(
            width: constraints.maxWidth * 0.25,
            height: constraints.maxHeight * 0.45,
            padding: const EdgeInsets.all(50),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  const Center(child: Text("Sign In")),
                  CustomInputField(
                    onSaved: (value) => user.username = value ?? "",
                    validationCallback: FieldValidator.validateUsername,
                    icon: const Icon(Icons.person),
                    hintText: 'Username',
                    labelText: 'Enter your username',
                  ),
                  CustomInputField(
                    onSaved: (value) => user.password = value ?? "",
                    validationCallback: FieldValidator.validatePassword,
                    icon: const Icon(Icons.person),
                    hintText: 'Password',
                    labelText: 'Enter your password',
                  ),
                  FormButton(content: "Sign In", callback: login),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                          onPressed: () => showDialog(
                                context: context,
                                builder: (context) => const RegisterDialog(),
                              ),
                          child: const Text("Sign up"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
