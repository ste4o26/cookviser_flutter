import 'dart:ui';

import 'package:demo_app/domain/user/view_models/most_liked_users_view_model.dart';
import 'package:demo_app/shered/user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BestThreeUsers extends StatefulWidget {
  const BestThreeUsers({super.key});

  @override
  State<BestThreeUsers> createState() => _BestThreeUsersState();
}

class _BestThreeUsersState extends State<BestThreeUsers> {
  late final Future<void> _future;

  @override
  void didChangeDependencies() {
    _future = Provider.of<BestThreeUserViewModel>(context, listen: false)
        .fetchBestThree();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 450,
              child: Column(
                children: [
                  const Expanded(
                    child: Text(
                      "Top 3 Users with Most Rated Recipes: ",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 350,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Consumer<BestThreeUserViewModel>(
                            builder: (context, viewModel, child) {
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: viewModel.users.length,
                            itemBuilder: (context, index) {
                              return UserCard(user: viewModel.users[index]);
                            },
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            );
          case ConnectionState.waiting:
            return SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 450,
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                ),
              ),
            );
          default:
            throw Exception();
        }
      },
    );
  }
}
