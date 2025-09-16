import 'package:personal_planner/app/modules/tasks/data/models/task_model.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/add_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/complete_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_backlog_tasks_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_tasks_request.dart';

abstract class TasksDatasource {
  Future<TaskModel> addTask(AddTaskRequest request);

  Future<List<TaskModel>> getTasks(GetTasksRequest request);

  Future<List<TaskModel>> getBacklogTasks(GetBacklogTasksRequest request);

  Future<TaskModel> completeTask(CompleteTaskRequest request);
}
