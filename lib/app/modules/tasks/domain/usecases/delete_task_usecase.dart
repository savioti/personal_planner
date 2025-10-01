import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/delete_task_request.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/domain/repositories/tasks_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/usecase/async_usecase.dart';

class DeleteTaskUsecase extends AsyncUsecase<TaskEntity, DeleteTaskRequest> {
  final TasksRepository _repository;

  DeleteTaskUsecase({required TasksRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, TaskEntity>> call(DeleteTaskRequest request) async {
    try {
      return await _repository.deleteTask(request);
    } catch (e) {
      return Left(
        Failure(
          message: 'DeleteTaskUsecase - Failed to delete Task: ${e.toString()}',
        ),
      );
    }
  }
}
