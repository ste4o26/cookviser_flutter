import 'package:demo_app/constants.dart';
import 'package:demo_app/pages/view_models/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Guards {
  final AuthViewModel _viewModel;

  Guards(this._viewModel);

  String? authorityGuard(BuildContext context, GoRouterState state) {
    if (_viewModel.token != null) {
      final authorities = _viewModel.user!.authorities;
      if (authorities.contains(Authority.update) ||
          authorities.contains(Authority.delete)) {
        return null;
      }
    }
    return Routes.home.name;
  }

  String? loggedInGuard(BuildContext context, GoRouterState state) {
    if (_viewModel.token != null) return null;

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 1),
        content: Center(child: Text('You must Sign in'))));

    return Routes.home.name;
  }
}