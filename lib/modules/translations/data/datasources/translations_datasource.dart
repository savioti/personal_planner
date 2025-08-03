import 'package:personal_planner/modules/translations/data/models/translations_model.dart';

abstract class TranslationsDatasource {
  Future<TranslationsModel> fetchTranslations();

  TranslationsModel getCachedTranslations();

  Future<void> cacheTranslations(TranslationsModel translations);

  String getTranslation(String key);
}
