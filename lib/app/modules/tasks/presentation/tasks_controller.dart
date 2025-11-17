import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/add_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/complete_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/delete_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/edit_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_all_pending_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_backlog_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_overdue_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/add_task_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/complete_task_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/delete_task_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/edit_task_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/get_all_pending_tasks_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/get_backlog_tasks_request_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/get_overdue_tasks_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/extensions/date_time_extension.dart';

class TasksController {
  final AddTaskUsecase _addTaskUsecase;
  final GetTasksUsecase _getTasksUsecase;
  final EditTaskUsecase _editTaskUsecase;
  final GetAllPendingTasksUsecase _getAllPendingTasksUsecase;
  final GetBacklogTasksRequestUsecase _getBacklogTasksRequestUsecase;
  final CompleteTaskUsecase _completeTaskUsecase;
  final DeleteTaskUsecase _deleteTaskUsecase;
  final GetOverdueTasksUsecase _getOverdueTasksUsecase;

  TasksController({
    required AddTaskUsecase addTaskUsecase,
    required GetTasksUsecase getTasksUsecase,
    required EditTaskUsecase editTaskUsecase,
    required GetAllPendingTasksUsecase getAllPendingTasksUsecase,
    required GetBacklogTasksRequestUsecase getBacklogTasksRequestUsecase,
    required CompleteTaskUsecase completeTaskUsecase,
    required DeleteTaskUsecase deleteTaskUsecase,
    required GetOverdueTasksUsecase getOverdueTasksUsecase,
  }) : _addTaskUsecase = addTaskUsecase,
       _getTasksUsecase = getTasksUsecase,
       _editTaskUsecase = editTaskUsecase,
       _getAllPendingTasksUsecase = getAllPendingTasksUsecase,
       _getBacklogTasksRequestUsecase = getBacklogTasksRequestUsecase,
       _completeTaskUsecase = completeTaskUsecase,
       _deleteTaskUsecase = deleteTaskUsecase,
       _getOverdueTasksUsecase = getOverdueTasksUsecase {
    _initializeProviders();
  }

  late final Provider<TasksController> taskControllerProvider;
  late final FutureProvider<List<TaskEntity>> weekTasksProvider;
  late final FutureProvider<List<TaskEntity>> backlogTasksProvider;
  late final FutureProvider<List<TaskEntity>> overdueTasksProvider;

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

  Future<Either<Failure, TaskEntity>> editTask({
    required String taskId,
    required String title,
    String? description,
    DateTime? deadline,
  }) async {
    try {
      final request = EditTaskRequest(
        taskId: taskId,
        title: title,
        description: description,
        deadline: deadline,
      );

      return await _editTaskUsecase(request);
    } catch (e) {
      return Left(
        Failure(
          message:
              'TasksController.editTask - Failed to edit task: ${e.toString()}',
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
    DateTime from,
  ) async {
    try {
      return await _getBacklogTasksRequestUsecase(
        GetBacklogTasksRequest(from: from),
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

  Future<Either<Failure, List<TaskEntity>>> getOverdueTasks(
    DateTime before,
  ) async {
    try {
      return await _getOverdueTasksUsecase(
        GetOverdueTasksRequest(before: before),
      );
    } catch (e) {
      return Left(
        Failure(
          message:
              'TasksController.getOverdueTasks - Failed to get overdue tasks: ${e.toString()}',
        ),
      );
    }
  }

  void _initializeProviders() {
    taskControllerProvider = Provider<TasksController>((ref) {
      return serviceLocator<TasksController>();
    });

    weekTasksProvider = FutureProvider<List<TaskEntity>>((ref) async {
      final result = await getTasksForCurrentWeek();

      return result.fold(
        (failure) => throw Exception(failure.message),
        (tasks) => tasks,
      );
    });

    backlogTasksProvider = FutureProvider<List<TaskEntity>>((ref) async {
      final now = DateTime.now();
      final startOfNextWeek = now
          .add(Duration(days: 7 - now.weekday + 1))
          .toDateOnly;
      final result = await getBacklogTasks(startOfNextWeek);

      return result.fold(
        (failure) => throw Exception(failure.message),
        (tasks) => tasks,
      );
    });

    overdueTasksProvider = FutureProvider<List<TaskEntity>>((ref) async {
      final beforeDate = DateTime.now().toDateOnly
          .subtract(const Duration(days: 1))
          .dayEnd;
      final result = await getOverdueTasks(beforeDate);
      print(beforeDate);

      return result.fold(
        (failure) => throw Exception(failure.message),
        (tasks) => tasks,
      );
    });
  }
}
