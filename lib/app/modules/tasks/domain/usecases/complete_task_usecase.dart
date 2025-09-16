import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/complete_task_request.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/domain/repositories/tasks_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/usecase/async_usecase.dart';

class CompleteTaskUsecase
    implements AsyncUsecase<TaskEntity, CompleteTaskRequest> {
  final TasksRepository _repository;

  CompleteTaskUsecase({required TasksRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, TaskEntity>> call(CompleteTaskRequest request) async {
    try {
      return _repository.completeTask(request);
    } catch (e) {
      return Left(
        Failure(
          message:
              'CompleteTaskUsecase - Failed to complete task: ${e.toString()}',
        ),
      );
    }
  }
}
