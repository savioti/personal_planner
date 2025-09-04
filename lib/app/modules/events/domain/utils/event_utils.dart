import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/shared/classes/range.dart';
import 'package:personal_planner/app/shared/extensions/date_time_extension.dart';

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

  static List<DateTime> getDaysOfTheWeek(DateTime date) {
    final startOfWeek = getStartOfWeek(date);
    return List.generate(
      7,
      (index) => startOfWeek.add(Duration(days: index)).toDateOnly,
    );
  }

  static DateTime getStartOfWeek(DateTime date) {
    final dayOfWeek = date.weekday;
    return date.subtract(Duration(days: dayOfWeek - 1));
  }

  static DateTime getEndOfWeek(DateTime date) {
    final dayOfWeek = date.weekday;
    return date.add(Duration(days: 7 - dayOfWeek));
  }

  static Range<DateTime> getWeekDateRange(DateTime date) {
    final startOfWeek = getStartOfWeek(date);
    final endOfWeek = getEndOfWeek(date);
    return Range(start: startOfWeek, end: endOfWeek);
  }
}
