import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/cuisine/views/create_cuisine.dart';
import 'package:demo_app/pages/view_models/auth.dart';
import 'package:demo_app/shared/navigation/navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void redirectHandler(BuildContext context, Map<String, dynamic> args) =>
      GoRouter.of(context).go(args["route"]);

  @override
  Widget build(BuildContext context) => Consumer<AuthViewModel>(
      builder: (BuildContext context, AuthViewModel viewModel, child) => Drawer(
              child: ListView(
            children: [
              const DrawerHeader(
                child: Center(
                    child: Text('Welcome', style: TextStyle(fontSize: 20))),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('User Action', style: TextStyle(fontSize: 20)),
                  const Divider(color: Colors.black),
                  NavigationItem('New Recipe',
                        args: <String, dynamic>{'route': Routes.newRecipe.name},
                        callback: redirectHandler,
                        icon: const Icon(Icons.restaurant)),
                ],
              ),
              const SizedBox(height: 100),
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
                      callback: redirectHandler,
                      icon: const Icon(Icons.person),
                    ),
                    NavigationItem(
                      'Create cuisine',
                      args: const {},
                      callback: (context, args) =>
                          showDialog(context: context, builder: (context) => const CreateCuisine()) ,
                      icon: const Icon(Icons.dinner_dining_outlined),
                    ),
                  ],
                ),
            ],
          )));
}
