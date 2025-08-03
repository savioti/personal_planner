import 'package:flutter/material.dart';
import 'package:personal_planner/modules/home/presentation/home_screen.dart';
import 'package:personal_planner/shared/theme/themes/cyberwave_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: CyberwaveTheme.darkScheme()),
      themeMode: ThemeMode.dark,
      home: HomeScreen(),
    );
  }
}
