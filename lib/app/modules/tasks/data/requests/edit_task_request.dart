import 'package:cloud_firestore/cloud_firestore.dart';

class EditTaskRequest {
  final String taskId;
  final String title;
  final String? description;
  final DateTime? deadline;

  EditTaskRequest({
    required this.taskId,
    required this.title,
    this.description,
    this.deadline,
  });

  toMap() {
    return {
      'id': taskId,
      'title': title,
      'description': description,
      'deadline': deadline != null ? Timestamp.fromDate(deadline!) : null,
      'is_done': false,
    };
  }
}
