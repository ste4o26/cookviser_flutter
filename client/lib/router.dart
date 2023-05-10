import 'package:demo_app/constants.dart';
import 'package:demo_app/pages/cuisines.dart';
import 'package:demo_app/pages/home.dart';
import 'package:demo_app/pages/not_found.dart';
import 'package:demo_app/pages/profile.dart';
import 'package:demo_app/pages/recipe_new.dart';
import 'package:demo_app/pages/recipes.dart';
import 'package:demo_app/pages/users.dart';
import 'package:demo_app/utils/guards.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final Guards _guards;

  late final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
          path: Routes.cuisines.name,
          builder: (context, state) => const CuisinesPage()),
      GoRoute(
        path: Routes.newRecipe.name,
        builder: (context, state) => RecipePage(key: UniqueKey()),
        redirect: (context, state) => _guards.loggedInGuard(context, state),
      ),
      GoRoute(
          path: "${Routes.recipes.name}/:cuisine",
          builder: (context, state) => RecipesPage(
              key: UniqueKey(), cuisine: state.params["cuisine"] ?? "")),
      GoRoute(
        path: "${Routes.profile.name}/:username",
        builder: (context, state) =>
            ProfilePage(key: UniqueKey(), username: state.params["username"]),
        redirect: (context, state) => _guards.loggedInGuard(context, state),
      ),
      GoRoute(
          path: Routes.root.name,
          redirect: (context, state) => Routes.home.name),
      GoRoute(
          path: Routes.home.name,
          builder: (context, state) => const HomePage()),
      GoRoute(
        path: Routes.allUsers.name,
        builder: (context, state) => const UsersPage(),
        redirect: (context, state) => _guards.authorityGuard(context, state),
      ),
    ],
    errorBuilder: (context, state) =>
        NotFoundPage(error: state.error.toString()),
  );

  AppRouter(this._guards);

  get router => _router;
}
