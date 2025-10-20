import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_overdue_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/domain/repositories/tasks_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/usecase/async_usecase.dart';

class GetOverdueTasksUsecase
    implements AsyncUsecase<List<TaskEntity>, GetOverdueTasksRequest> {
  final TasksRepository _repository;

  GetOverdueTasksUsecase({required TasksRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, List<TaskEntity>>> call(
    GetOverdueTasksRequest request,
  ) async {
    try {
      return await _repository.getOverdueTasks(request);
    } catch (e) {
      return Left(
        Failure(
          message:
              'GetOverdueTasksRequestUsecase.call - Failed to get overdue tasks: ${e.toString()}',
        ),
      );
    }
  }
}
