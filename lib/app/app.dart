import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/modules/home/presentation/home_screen.dart';
import 'package:personal_planner/app/shared/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedColorScheme = MaterialTheme.lightScheme();

    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: selectedColorScheme,
          textTheme: MaterialTheme.defaultTextTheme(
            selectedColorScheme: selectedColorScheme,
          ),
        ),
        themeMode: ThemeMode.dark,
        home: HomeScreen(),
      ),
    );
  }
}
