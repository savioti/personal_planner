import 'package:dartz/dartz.dart';
import 'package:personal_planner/shared/error/failure.dart';

abstract class AsyncUsecase<ReturnType, Params> {
  Future<Either<Failure, ReturnType>> call(Params params);
}
