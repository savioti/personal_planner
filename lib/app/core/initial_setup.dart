import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/translations/presentation/translations_controller.dart';

Future<void> runInitialSetup() async {
  await serviceLocator.get<TranslationsController>().loadTranslations();
}
