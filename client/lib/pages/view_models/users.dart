import 'package:demo_app/domain/user/models/user.dart';
import 'package:demo_app/services/admin.dart';
import 'package:flutter/cupertino.dart';

class UsersViewModel extends ChangeNotifier {
  final _service = AdminService();

  List<UserModel> users = [];

  Future<void> fetchAll() async {
    users = await _service.fetchAll();
    notifyListeners();
  }

  Future<UserModel> promote(String username) async {
    final user = await _service.promote(username);
    notifyListeners();
    return user;
  }

  Future<UserModel> demote(String username) async {
    final user = await _service.demote(username);
    notifyListeners();
    return user;
  }
}
