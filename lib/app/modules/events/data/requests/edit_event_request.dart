import 'package:personal_planner/app/shared/enums/recurrence_type.dart';
import 'package:personal_planner/app/shared/enums/weekday.dart';

class EditEventRequest {
  final String eventId;
  final String title;
  final DateTime startTime;
  final String? description;
  final RecurrenceType? recurrenceType;
  final Set<Weekday>? recurrenceWeekdays;
  final int? recurrenceInterval;

  EditEventRequest({
    required this.eventId,
    required this.title,
    required this.startTime,
    this.description,
    this.recurrenceType,
    this.recurrenceWeekdays,
    this.recurrenceInterval,
  });

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'title': title,
      'startTime': startTime.toIso8601String(),
      'description': description,
      'recurrence_type': recurrenceType?.toString() ?? 'none',
      'recurrence_weekdays': recurrenceWeekdays
          ?.map((day) => day.toString())
          .toList(),
      'recurrence_interval': recurrenceInterval,
    };
  }
}
