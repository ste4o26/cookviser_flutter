import 'package:demo_app/constants.dart';
import 'package:demo_app/domain/user/models/user.dart';
import 'package:demo_app/shared/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => CustomCard(
          children: [
            InkWell(
              onTap: () =>
                  context.go("${Routes.profile.name}/${user.username}"),
              child: CircleAvatar(
                radius: constraints.maxHeight * 0.35,
                backgroundImage: NetworkImage(user.profileImageUrl),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  user.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  user.email,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                RatingBar.builder(
                  ignoreGestures: true,
                  itemSize: 25,
                  itemCount: 5,
                  maxRating: 5,
                  minRating: 1,
                  initialRating: user.overallRating,
                  itemBuilder: (BuildContext context, _) => const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onRatingUpdate: (double value) {},
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(user.overallRating.toStringAsFixed(2))
              ],
            )
          ],
        ),
      );
}
