import 'package:cloud_firestore/cloud_firestore.dart';

class AddTaskRequest {
  final String title;
  final String? description;
  final DateTime? deadline;

  AddTaskRequest({required this.title, this.description, this.deadline});

  toMap() {
    return {
      'title': title,
      'description': description,
      'deadline': deadline != null ? Timestamp.fromDate(deadline!) : null,
      'is_done': false,
    };
  }
}
