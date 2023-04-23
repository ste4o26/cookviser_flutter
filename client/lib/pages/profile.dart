import 'package:demo_app/pages/view_models/auth.dart';
import 'package:demo_app/domain/user/views/user_details.dart';
import 'package:demo_app/shared/navigation/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final Future<void> _future;

  @override
  void didChangeDependencies() {
    _future = Provider.of<AuthViewModel>(
      context,
      listen: false,
    ).loadLoggedInUser();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const Header(),
        body: Center(
          child: LayoutBuilder(
            builder: (context, constraints) => Container(
              constraints: BoxConstraints(
                maxHeight: constraints.maxHeight * 0.8,
                maxWidth: constraints.maxWidth * 0.6,
              ),
              margin: const EdgeInsets.only(top: 100, bottom: 50),
              child: FutureBuilder(
                future: _future,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<dynamic> snapshot,
                ) =>
                    snapshot.connectionState != ConnectionState.done
                        ? const SizedBox(
                            height: 150,
                            width: 150,
                            child: CircularProgressIndicator(),
                          )
                        : Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.topCenter,
                            children: [
                              LayoutBuilder(
                                builder: (
                                  BuildContext context,
                                  BoxConstraints constraints,
                                ) =>
                                    Container(
                                  constraints: BoxConstraints(
                                    maxHeight: 800,
                                    maxWidth: constraints.maxWidth,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 242, 215, 142),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: const UserDetails(),
                                ),
                              ),
                              Positioned(
                                top: -1 * constraints.maxHeight * 0.1,
                                child: Consumer<AuthViewModel>(
                                  builder: (
                                    BuildContext context,
                                    AuthViewModel viewModel,
                                    child,
                                  ) =>
                                      CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: constraints.maxHeight * 0.1 + 1,
                                    child: CircleAvatar(
                                      radius: constraints.maxHeight * 0.1,
                                      backgroundImage: NetworkImage(
                                          viewModel.user!.profileImageUrl),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
              ),
            ),
          ),
        ),
      );
}
