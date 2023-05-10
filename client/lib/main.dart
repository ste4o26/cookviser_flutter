import 'package:demo_app/domain/rating/view_models/rating.dart';
import 'package:demo_app/pages/view_models/auth.dart';
import 'package:demo_app/pages/view_models/cuisine.dart';
import 'package:demo_app/pages/view_models/home.dart';
import 'package:demo_app/pages/view_models/profile.dart';
import 'package:demo_app/pages/view_models/recipe.dart';
import 'package:demo_app/pages/view_models/recipes.dart';
import 'package:demo_app/pages/view_models/users.dart';
import 'package:demo_app/router.dart';
import 'package:demo_app/utils/guards.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'pages/view_models/cuisines.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final app = createApp();
  runApp(app);
}

MultiProvider createApp() {
  final authViewModel = AuthViewModel();
  final guards = Guards(authViewModel);

  return MultiProvider(
    providers: [
      Provider(create: (context) => AppRouter(guards)),
      ChangeNotifierProvider(create: (context) => authViewModel),
      ChangeNotifierProvider(create: (context) => CuisineListViewModel()),
      ChangeNotifierProvider(create: (context) => RecipeViewModel()),
      ChangeNotifierProvider(create: (context) => RecipeListViewModel()),
      ChangeNotifierProvider(create: (context) => RatingViewModel()),
      ChangeNotifierProvider(create: (context) => HomeViewModel()),
      ChangeNotifierProvider(create: (context) => UsersViewModel()),
      ChangeNotifierProvider(create: (context) => CuisineViewModel()),
      ChangeNotifierProvider(create: (context) => ProfileViewModel()),
    ],
    child: const CookviserApp(),
  );
}

class CookviserApp extends StatefulWidget {
  const CookviserApp({super.key});

  @override
  State<StatefulWidget> createState() => _CookviserState();
}

class _CookviserState extends State<CookviserApp> {
  late final GoRouter _router;

  @override
  void didChangeDependencies() {
    _router = Provider.of<AppRouter>(context).router;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Cookviser',
        routerConfig: _router,
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(
            cardColor: Colors.white,
            primarySwatch: Colors.amber,
            backgroundColor: Colors.grey.shade300,
          ),
        ));
  }
}
