import 'package:flutter/cupertino.dart';

class FieldValidator {
  TextEditingController? passController;

  FieldValidator({this.passController});

  static String? descriptionValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 10) {
      return 'Description must be minimum 10 symbols!';
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 5) {
      return 'Username must be more than 5 symbols!';
    }
    return null;
  }
  static String? validateCuisineName(String? value) {
    if (value == null || value.isEmpty || value.length < 5) {
      return 'Cuisine name must be more than 5 symbols';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    final regex = RegExp(r'^([a-zA-Z0-9_\-.]+)@([a-zA-Z0-9_\-]+)(\.[a-zA-Z]{2,5}){1,2}');
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Invalid e-mail address!';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return 'Password must be minimum 6 symbols!';
    }
    return null;
  }

  String? passwordConfirmationValidator(String? value) {
    if (value != passController!.text) {
      return 'Password did not match!';
    }
    return null;
  }

  static String? isNumberValidator(String? value) {
    const String errorMessage = 'Only numeric values are allowed!';
    if (value == null || value.isEmpty) return errorMessage;

    try {
      int.parse(value);
    } on FormatException {
      return errorMessage;
    }

    return null;
  }
}
