import 'package:demo_app/domain/user/views/user_list.dart';
import 'package:demo_app/pages/view_models/users.dart';
import 'package:demo_app/shared/navigation/header.dart';
import 'package:demo_app/shared/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<StatefulWidget> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late Future<void> _future;

  @override
  void didChangeDependencies() {
    _future = Provider.of<UsersViewModel>(context, listen: false).fetchAll();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
        body: FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
              snapshot.connectionState != ConnectionState.done
                  ? const Center(
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const UsersList(),
        ),
      );
}
