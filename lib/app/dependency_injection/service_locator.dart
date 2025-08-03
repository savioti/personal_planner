import 'package:get_it/get_it.dart';
import 'package:personal_planner/modules/translations/data/datasources/translations_datasource.dart';
import 'package:personal_planner/modules/translations/data/datasources/translations_datasource_impl.dart';
import 'package:personal_planner/modules/translations/data/repositories/translations_repository_impl.dart';
import 'package:personal_planner/modules/translations/domain/repositories/translations_repository.dart';
import 'package:personal_planner/modules/translations/domain/usecases/get_translation_usecase.dart';
import 'package:personal_planner/modules/translations/domain/usecases/load_translations_usecase.dart';
import 'package:personal_planner/modules/translations/presentation/translations_controller.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  _registerDataSources();
  _registerRepositories();
  _registerUseCases();
  _registerControllers();
}

void _registerDataSources() {
  serviceLocator.registerLazySingleton<TranslationsDatasource>(
    () => TranslationsDatasourceImpl(),
  );
}

void _registerRepositories() {
  serviceLocator.registerLazySingleton<TranslationsRepository>(
    () => TranslationsRepositoryImpl(datasource: serviceLocator.get()),
  );
}

void _registerUseCases() {
  serviceLocator.registerLazySingleton<GetTranslationUsecase>(
    () => GetTranslationUsecase(repository: serviceLocator.get()),
  );
  serviceLocator.registerLazySingleton<LoadTranslationsUsecase>(
    () => LoadTranslationsUsecase(repository: serviceLocator.get()),
  );
}

void _registerControllers() {
  serviceLocator.registerLazySingleton<TranslationsController>(
    () => TranslationsController(
      getTranslationUsecase: serviceLocator.get(),
      loadTranslationsUsecase: serviceLocator.get(),
    ),
  );
}
