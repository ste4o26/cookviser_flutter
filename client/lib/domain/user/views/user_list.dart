import 'package:demo_app/constants.dart';
import 'package:demo_app/pages/view_models/users.dart';
import 'package:demo_app/shared/card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            Consumer<UsersViewModel>(
          builder: (context, viewModel, child) => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: constraints.maxWidth ~/ CUSTOM_CARD_SIZE,
              crossAxisSpacing: 10,
              mainAxisSpacing: 50,
            ),
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            itemCount: viewModel.users.length,
            itemBuilder: (context, index) => CustomCard(
              children: [
                SizedBox(
                  width: CUSTOM_CARD_SIZE,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(viewModel.users[index].profileImageUrl),
                    ),
                    title: Row(
                      children: [
                        const Text('username: '),
                        Center(child: Text(viewModel.users[index].username)),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        const Text('email: '),
                        Center(child: Text(viewModel.users[index].email)),
                      ],
                    ),
                  ),
                ),
                Text(
                    'Current role: ${viewModel.users[index].role.roleName.substring(5)}'),
                viewModel.users[index].role.roleName == 'ROLE_USER'
                    ? TextButton(
                        onPressed: () async {
                          final confirm = await _showDialog(context,
                                  'Are you sure wanted to Promote ${viewModel.users[index].username}') ??
                              false;

                          if (confirm) {
                            viewModel
                                .promote(viewModel.users[index].username)
                                .then(
                                    (value) => viewModel.users[index] = value);
                          }
                        },
                        child: const Text(
                          "Promote",
                          style: TextStyle(
                            color: Colors.lightGreenAccent,
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () async {
                          final confirm = await _showDialog(context,
                                  'Are you sure wanted to Demote ${viewModel.users[index].username}') ??
                              false;

                          if (confirm) {
                            viewModel
                                .demote((viewModel.users[index].username))
                                .then(
                                    (value) => viewModel.users[index] = value);
                          }
                        },
                        child: const Text(
                          "Demote",
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      );

  Future _showDialog(context, String content) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            content,
            style: const TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Text(
                    'CONFIRM',
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
                TextButton(
                  child: const Text(
                    'CANCEL',
                  ),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }
}
