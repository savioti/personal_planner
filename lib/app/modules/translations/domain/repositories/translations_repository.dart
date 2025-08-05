import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/models/no_content_success.dart';

abstract class TranslationsRepository {
  Future<Either<Failure, NoContentSuccess>> loadTranslations();

  Either<Failure, String> getTranslation(String key);
}
