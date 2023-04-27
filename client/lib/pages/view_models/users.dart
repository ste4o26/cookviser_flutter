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

  Future<void> promote(int index) async {
    users[index] = await _service.promote(users[index].username);
    notifyListeners();
  }

  Future<void> demote(int index) async {
    users[index] = await _service.demote(users[index].username);
    notifyListeners();
  }
}
