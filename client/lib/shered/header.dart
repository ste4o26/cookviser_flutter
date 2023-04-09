import "package:demo_app/domain/auth/views/register.view.dart";
import "package:demo_app/domain/user/models/user.model.dart";
import "package:flutter/material.dart";
import "package:demo_app/shered/header_item.dart";

class Header extends StatefulWidget implements PreferredSizeWidget {
  final UserModel? _user = null;
  const Header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<StatefulWidget> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  void openRegisterDialogHandler({Map args = const {}}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const Center(child: RegisterDialog()),
    );
  }

  void goToPagehandler({Map args = const {}}) {
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
                args: const {"route": "/"},
                callback: this.goToPagehandler,
              ),
              HeaderItem(
                "Cuisines",
                args: const {"route": "/cuisines"},
                callback: this.goToPagehandler,
              ),
              HeaderItem(
                "Recipes",
                args: const {"route": "/all_recipes"},
                callback: this.goToPagehandler,
              ),
            ],
          ),
          Row(
            children: [
              HeaderItem(
                "Sign In",
                args: const {"route": "/sign_in"},
                callback: () => {},
              ),
              HeaderItem(
                "Sign Up",
                args: const {"route": "/sign_up"},
                callback: this.openRegisterDialogHandler,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
