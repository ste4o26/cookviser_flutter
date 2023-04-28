import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/auth/views/login.dart';
import 'package:demo_app/domain/auth/views/register.dart';
import 'package:demo_app/pages/view_models/auth.dart';
import 'package:demo_app/shared/navigation/navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final Function callback;

  const AppHeader({super.key, required this.callback});

  void loginHandler(BuildContext context, Map<String, dynamic> args) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const Center(child: LoginDialog()),
    );
  }

  void registerHandler(BuildContext context, Map<String, dynamic> args) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const Center(child: RegisterDialog()),
    );
  }

  void logoutHandler(BuildContext context, Map<String, dynamic> args) {
    Provider.of<AuthViewModel>(context, listen: false).logout();
    callback(context, <String, dynamic>{'route': Routes.home.name});
  }

  @override
  Widget build(BuildContext context) => AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                NavigationItem(
                  'Home',
                  args: <String, dynamic>{'route': Routes.home.name},
                  callback: callback,
                ),
                NavigationItem(
                  'Cuisines',
                  args: <String, dynamic>{'route': Routes.cuisines.name},
                  callback: callback,
                ),
                NavigationItem(
                  'Recipes',
                  args: <String, dynamic>{
                    'route': "${Routes.recipes.name}/all"
                  },
                  callback: callback,
                ),
              ],
            ),
            Consumer<AuthViewModel>(
                builder:
                    (BuildContext context, AuthViewModel viewModel, child) =>
                        Row(
                          children: viewModel.token != null
                              ? [
                                  NavigationItem(
                                    'My Profile',
                                    args: <String, dynamic>{
                                      'route': Routes.profile.name
                                    },
                                    callback: callback,
                                  ),
                                  NavigationItem(
                                    'Sign Out',
                                    args: <String, dynamic>{
                                      'token': viewModel.token
                                    },
                                    callback: logoutHandler,
                                  )
                                ]
                              : [
                                  NavigationItem(
                                    'Sign In',
                                    args: const <String, dynamic>{},
                                    callback: loginHandler,
                                  ),
                                  NavigationItem(
                                    'Sign Up',
                                    args: const <String, dynamic>{},
                                    callback: registerHandler,
                                  ),
                                ],
                        )),
          ],
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
