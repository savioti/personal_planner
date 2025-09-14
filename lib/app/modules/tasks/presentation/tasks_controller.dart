import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/add_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_all_pending_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/add_task_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/get_all_pending_tasks_usecase.dart';
import 'package:personal_planner/app/shared/error/failure.dart';

class TasksController {
  final AddTaskUsecase _addTaskUsecase;
  final GetAllPendingTasksUsecase _getAllPendingTasksUsecase;

  TasksController({
    required AddTaskUsecase addTaskUsecase,
    required GetAllPendingTasksUsecase getAllPendingTasksUsecase,
  }) : _addTaskUsecase = addTaskUsecase,
       _getAllPendingTasksUsecase = getAllPendingTasksUsecase {
    _initializeProviders();
  }

  late final Provider<TasksController> taskControllerProvider;
  late final FutureProvider<List<TaskEntity>> tasksProvider;

  Future<Either<Failure, TaskEntity>> addTask({
    required String title,
    String? description,
    DateTime? deadline,
  }) async {
    try {
      final request = AddTaskRequest(
        title: title,
        description: description,
        deadline: deadline,
      );

      return await _addTaskUsecase(request);
    } catch (e) {
      return Left(
        Failure(
          message:
              'TasksController.addTask - Failed to add task: ${e.toString()}',
        ),
      );
    }
  }

  Future<Either<Failure, List<TaskEntity>>> getAllPendingTasks() async {
    try {
      return await _getAllPendingTasksUsecase(GetAllPendingTasksRequest());
    } catch (e) {
      return Left(
        Failure(
          message:
              'TasksController.getTasks - Failed to get tasks: ${e.toString()}',
        ),
      );
    }
  }

  void _initializeProviders() {
    taskControllerProvider = Provider<TasksController>((ref) {
      return serviceLocator<TasksController>();
    });

    tasksProvider = FutureProvider<List<TaskEntity>>((ref) async {
      final result = await getAllPendingTasks();

      return result.fold(
        (failure) => throw Exception(failure.message),
        (tasks) => tasks,
      );
    });
  }
}
