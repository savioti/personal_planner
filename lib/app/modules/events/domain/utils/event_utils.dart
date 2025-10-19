import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';

class EventUtils {
  static Map<DateTime, List<EventEntity>> groupEventsByDay(
    List<EventEntity> events,
  ) {
    final Map<DateTime, List<EventEntity>> groupedEvents = {};

    for (final event in events) {
      final day = DateTime(
        event.startTime.year,
        event.startTime.month,
        event.startTime.day,
      );
      groupedEvents.putIfAbsent(day, () => []);
      groupedEvents[day]!.add(event);
    }

    return groupedEvents;
  }
}
