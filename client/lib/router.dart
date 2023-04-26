import 'package:demo_app/constants.dart';
import 'package:demo_app/pages/cuisines.dart';
import 'package:demo_app/pages/home.dart';
import 'package:demo_app/pages/not_found.dart';
import 'package:demo_app/pages/profile.dart';
import 'package:demo_app/pages/recipes.dart';
import 'package:go_router/go_router.dart';

class CustomRouter {
  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: Routes.cuisines.name,
        builder: (context, state) => const CuisinesPage(),
      ),
      GoRoute(
          path: "${Routes.recipes.name}/:cuisine",
          builder: (context, state) =>
              RecipesPage(cuisine: state.params["cuisine"] ?? "")),
      GoRoute(
          path: Routes.profile.name,
          builder: (context, state) => const ProfilePage()),
      GoRoute(
          path: Routes.home.name,
          builder: (context, state) => const HomePage()),
    ],
    errorBuilder: (context, state) =>
        NotFoundPage(error: state.error.toString()),
  );

  get routerDelegate => _router.routerDelegate;

  get routeInformationParser => _router.routeInformationParser;

  get routeInformationProvider => _router.routeInformationProvider;
}
