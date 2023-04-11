import 'package:demo_app/domain/auth/view_models/login.view_model.dart';
import 'package:demo_app/domain/auth/view_models/register.view_model.dart';
import 'package:demo_app/domain/user/models/user.model.dart';
import 'package:demo_app/services/auth.service.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final service = AuthService();
  String? _token;
  UserModel? _user;

  String? get token => this._token;
  UserModel? get user => this._user;

  Future<void> register(UserRegisterViewModel user) async {
    this._user = await this.service.register(user);
    notifyListeners();
  }
  
  Future<void> login(UserLoginViewModel user) async {
    Map<String, dynamic> data = await this.service.login(user);
    this._token = data["token"];
    this._user = data["user"];
    notifyListeners();
  }

  void logout() {
    this._token = null;
    this._user = null;
    notifyListeners();
  }
}