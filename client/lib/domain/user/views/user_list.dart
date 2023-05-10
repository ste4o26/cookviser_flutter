import 'package:demo_app/constants.dart';
import 'package:demo_app/pages/view_models/users.dart';
import 'package:demo_app/shared/card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              childAspectRatio: 2,
            ),
            shrinkWrap: true,
            itemCount: viewModel.users.length,
            itemBuilder: (context, index) => CustomCard(
              children: [
                InkWell(
                  onTap: () => context.go(
                      "${Routes.profile.name}/${viewModel.users[index].username}"),
                  child: SizedBox(
                    width: CUSTOM_CARD_SIZE,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            viewModel.users[index].profileImageUrl),
                      ),
                      title: Row(
                        children: [
                          const Text('username: '),
                          Text(viewModel.users[index].username),
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
                ),
                Text(
                    'Current role: ${viewModel.users[index].role.name.substring(5)}'),
                viewModel.users[index].role == Role.user
                    ? TextButton(
                        onPressed: () async {
                          final confirm = await _showDialog(context,
                                  'Are you sure wanted to Promote ${viewModel.users[index].username}') ??
                              false;

                          if (confirm) {
                            await viewModel.promote(index);
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
                            await viewModel.demote(index);
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
                    context.pop(true);
                  },
                ),
                TextButton(
                  child: const Text(
                    'CANCEL',
                  ),
                  onPressed: () {
                    context.pop(false);
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
