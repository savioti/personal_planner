import 'package:personal_planner/app/modules/events/data/models/event_model.dart';
import 'package:personal_planner/app/shared/enums/recurrence_type.dart';
import 'package:personal_planner/app/shared/enums/weekday.dart';

class EventEntity {
  final String id;
  final String title;
  final DateTime startTime;
  final String? description;
  final RecurrenceType? recurrenceType;
  final Set<Weekday>? recurrenceWeekdays;
  final int? recurrenceInterval;

  EventEntity({
    required this.id,
    required this.title,
    required this.startTime,
    this.description,
    this.recurrenceType,
    this.recurrenceWeekdays,
    this.recurrenceInterval,
  });

  @override
  String toString() {
    return 'EventEntity(id: $id, title: $title, startTime: $startTime, description: $description, recurrenceType: $recurrenceType, recurrenceWeekdays: $recurrenceWeekdays, recurrenceInterval: $recurrenceInterval)';
  }

  factory EventEntity.fromModel(EventModel model) {
    return EventEntity(
      id: model.id,
      title: model.title,
      startTime: model.startTime,
      description: model.description,
      recurrenceType: model.recurrenceType != null
          ? RecurrenceType.fromString(model.recurrenceType!)
          : null,
      recurrenceWeekdays: model.recurrenceWeekdays
          ?.map((day) => Weekday.fromString(day))
          .toSet(),
      recurrenceInterval: model.recurrenceInterval,
    );
  }

  factory EventEntity.fromRecurringEvent({
    required EventEntity recurringEvent,
    required DateTime instanceDate,
  }) {
    return EventEntity(
      id: recurringEvent.id,
      title: recurringEvent.title,
      startTime: DateTime(
        instanceDate.year,
        instanceDate.month,
        instanceDate.day,
        recurringEvent.startTime.hour,
        recurringEvent.startTime.minute,
      ),
      description: recurringEvent.description,
      recurrenceType: recurringEvent.recurrenceType,
      recurrenceWeekdays: recurringEvent.recurrenceWeekdays,
      recurrenceInterval: recurringEvent.recurrenceInterval,
    );
  }
}
