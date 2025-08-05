import 'package:flutter/material.dart';
import 'package:personal_planner/app/app.dart';
import 'package:personal_planner/app/core/initial_setup.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';

void main() async {
  await _setup();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

Future<void> _setup() async {
  await setupServiceLocator();
  await runInitialSetup();
}
