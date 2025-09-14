import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_all_pending_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/domain/repositories/tasks_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/usecase/async_usecase.dart';

class GetAllPendingTasksUsecase
    extends AsyncUsecase<List<TaskEntity>, GetAllPendingTasksRequest> {
  final TasksRepository _repository;

  GetAllPendingTasksUsecase({required TasksRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, List<TaskEntity>>> call(
    GetAllPendingTasksRequest request,
  ) async {
    try {
      final getEventsRequest = GetTasksRequest(
        dateRangeStart: null,
        dateRangeEnd: null,
        getOnlyPending: true,
      );

      return await _repository.getTasks(getEventsRequest);
    } catch (e) {
      return Left(
        Failure(
          message: 'GetTasksUsecase - Failed to add Task: ${e.toString()}',
        ),
      );
    }
  }
}
