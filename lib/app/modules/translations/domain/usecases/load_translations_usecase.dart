import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/translations/domain/repositories/translations_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/models/no_content_success.dart';
import 'package:personal_planner/app/shared/models/no_params.dart';
import 'package:personal_planner/app/shared/usecase/async_usecase.dart';

class LoadTranslationsUsecase extends AsyncUsecase<NoContentSuccess, NoParams> {
  final TranslationsRepository repository;

  LoadTranslationsUsecase({required this.repository});

  @override
  Future<Either<Failure, NoContentSuccess>> call(NoParams params) async {
    return repository.loadTranslations();
  }
}
