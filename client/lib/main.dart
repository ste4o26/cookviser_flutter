import 'package:demo_app/pages/view_models/home.dart';
import 'package:demo_app/domain/rating/view_models/rating.dart';
import 'package:demo_app/pages/view_models/recipes.dart';
import 'package:demo_app/pages/view_models/auth.dart';
import 'package:demo_app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/view_models/cuisines.dart';

void main() {
  final app = createApp();
  runApp(app);
}

MultiProvider createApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthViewModel()),
      ChangeNotifierProvider(create: (context) => CuisineListViewModel()),
      ChangeNotifierProvider(create: (context) => RecipeListViewModel()),
      ChangeNotifierProvider(create: (context) => RatingViewModel()),
      ChangeNotifierProvider(create: (context) => HomeViewModel()),
    ],
    child: const CookviserApp(),
  );
}

class CookviserApp extends StatelessWidget {
  const CookviserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cookviser',
        initialRoute: '/',
        onGenerateRoute: RouterGenerator.generate,
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(
            cardColor: Colors.white,
            primarySwatch: Colors.amber,
            backgroundColor: Colors.grey.shade300,
          ),
        ));
  }
}
