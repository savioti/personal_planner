import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/shared/enums/recurrence_type.dart';
import 'package:personal_planner/app/shared/enums/weekday.dart';

class EventModel {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime? endTime;
  final String? description;
  final String? recurrenceType;
  final List<String>? recurrenceWeekdays;
  final int? recurrenceInterval;

  EventModel({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    this.description,
    this.recurrenceType,
    this.recurrenceWeekdays,
    this.recurrenceInterval,
  });

  @override
  String toString() {
    return 'EventModel(id: $id, title: $title, startTime: $startTime, endTime: $endTime, description: $description, recurrenceType: $recurrenceType, recurrenceWeekdays: $recurrenceWeekdays, recurrenceInterval: $recurrenceInterval)';
  }

  EventEntity toEntity() {
    return EventEntity(
      id: id,
      title: title,
      startTime: startTime,
      description: description,
      recurrenceType: recurrenceType != null
          ? RecurrenceType.fromString(recurrenceType!)
          : null,
      recurrenceWeekdays: recurrenceWeekdays
          ?.map((day) => Weekday.fromString(day))
          .toSet(),
      recurrenceInterval: recurrenceInterval,
    );
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    var endTime = map['end_time'];

    if (endTime != null) {
      endTime = endTime.toDate();
    }

    final startTime = (map['start_time'] as Timestamp).toDate();

    return EventModel(
      id: map['id'] as String,
      title: map['title'] as String,
      startTime: startTime,
      endTime: endTime,
      description: map['description'] as String?,
      recurrenceType: map['recurrence_type'] as String?,
      recurrenceWeekdays: map['recurrence_weekdays'] != null
          ? List<String>.from(map['recurrence_weekdays'] as List<dynamic>)
          : null,
      recurrenceInterval: map['recurrence_interval'] as int?,
    );
  }
}
