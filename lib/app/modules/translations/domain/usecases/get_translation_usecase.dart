import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/translations/domain/repositories/translations_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/usecase/sync_usecase.dart';

class GetTranslationUsecase extends SyncUsecase<String, String> {
  final TranslationsRepository repository;

  GetTranslationUsecase({required this.repository});

  @override
  Either<Failure, String> call(String params) {
    return repository.getTranslation(params);
  }
}
