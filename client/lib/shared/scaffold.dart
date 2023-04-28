import 'package:demo_app/pages/view_models/auth.dart';
import 'package:demo_app/shared/navigation/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation/drawer.dart';

class AppScaffold extends StatefulWidget {
  final Widget body;
  final Widget? bottomNavigationBar;

  const AppScaffold({super.key, required this.body, this.bottomNavigationBar});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  void didChangeDependencies() {
    Provider.of<AuthViewModel>(context, listen: false).loadLoggedInUser();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Consumer<AuthViewModel>(
        builder: (BuildContext context, AuthViewModel viewModel, child) =>
            Scaffold(
          drawer: viewModel.token != null ? const AppDrawer() : null,
          appBar: const AppHeader(),
          body: widget.body,
          bottomNavigationBar: widget.bottomNavigationBar,
        ),
      );
}
