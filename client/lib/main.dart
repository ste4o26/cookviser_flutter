import "package:demo_app/domain/recipe/views_models/recipes_list.view_model.dart";
import "package:demo_app/shered/router.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "domain/cuisine/view_models/cuisine_list.view_model.dart";

void main() {
  var app = createApp();
  runApp(app);
}

MultiProvider createApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CuisineListViewModel()),
      ChangeNotifierProvider(create: (context) => RecipeListViewModel()),
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
