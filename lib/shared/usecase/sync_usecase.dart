import 'package:dartz/dartz.dart';
import 'package:personal_planner/shared/error/failure.dart';

abstract class SyncUsecase<ReturnType, Params> {
  Either<Failure, ReturnType> call(Params params);
}
