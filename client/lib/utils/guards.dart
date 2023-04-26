import 'package:demo_app/constants.dart';
import 'package:demo_app/pages/view_models/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Guards {
  final AuthViewModel _viewModel;
  Guards(this._viewModel);

  // This is an example guard 
  String? customGuard(BuildContext context, GoRouterState state) {
    if (_viewModel.token == null) {
      return Routes.home.name;
    } else {
      return null;
    } 
  }
}
