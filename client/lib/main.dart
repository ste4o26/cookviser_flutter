import "package:demo_app/domain/home/view_models/home_view_model.dart";
import "package:demo_app/domain/rating/view_models/rating_view_model.dart";
import "package:demo_app/domain/recipe/view_models/recipes_list.view_model.dart";
import "package:demo_app/domain/user/view_models/user.view_model.dart";
import "package:demo_app/shared/router.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "domain/cuisine/view_models/cuisine_list.view_model.dart";

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
        initialRoute: "/",
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
