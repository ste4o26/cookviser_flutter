import 'package:demo_app/domain/auth/view_models/login.view_model.dart';
import 'package:demo_app/domain/auth/view_models/register.view_model.dart';
import 'package:demo_app/domain/user/models/user.model.dart';
import 'package:demo_app/services/auth.service.dart';
import 'package:demo_app/services/user.service.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final _authService = AuthService();
  final _userService = UserService();

  String? _token;
  UserModel? _user;

  String? get token => _token;
  UserModel? get user => _user;

  Future<void> register(UserRegisterViewModel user) async {
    _user = await _authService.register(user);
    notifyListeners();
  }

  Future<void> login(UserLoginViewModel user) async {
    Map<String, dynamic> data = await _authService.login(user);
    _token = data['token'];
    _user = data['user'];
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _user = null;
    await _authService.logout();
    notifyListeners();
  }

  Future<void> loadLoggedInUser() async {
    _token = await _authService.getToken();
    final username = await _authService.getUsername();
    if (username == null) return;

    _user = await _userService.fetchByUsername(username);
    notifyListeners();
  }
}
