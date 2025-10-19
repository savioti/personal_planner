import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/add_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/complete_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/delete_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_all_pending_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_backlog_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/add_task_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/complete_task_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/delete_task_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/get_all_pending_tasks_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/get_backlog_tasks_request_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/extensions/date_time_extension.dart';

class TasksController {
  final AddTaskUsecase _addTaskUsecase;
  final GetTasksUsecase _getTasksUsecase;
  final GetAllPendingTasksUsecase _getAllPendingTasksUsecase;
  final GetBacklogTasksRequestUsecase _getBacklogTasksRequestUsecase;
  final CompleteTaskUsecase _completeTaskUsecase;
  final DeleteTaskUsecase _deleteTaskUsecase;

  TasksController({
    required AddTaskUsecase addTaskUsecase,
    required GetTasksUsecase getTasksUsecase,
    required GetAllPendingTasksUsecase getAllPendingTasksUsecase,
    required GetBacklogTasksRequestUsecase getBacklogTasksRequestUsecase,
    required CompleteTaskUsecase completeTaskUsecase,
    required DeleteTaskUsecase deleteTaskUsecase,
  }) : _addTaskUsecase = addTaskUsecase,
       _getTasksUsecase = getTasksUsecase,
       _getAllPendingTasksUsecase = getAllPendingTasksUsecase,
       _getBacklogTasksRequestUsecase = getBacklogTasksRequestUsecase,
       _completeTaskUsecase = completeTaskUsecase,
       _deleteTaskUsecase = deleteTaskUsecase {
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

  Future<Either<Failure, List<TaskEntity>>> getTasksForCurrentWeek() async {
    try {
      final now = DateTime.now();
      final currentWeekDateRange = now.getWeekDateRange;

      return await _getTasksUsecase(
        GetTasksRequest(
          dateRangeStart: currentWeekDateRange.start,
          dateRangeEnd: currentWeekDateRange.end,
          getOnlyPending: false,
        ),
      );
    } catch (e) {
      return Left(
        Failure(
          message:
              'TasksController.getAllPendingTasks - Failed to get all pending tasks: ${e.toString()}',
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
              'TasksController.getAllPendingTasks - Failed to get all pending tasks: ${e.toString()}',
        ),
      );
    }
  }

  Future<Either<Failure, List<TaskEntity>>> getBacklogTasks(
    DateTime before,
  ) async {
    try {
      return await _getBacklogTasksRequestUsecase(
        GetBacklogTasksRequest(before: before),
      );
    } catch (e) {
      return Left(
        Failure(
          message:
              'TasksController.getBacklogTasks - Failed to get backlog tasks: ${e.toString()}',
        ),
      );
    }
  }

  Future<Either<Failure, TaskEntity>> completeTask({
    required String taskId,
  }) async {
    try {
      final request = CompleteTaskRequest(taskId: taskId);
      return await _completeTaskUsecase(request);
    } catch (e) {
      return Left(
        Failure(
          message:
              'TasksController.completeTask - Failed to complete task: ${e.toString()}',
        ),
      );
    }
  }

  Future<Either<Failure, TaskEntity>> deleteTask({
    required String taskId,
  }) async {
    try {
      final request = DeleteTaskRequest(taskId: taskId);
      return await _deleteTaskUsecase(request);
    } catch (e) {
      return Left(
        Failure(
          message:
              'TasksController.deleteTask - Failed to delete task: ${e.toString()}',
        ),
      );
    }
  }

  void _initializeProviders() {
    taskControllerProvider = Provider<TasksController>((ref) {
      return serviceLocator<TasksController>();
    });

    tasksProvider = FutureProvider<List<TaskEntity>>((ref) async {
      final result = await getTasksForCurrentWeek();

      return result.fold(
        (failure) => throw Exception(failure.message),
        (tasks) => tasks,
      );
    });
  }
}
