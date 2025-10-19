import 'package:firebase_core/firebase_core.dart';
import 'package:personal_planner/firebase_options.dart';

Future<void> runInitialSetup() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
