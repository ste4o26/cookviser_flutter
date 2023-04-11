import "package:demo_app/domain/auth/views/login.view.dart";
import "package:demo_app/domain/auth/views/register.view.dart";
import "package:demo_app/domain/user/view_models/user.view_model.dart";
import "package:flutter/material.dart";
import "package:demo_app/shered/header_item.dart";
import "package:provider/provider.dart";

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void openLoginDialogHandler(BuildContext context, Map<String, dynamic> args) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Center(child: LoginDialog()),
    );
  }

  void openRegisterDialogHandler(
      BuildContext context, Map<String, dynamic> args) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const Center(child: RegisterDialog()),
    );
  }

  void goToPagehandler(BuildContext context, Map<String, dynamic> args) {
    Navigator.pushNamed(
      context,
      args["route"],
      arguments: args["arguments"] ?? {},
    );
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
                callback: this.goToPagehandler,
              ),
              HeaderItem(
                "Cuisines",
                args: <String, dynamic>{"route": "/cuisines"},
                callback: this.goToPagehandler,
              ),
              HeaderItem(
                "Recipes",
                args: <String, dynamic>{"route": "/all_recipes"},
                callback: this.goToPagehandler,
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
                          args: <String, dynamic>{
                            "route": "/my_profile",
                            "user": viewModel.user,
                          },
                          callback: this.goToPagehandler,
                        )
                      ]
                    : [
                        HeaderItem(
                          "Sign In",
                          args: <String, dynamic>{"route": "/sign_in"},
                          callback: this.openLoginDialogHandler,
                        ),
                        HeaderItem(
                          "Sign Up",
                          args: <String, dynamic>{"route": "/sign_up"},
                          callback: this.openRegisterDialogHandler,
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
