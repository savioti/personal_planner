import 'package:personal_planner/app/modules/translations/domain/usecases/get_translation_usecase.dart';
import 'package:personal_planner/app/modules/translations/domain/usecases/load_translations_usecase.dart';
import 'package:personal_planner/app/shared/models/no_params.dart';

class TranslationsController {
  final GetTranslationUsecase getTranslationUsecase;
  final LoadTranslationsUsecase loadTranslationsUsecase;

  TranslationsController({
    required this.getTranslationUsecase,
    required this.loadTranslationsUsecase,
  });

  String call(String key) {
    final result = getTranslationUsecase(key);
    return result.fold(
      (failure) => 'Translation not found',
      (translation) => translation,
    );
  }

  Future<void> loadTranslations() async {
    await loadTranslationsUsecase(NoParams());
  }
}
