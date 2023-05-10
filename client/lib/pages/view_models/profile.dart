import 'package:demo_app/domain/user/models/user.dart';
import 'package:demo_app/services/user.dart';
import 'package:flutter/cupertino.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserService _service = UserService();
  UserModel? profile;

  Future<void> fetchProfile(String username) async {
    profile = await _service.fetchByUsername(username);
    notifyListeners();
  }
}
