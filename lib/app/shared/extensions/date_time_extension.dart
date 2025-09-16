import 'package:personal_planner/app/modules/translations/translations_catalog.dart';
import 'package:personal_planner/app/shared/classes/range.dart';

extension DateTimeExtension on DateTime {
  String get toEventTime {
    final baseDate =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

    if (year != DateTime.now().year) {
      return '$baseDate/$year';
    }

    return baseDate;
  }

  DateTime get toDateOnly {
    return DateTime(year, month, day);
  }

  DateTime get roundToNearestHalfHour {
    final int minutePart = minute;
    if (minutePart == 0 || minutePart == 30) {
      return this;
    } else if (minutePart < 30) {
      return DateTime(year, month, day, hour, 30);
    } else {
      return DateTime(year, month, day, hour + 1, 0);
    }
  }

  DateTime get roundToNearestQuarterHour {
    final int minutePart = minute;
    if (minutePart % 15 == 0) {
      return this;
    } else if (minutePart < 15) {
      return DateTime(year, month, day, hour, 15);
    } else if (minutePart < 30) {
      return DateTime(year, month, day, hour, 30);
    } else if (minutePart < 45) {
      return DateTime(year, month, day, hour, 45);
    } else {
      return DateTime(year, month, day, hour + 1, 0);
    }
  }

  List<DateTime> getDaysOfTheWeek() {
    final startOfWeek = getStartOfWeek();
    return List.generate(
      7,
      (index) => startOfWeek.add(Duration(days: index)).toDateOnly,
    );
  }

  DateTime getStartOfWeek() {
    final dayOfWeek = weekday;
    return subtract(Duration(days: dayOfWeek - 1));
  }

  DateTime getEndOfWeek() {
    final dayOfWeek = weekday;
    return add(Duration(days: 7 - dayOfWeek));
  }

  Range<DateTime> get getWeekDateRange {
    final startOfWeek = getStartOfWeek();
    final endOfWeek = getEndOfWeek();
    return Range(start: startOfWeek, end: endOfWeek);
  }

  /// shows only the hour and minute in the format HH:MM if the date is today,
  /// if the date is tomorrow, it shows "Tomorrow HH:MM",
  /// if the date is within the interval from today to sunday of the current week,
  /// it shows the weekday name
  /// if the date is beyond the current week, it shows the date in the format DD/MM or DD/MM/YYYY if it's in a different year
  String get toHumanReadableNextDate {
    final now = DateTime.now();
    final today = now.toDateOnly;
    final tomorrow = today.add(const Duration(days: 1));
    final thisWeekStart = today.getStartOfWeek();
    final thisWeekEnd = today.getEndOfWeek();

    final dateOnly = toDateOnly;

    if (dateOnly == today) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }

    if (dateOnly == tomorrow) {
      return '${RelativeDayTranslations.tomorrow}, ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }

    if (dateOnly.isAfter(thisWeekStart) &&
        dateOnly.isBefore(thisWeekEnd.add(const Duration(days: 1)))) {
      const weekdayNames = [
        WeekdayTranslations.monday,
        WeekdayTranslations.tuesday,
        WeekdayTranslations.wednesday,
        WeekdayTranslations.thursday,
        WeekdayTranslations.friday,
        WeekdayTranslations.saturday,
        WeekdayTranslations.sunday,
      ];
      return weekdayNames[dateOnly.weekday - 1];
    }

    if (year == now.year) {
      return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}';
    }

    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';
  }
}
