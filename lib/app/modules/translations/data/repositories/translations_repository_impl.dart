import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/translations/data/datasources/translations_datasource.dart';
import 'package:personal_planner/app/modules/translations/data/models/translation_not_found_exception.dart';
import 'package:personal_planner/app/modules/translations/domain/entities/translation_not_found_failure.dart';
import 'package:personal_planner/app/modules/translations/domain/repositories/translations_repository.dart';
import 'package:personal_planner/app/shared/error/exception.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/models/no_content_success.dart';

class TranslationsRepositoryImpl implements TranslationsRepository {
  final TranslationsDatasource datasource;

  TranslationsRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, NoContentSuccess>> loadTranslations() async {
    try {
      final translations = await datasource.fetchTranslations();
      await datasource.cacheTranslations(translations);
      return Right(NoContentSuccess());
    } on ServerException {
      return Left(ServerFailure());
    } on LocalStorageException {
      return Left(LocalStorageFailure());
    } catch (e) {
      throw UnexpectedFailure(
        message: 'TranslationsRepositoryImpl - loadTranslations: $e',
      );
    }
  }

  @override
  Either<Failure, String> getTranslation(String key) {
    try {
      final translation = datasource.getTranslation(key);
      return Right(translation);
    } on TranslationNotFoundException {
      return Left(TranslationNotFoundFailure());
    } on DataParsingException {
      return Left(DataParsingFailure());
    } on LocalStorageException {
      return Left(LocalStorageFailure());
    } catch (e) {
      return Left(
        UnexpectedFailure(
          message: 'TranslationsRepositoryImpl - getTranslation: $e',
        ),
      );
    }
  }
}
