import "package:demo_app/pages/cuisines.page.dart";
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
      ChangeNotifierProvider(
        create: (context) => CuisineListViewModel(),
      ),
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
      routes: {
        '/': (context) => const Center(child: CuisinesPage()),
      },
    );
  }
}
