import "package:demo_app/domain/auth/views/login.view.dart";
import "package:demo_app/domain/auth/views/register.view.dart";
import 'package:demo_app/domain/auth/view_models/auth.view_model.dart';
import "package:flutter/material.dart";
import "package:demo_app/shared/header_item.dart";
import "package:provider/provider.dart";

class Header extends StatefulWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
 
  @override
  State<StatefulWidget> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  void loginHandler(BuildContext context, Map<String, dynamic> args) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Center(child: LoginDialog()),
    );
  }

  void registerHandler(BuildContext context, Map<String, dynamic> args) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const Center(child: RegisterDialog()),
    );
  }

  void logoutHandler(BuildContext context, Map<String, dynamic> args) {
    String? token = args["token"];
    if (token != null) {
      Provider.of<AuthViewModel>(context, listen: false).logout();
    }
  }

  void redirectHandler(BuildContext context, Map<String, dynamic> args) {
    Navigator.pushNamed(
      context,
      args["route"],
      arguments: args["arguments"] ?? {},
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AuthViewModel>(context, listen: false).loadLoggedInUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                "Home",
                args: <String, dynamic>{"route": "/"},
                callback: this.redirectHandler,
              ),
              HeaderItem(
                "Cuisines",
                args: <String, dynamic>{"route": "/cuisines"},
                callback: this.redirectHandler,
              ),
              HeaderItem(
                "Recipes",
                args: <String, dynamic>{"route": "/all_recipes"},
                callback: this.redirectHandler,
              ),
            ],
          ),
          Consumer<AuthViewModel>(
            builder: (context, viewModel, child) {
              return Row(
                children: viewModel.token != null
                    ? [
                        HeaderItem(
                          "My Profile",
                          args: <String, dynamic>{"route": "/profile"},
                          callback: this.redirectHandler,
                        ),
                        HeaderItem(
                          "Sign Out",
                          args: <String, dynamic>{"token": viewModel.token},
                          callback: this.logoutHandler,
                        )
                      ]
                    : [
                        HeaderItem(
                          "Sign In",
                          args: <String, dynamic>{},
                          callback: this.loginHandler,
                        ),
                        HeaderItem(
                          "Sign Up",
                          args: <String, dynamic>{},
                          callback: this.registerHandler,
                        ),
                      ],
              );
            },
          ),
        ],
      ),
    );
  }
}
