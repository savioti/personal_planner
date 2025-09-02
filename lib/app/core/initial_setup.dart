import 'package:firebase_core/firebase_core.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/translations/presentation/translations_controller.dart';
import 'package:personal_planner/firebase_options.dart';

Future<void> runInitialSetup() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await serviceLocator.get<TranslationsController>().loadTranslations();
}
