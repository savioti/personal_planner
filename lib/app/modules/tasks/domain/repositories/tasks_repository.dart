import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/add_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/complete_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/delete_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_backlog_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';
import 'package:personal_planner/app/shared/error/failure.dart';

abstract class TasksRepository {
  Future<Either<Failure, TaskEntity>> addTask(AddTaskRequest request);

  Future<Either<Failure, List<TaskEntity>>> getTasks(GetTasksRequest request);

  Future<Either<Failure, List<TaskEntity>>> getBacklogTasks(
    GetBacklogTasksRequest request,
  );

  Future<Either<Failure, TaskEntity>> completeTask(CompleteTaskRequest request);

  Future<Either<Failure, TaskEntity>> deleteTask(DeleteTaskRequest request);
}
