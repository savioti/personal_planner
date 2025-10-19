import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/domain/repositories/tasks_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/usecase/async_usecase.dart';

class GetTasksUsecase
    implements AsyncUsecase<List<TaskEntity>, GetTasksRequest> {
  final TasksRepository _repository;

  GetTasksUsecase({required TasksRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, List<TaskEntity>>> call(
    GetTasksRequest request,
  ) async {
    try {
      return await _repository.getTasks(request);
    } catch (e) {
      return Left(
        Failure(
          message: 'GetTasksUsecase - Failed to get Tasks: ${e.toString()}',
        ),
      );
    }
  }
}
