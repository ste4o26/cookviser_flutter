import 'package:demo_app/domain/user/models/user.model.dart';
import 'package:demo_app/services/user_service.dart';
import 'package:flutter/cupertino.dart';

class BestThreeUserViewModel with ChangeNotifier {
  final service = UserService();
  List<UserModel> users = [];

  Future<void> fetchBestThree() async {
    users = await service.fetchBestThree();
    notifyListeners();
  }
}
