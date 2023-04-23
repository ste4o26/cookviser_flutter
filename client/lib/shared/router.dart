import 'package:demo_app/constants.dart';
import 'package:demo_app/pages/cuisines.page.dart';
import 'package:demo_app/pages/home.page.dart';
import 'package:demo_app/pages/not_found.page.dart';
import 'package:demo_app/pages/profile.page.dart';
import 'package:demo_app/pages/recipes.page.dart';
import 'package:flutter/material.dart';

class RouterGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    MaterialPageRoute? route;
    final uri = settings.name;

    Map args = {};
    if (settings.arguments is Map) {
      args = convertArguments(settings.arguments);
    }

    if (uri == Routes.home.name) {
      route = MaterialPageRoute(builder: (_) => const HomePage());
    } else if (uri == Routes.profile.name) {
      route = MaterialPageRoute(builder: (_) => const ProfilePage());
    } else if (uri == Routes.cuisines.name) {
      route = MaterialPageRoute(builder: (_) => const CuisinesPage());
    } else if (uri == Routes.cuisineRecipes.name) {
      route = MaterialPageRoute(
        builder: (_) => RecipesPage(cuisineName: args['cuisineName']),
      );
    } else if (uri == Routes.recipes.name) {
      route = MaterialPageRoute(builder: (_) => const RecipesPage());
    } else {
      route = MaterialPageRoute(builder: (_) => const NotFoundPage());
    }

    return route;
  }

  static convertArguments(Object? arguments) {
    return arguments is Map ? arguments : {};
  }
}
