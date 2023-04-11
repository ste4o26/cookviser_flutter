import 'package:demo_app/domain/auth/view_models/login.view_model.dart';
import 'package:demo_app/domain/user/view_models/user.view_model.dart';
import 'package:demo_app/services/auth.service.dart';
import 'package:demo_app/shered/form_button.dart';
import 'package:demo_app/shered/input_field.dart';
import 'package:demo_app/utils/field.validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final user = UserLoginViewModel();
  final service = AuthService();
  final _formKey = GlobalKey<FormState>();

  FormState? get state => this._formKey.currentState;

  void login(Map? args) {
    if (!this.state!.validate()) return;

    this.state!.save();
    Provider.of<AuthViewModel>(context, listen: false).login(this.user);
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        height: MediaQuery.of(context).size.height / 3,
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: this._formKey,
          child: ListView(
            children: <Widget>[
              const Center(child: Text("Sign In")),
              CustomInputField(
                onSaved: (value) => this.user.username = value ?? "",
                validationCallback: FieldValidator.validateUsername,
                icon: const Icon(Icons.person),
                hintText: 'Username',
                labelText: 'Enter your username',
              ),
              CustomInputField(
                onSaved: (value) => this.user.password = value ?? "",
                validationCallback: FieldValidator.validatePassword,
                icon: const Icon(Icons.person),
                hintText: 'Password',
                labelText: 'Enter your password',
              ),
              FormButton(content: "Sign In", callback: this.login)
            ],
          ),
        ),
      ),
    );
  }
}
