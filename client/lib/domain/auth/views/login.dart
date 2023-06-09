import 'package:demo_app/domain/auth/models/login.dart';
import 'package:demo_app/domain/auth/views/register.dart';
import 'package:demo_app/pages/view_models/auth.dart';
import 'package:demo_app/shared/form/submit_button.dart';
import 'package:demo_app/shared/form/input_field.dart';
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
  final _formKey = GlobalKey<FormState>();

  FormState? get state => _formKey.currentState;

  void loginHandler() async {
    Navigator.pop(context);
    await Provider.of<AuthViewModel>(context, listen: false).login(user);
  }

  bool isInvalidForm(String? arg) {
    if (!state!.validate()) return false;
    state!.save();
    return true;
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
                      const Center(child: Text('Sign In')),
                      CustomInputField(
                        onSaved: (value) => user.username = value ?? '',
                        onChanged: isInvalidForm,
                        validationCallback: FieldValidator.nameValidator,
                        icon: const Icon(Icons.person),
                        hintText: 'Username',
                        labelText: 'Enter your username',
                      ),
                      CustomInputField(
                        onSaved: (value) => user.password = value ?? '',
                        onChanged: isInvalidForm,
                        validationCallback: FieldValidator.passwordValidator,
                        icon: const Icon(Icons.person),
                        obscureText: true,
                        hintText: 'Password',
                        labelText: 'Enter your password',
                      ),
                      FormButton(
                        content: 'Sign In',
                        callback: loginHandler,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                              onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => const RegisterDialog(),
                                  ),
                              child: const Text('Sign up'))
                        ],
                      )
                    ],
                  )))));
}
