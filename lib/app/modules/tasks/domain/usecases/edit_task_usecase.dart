import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/edit_task_request.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/domain/repositories/tasks_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/usecase/async_usecase.dart';

class EditTaskUsecase extends AsyncUsecase<TaskEntity, EditTaskRequest> {
  final TasksRepository _repository;

  EditTaskUsecase({required TasksRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, TaskEntity>> call(EditTaskRequest request) async {
    try {
      return await _repository.editTask(request);
    } catch (e) {
      return Left(
        Failure(
          message: 'EditTaskUsecase - Failed to edit Task: ${e.toString()}',
        ),
      );
    }
  }
}
