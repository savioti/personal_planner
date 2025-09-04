import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';

class EventModel {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime? endTime;
  final String? description;

  EventModel({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    this.description,
  });

  @override
  String toString() {
    return 'EventModel(id: $id, title: $title, startTime: $startTime, endTime: $endTime, description: $description)';
  }

  EventEntity toEntity() {
    return EventEntity(
      id: id,
      title: title,
      startTime: startTime,
      endTime: endTime,
      description: description,
    );
  }

  static EventModel fromMap(Map<String, dynamic> map) {
    var endTime = map['end_time'];

    if (endTime != null) {
      endTime = endTime.toDate();
    }

    return EventModel(
      id: map['id'] as String,
      title: map['title'] as String,
      startTime: (map['start_time'] as Timestamp).toDate(),
      endTime: endTime,
      description: map['description'] as String?,
    );
  }
}
