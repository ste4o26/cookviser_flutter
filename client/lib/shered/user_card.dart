import 'package:demo_app/domain/user/models/user.model.dart';
import 'package:demo_app/shered/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) => CustomCard(
        children: [
          InkWell(
            onTap: () {},
            child: CircleAvatar(
              minRadius: 125,
              backgroundImage: NetworkImage(user.profileImageUrl),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                "username: ${user.username}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                "email: ${user.email}",
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
      );
}
