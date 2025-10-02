import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';

class TaskUtils {
  static Map<DateTime, List<TaskEntity>> groupTasksByDay(
    List<TaskEntity> tasks,
  ) {
    final Map<DateTime, List<TaskEntity>> groupedTasks = {};

    for (final task in tasks) {
      if (task.deadline == null) continue;

      final day = DateTime(
        task.deadline!.year,
        task.deadline!.month,
        task.deadline!.day,
      );
      groupedTasks.putIfAbsent(day, () => []);
      groupedTasks[day]!.add(task);
    }

    return groupedTasks;
  }
}
