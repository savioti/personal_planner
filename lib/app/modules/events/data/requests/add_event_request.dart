import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_planner/app/shared/enums/recurrence_type.dart';
import 'package:personal_planner/app/shared/enums/weekday.dart';

class AddEventRequest {
  final String title;
  final DateTime startTime;
  final String? description;
  final RecurrenceType? recurrenceType;
  final Set<Weekday>? recurrenceWeekdays;
  final int? recurrenceInterval;

  AddEventRequest({
    required this.title,
    required this.startTime,
    this.description,
    this.recurrenceType,
    this.recurrenceWeekdays,
    this.recurrenceInterval,
  });

  toMap() {
    return {
      'title': title,
      'start_time': Timestamp.fromDate(startTime),
      'description': description,
      'recurrence_type': recurrenceType?.toString() ?? 'none',
      'recurrence_weekdays': recurrenceWeekdays
          ?.map((day) => day.toString())
          .toList(),
      'recurrence_interval': recurrenceInterval,
    };
  }
}
