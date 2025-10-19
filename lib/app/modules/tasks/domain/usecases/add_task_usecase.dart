import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/add_task_request.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/domain/repositories/tasks_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/usecase/async_usecase.dart';

class AddTaskUsecase extends AsyncUsecase<TaskEntity, AddTaskRequest> {
  final TasksRepository _repository;

  AddTaskUsecase({required TasksRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, TaskEntity>> call(AddTaskRequest request) async {
    try {
      return await _repository.addTask(request);
    } catch (e) {
      return Left(
        Failure(
          message: 'AddTaskUsecase - Failed to add Task: ${e.toString()}',
        ),
      );
    }
  }
}
