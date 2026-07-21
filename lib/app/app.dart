import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/modules/home/presentation/home_screen.dart';
import 'package:personal_planner/app/shared/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedColorScheme = MaterialTheme.darkScheme();
    final materialTheme = MaterialTheme(
      MaterialTheme.defaultTextTheme(
        selectedColorScheme: selectedColorScheme,
      ),
    );

    return ProviderScope(
      child: MaterialApp(
        theme: materialTheme.theme(selectedColorScheme),
        darkTheme: materialTheme.theme(selectedColorScheme),
        themeMode: ThemeMode.dark,
        home: HomeScreen(),
      ),
    );
  }
}
