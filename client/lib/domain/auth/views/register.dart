import 'package:demo_app/domain/auth/models/register.dart';
import 'package:demo_app/pages/view_models/auth.dart';
import 'package:demo_app/shared/form/submit_button.dart';
import 'package:demo_app/shared/form/input_field.dart';
import 'package:demo_app/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({super.key});

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  final user = UserRegisterViewModel();
  final _formKey = GlobalKey<FormState>();
  final _pass = TextEditingController();

  FormState? get state => _formKey.currentState;

  void registerHandler() async {
    Navigator.pop(context);
    await Provider.of<AuthViewModel>(context, listen: false).register(user);
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
            width: constraints.maxWidth * 0.3,
            height: constraints.maxHeight * 0.7,
            padding: const EdgeInsets.all(50.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Center(
                      child: Text(
                        'Sing Up',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  CustomInputField(
                    onSaved: (value) => user.username = value!,
                    onChanged: isInvalidForm,
                    validationCallback: FieldValidator.nameValidator,
                    icon: const Icon(Icons.person),
                    hintText: 'Username',
                    labelText: 'Enter your username',
                  ),
                  CustomInputField(
                    onSaved: (value) => user.email = value!,
                    onChanged: isInvalidForm,
                    validationCallback: FieldValidator.emailValidator,
                    icon: const Icon(Icons.email),
                    hintText: 'email@example.com',
                    labelText: 'E-mail Address',
                  ),
                  CustomInputField(
                    onSaved: (value) => user.password = value!,
                    onChanged: isInvalidForm,
                    validationCallback: FieldValidator.passwordValidator,
                    icon: const Icon(Icons.lock),
                    hintText: 'Password',
                    labelText: 'Enter your password',
                    obscureText: true,
                    controller: _pass,
                  ),
                  CustomInputField(
                    onSaved: (value) => user.confirmPassword = value!,
                    onChanged: isInvalidForm,
                    validationCallback:
                        FieldValidator(passController: _pass).passwordConfirmationValidator,
                    icon: const Icon(Icons.lock),
                    hintText: 'Confirm password',
                    labelText: 'Confirm your password',
                    obscureText: true,
                  ),
                  CustomInputField(
                    onSaved: (value) => user.description = value!,
                    onChanged: isInvalidForm,
                    maxLines: 4,
                    validationCallback: FieldValidator.descriptionValidator,
                    icon: const Icon(Icons.description),
                    hintText: 'Text here...',
                    labelText: 'Description',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: FormButton(
                          content: 'Sign Up',
                          callback: registerHandler,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
