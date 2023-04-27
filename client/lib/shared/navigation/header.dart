import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/auth/views/login.dart';
import 'package:demo_app/domain/auth/views/register.dart';
import 'package:demo_app/pages/view_models/auth.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/shared/navigation/header_item.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<StatefulWidget> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late Future<void> _future;

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
    String? token = args['token'];
    redirectHandler(context, <String, dynamic>{'route': Routes.home.name});

    if (token != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _future = Provider.of<AuthViewModel>(context, listen: false).logout();
        });
      });
    }
  }

  void redirectHandler(BuildContext context, Map<String, dynamic> args) =>
      GoRouter.of(context).go(args["route"]);

  @override
  void didChangeDependencies() {
    _future =
        Provider.of<AuthViewModel>(context, listen: false).loadLoggedInUser();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
          Container(
              color: Colors.amber,
              alignment: Alignment.centerLeft,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      HeaderItem(
                        'Home',
                        args: <String, dynamic>{'route': Routes.home.name},
                        callback: redirectHandler,
                      ),
                      HeaderItem(
                        'Cuisines',
                        args: <String, dynamic>{'route': Routes.cuisines.name},
                        callback: redirectHandler,
                      ),
                      HeaderItem(
                        'Recipes',
                        args: <String, dynamic>{'route': "${Routes.recipes.name}/all"},
                        callback: redirectHandler,
                      ),
                      HeaderItem(
                        'Users',
                        args: <String, dynamic>{'route': Routes.allUsers.name},
                        callback: redirectHandler,
                      ),
                    ],
                  ),
                  Consumer<AuthViewModel>(
                      builder: (BuildContext context, AuthViewModel viewModel,
                              child) =>
                          Row(
                            children: viewModel.token != null
                                ? [
                                    HeaderItem(
                                      'My Profile',
                                      args: <String, dynamic>{
                                        'route': Routes.profile.name
                                      },
                                      callback: redirectHandler,
                                    ),
                                    HeaderItem(
                                      'Sign Out',
                                      args: <String, dynamic>{
                                        'token': viewModel.token
                                      },
                                      callback: logoutHandler,
                                    )
                                  ]
                                : [
                                    HeaderItem(
                                      'Sign In',
                                      args: <String, dynamic>{},
                                      callback: loginHandler,
                                    ),
                                    HeaderItem(
                                      'Sign Up',
                                      args: <String, dynamic>{},
                                      callback: registerHandler,
                                    ),
                                  ],
                          )),
                ],
              )));
}
