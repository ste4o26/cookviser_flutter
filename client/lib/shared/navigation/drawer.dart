import 'package:demo_app/constants.dart';
import 'package:demo_app/pages/view_models/auth.dart';
import 'package:demo_app/shared/navigation/navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  final Function callback;

  const AppDrawer({super.key, required this.callback});

  @override
  Widget build(BuildContext context) => Consumer<AuthViewModel>(
        builder: (BuildContext context, AuthViewModel viewModel, child) =>
            Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                child: Center(
                    child: Text('Welcome', style: TextStyle(fontSize: 20))),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('User Action', style: TextStyle(fontSize: 20)),
                  Divider(color: Colors.black)
                ],
              ),
              if (viewModel.user?.role == Role.moderator ||
                  viewModel.user?.role == Role.admin)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Admin Action', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 20),
                    NavigationItem(
                      'Active users',
                      args: <String, dynamic>{'route': Routes.allUsers.name},
                      callback: callback,
                      icon: const Icon(Icons.person),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
}
