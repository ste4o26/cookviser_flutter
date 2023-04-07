import 'package:demo_app/domain/auth/services/register.service.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  final _pass = TextEditingController();
  final _confPass = TextEditingController();
  final _registeredUser = {};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
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
                    'Sing up',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  onSaved: (username) =>
                      _registeredUser["username"] = username!,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 5) {
                      return "Username must be more than 5 symbols";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Username",
                    labelText: "Enter your user name",
                    icon: Icon(Icons.person),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  onSaved: (email) => _registeredUser["email"] = email!,
                  validator: (value) {
                    final regex = RegExp(
                        r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-]+)(\.[a-zA-Z]{2,5}){1,2}");
                    if (value == null ||
                        value.isEmpty ||
                        !regex.hasMatch(value)) {
                      return "Invalid e-mail address";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  // Use email input type for emails.
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "email@example.com",
                    labelText: "E-mail Address",
                    icon: Icon(Icons.email),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  onSaved: (password) =>
                      _registeredUser["password"] = password!,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return "Password must be minimum 8 symbols";
                    }
                    return null;
                  },
                  controller: _pass,
                  obscureText: true,
                  // Use secure text for passwords.
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                    labelText: "Enter your password",
                    icon: Icon(Icons.lock),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  onSaved: (confirmPassword) =>
                      _registeredUser["confirmPassword"] = confirmPassword!,
                  validator: (value) {
                    if (value != _pass.text) {
                      return "Password did not match";
                    }
                    return null;
                  },
                  controller: _confPass,
                  obscureText: true,
                  // Use secure text for passwords.
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Confirm Password",
                    labelText: "Enter your confirm password",
                    icon: Icon(Icons.lock),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  maxLines: 4,
                  onSaved: (description) =>
                      _registeredUser["description"] = description!,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 10) {
                      return "Description must be minimum 10 symbols";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Text here",
                    labelText: "Description",
                    icon: Icon(Icons.description_sharp),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 50,
                      width: 150,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: TextButton(
                        onPressed: () => _performLogin(),
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.deepPurple)),
                        child: const Text(
                          "Sing up",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.deepPurple)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(context,'/'),
                        child: const Text(
                          "Back",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
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
      RegisterService().register(_registeredUser);
      Navigator.pushReplacementNamed(context, '/');
    }
  }
}
