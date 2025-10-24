import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/tasks/data/datasources/tasks_datasource.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/add_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/complete_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/delete_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/edit_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_backlog_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_overdue_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/modules/tasks/domain/repositories/tasks_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksDatasource _datasource;

  TasksRepositoryImpl({required TasksDatasource datasource})
    : _datasource = datasource;

  @override
  Future<Either<Failure, TaskEntity>> addTask(AddTaskRequest request) async {
    try {
      final taskModel = await _datasource.addTask(request);
      return Right(taskModel.toEntity());
    } catch (e) {
      return Left(
        Failure(
          message:
              'TasksRepositoryImpl.addTask - Failed to add task: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks(
    GetTasksRequest request,
  ) async {
    try {
      final taskModels = await _datasource.getTasks(request);
      final taskEntities = taskModels.map((model) => model.toEntity()).toList();
      return Right(taskEntities);
    } catch (e) {
      return Left(
        Failure(
          message:
              'TasksRepositoryImpl.getTasks - Failed to get tasks: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> editTask(EditTaskRequest request) async {
    try {
      final taskModel = await _datasource.editTask(request);
      return Right(taskModel.toEntity());
    } catch (e) {
      return Left(
        Failure(
          message:
              'TasksRepositoryImpl.editTask - Failed to edit task: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getBacklogTasks(
    GetBacklogTasksRequest request,
  ) async {
    try {
      final taskModels = await _datasource.getBacklogTasks(request);
      final taskEntities = taskModels.map((model) => model.toEntity()).toList();
      return Right(taskEntities);
    } catch (e) {
      return Left(
        Failure(
          message:
              'TasksRepositoryImpl.getBacklogTasks - Failed to get backlog tasks: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> completeTask(
    CompleteTaskRequest request,
  ) async {
    try {
      final taskModel = await _datasource.completeTask(request);
      return Right(taskModel.toEntity());
    } catch (e) {
      return Left(
        Failure(
          message:
              'TasksRepositoryImpl.completeTask - Failed to complete task: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> deleteTask(
    DeleteTaskRequest request,
  ) async {
    try {
      final taskModel = await _datasource.deleteTask(request);
      return Right(taskModel.toEntity());
    } catch (e) {
      return Left(
        Failure(
          message:
              'TasksRepositoryImpl.deleteTask - Failed to delete task: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getOverdueTasks(
    GetOverdueTasksRequest request,
  ) async {
    try {
      final taskModels = await _datasource.getOverdueTasks(request);
      final taskEntities = taskModels.map((model) => model.toEntity()).toList();
      return Right(taskEntities);
    } catch (e) {
      return Left(
        Failure(
          message:
              'TasksRepositoryImpl.getOverdueTasks - Failed to get overdue tasks: ${e.toString()}',
        ),
      );
    }
  }
}
