import 'package:cloud_firestore/cloud_firestore.dart';

class AddEventRequest {
  final String title;
  final DateTime startTime;
  final DateTime? endTime;
  final String? description;

  AddEventRequest({
    required this.title,
    required this.startTime,
    this.endTime,
    this.description,
  });

  toMap() {
    return {
      'title': title,
      'start_time': Timestamp.fromDate(startTime),
      'end_time': endTime != null ? Timestamp.fromDate(endTime!) : null,
      'description': description,
    };
  }
}
