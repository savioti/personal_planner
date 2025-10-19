class TaskEntity {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final DateTime? deadline;

  TaskEntity({
    required this.id,
    required this.title,
    this.description = '',
    this.isDone = false,
    this.deadline,
  });
}
