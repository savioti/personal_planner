import 'package:personal_planner/app/dependency_injection/service_locator.dart';
import 'package:personal_planner/modules/translations/presentation/translations_controller.dart';

Future<void> runInitialSetup() async {
  await serviceLocator.get<TranslationsController>().loadTranslations();
}
