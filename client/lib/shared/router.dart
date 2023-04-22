import "package:demo_app/pages/cuisines.page.dart";
import "package:demo_app/pages/home.page.dart";
import "package:demo_app/pages/not_found.page.dart";
import "package:demo_app/pages/profile.page.dart";
import "package:demo_app/pages/recipes.page.dart";
import "package:flutter/material.dart";

class RouterGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    final uri = settings.name;

    Map args = {};
    if (settings.arguments is Map) {
      args = convertArguments(settings.arguments);
    }

    switch (uri) {
      case "/":
        return MaterialPageRoute(builder: (_) => const HomePage());
      case "/profile":
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case "/cuisines":
        return MaterialPageRoute(builder: (_) => const CuisinesPage());
      case "/recipes_by_cuisine":
        return MaterialPageRoute(
            builder: (_) => RecipesPage(cuisineName: args["cuisineName"]));
      case "/all_recipes":
        return MaterialPageRoute(
            builder: (_) => const RecipesPage(cuisineName: null));
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }

  static convertArguments(Object? arguments) {
    return arguments is Map ? arguments : {};
  }
}
