import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/modules/home/presentation/home_screen.dart';
import 'package:personal_planner/app/shared/theme/themes/cyberwave_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData(colorScheme: CyberwaveTheme.darkScheme()),
        themeMode: ThemeMode.dark,
        home: HomeScreen(),
      ),
    );
  }
}
