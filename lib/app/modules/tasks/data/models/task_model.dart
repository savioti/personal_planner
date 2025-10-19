import 'package:personal_planner/app/modules/tasks/domain/entities/task_entity.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final DateTime? deadline;

  TaskModel({
    required this.id,
    required this.title,
    this.description = '',
    this.isDone = false,
    this.deadline,
  });

  @override
  String toString() {
    return 'TaskModel(id: $id, isDone: $isDone, title: $title, description: $description, deadline: $deadline)';
  }

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: title,
      description: description,
      isDone: isDone,
      deadline: deadline,
    );
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    var deadline = map['deadline'];

    if (deadline != null) {
      deadline = deadline.toDate();
    }

    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String? ?? '',
      isDone: map['is_done'] as bool? ?? false,
      deadline: deadline,
    );
  }
}
