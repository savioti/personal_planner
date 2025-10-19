import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_backlog_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/domain/repositories/tasks_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/usecase/async_usecase.dart';

class GetBacklogTasksRequestUsecase
    implements AsyncUsecase<List<TaskEntity>, GetBacklogTasksRequest> {
  final TasksRepository _repository;

  GetBacklogTasksRequestUsecase(this._repository);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(
    GetBacklogTasksRequest request,
  ) async {
    try {
      return await _repository.getBacklogTasks(request);
    } catch (e) {
      return Left(
        Failure(
          message:
              'GetBacklogTasksRequestUsecase.call - Failed to get backlog tasks: ${e.toString()}',
        ),
      );
    }
  }
}
