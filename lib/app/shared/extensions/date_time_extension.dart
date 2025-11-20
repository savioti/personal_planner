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
    final day = subtract(Duration(days: dayOfWeek - 1));
    return day.toDateOnly;
  }

  DateTime getEndOfWeek() {
    final dayOfWeek = weekday;
    final day = add(Duration(days: 7 - dayOfWeek));
    return day.dayEnd;
  }

  Range<DateTime> get getWeekDateRange {
    final startOfWeek = getStartOfWeek();
    final endOfWeek = getEndOfWeek();
    return Range(start: startOfWeek, end: endOfWeek);
  }

  Range<DateTime> get getNextWeekDateRange {
    final startOfNextWeek = getStartOfWeek().add(const Duration(days: 7));
    final endOfNextWeek = getEndOfWeek().add(const Duration(days: 7));
    return Range(start: startOfNextWeek, end: endOfNextWeek);
  }

  Range<DateTime> get getCurrentMonthDateRange {
    final startOfMonth = DateTime(year, month, 1);
    final endOfMonth = DateTime(year, month + 1, 0).dayEnd;
    return Range(start: startOfMonth, end: endOfMonth);
  }

  Range<DateTime> get getNextMonthDateRange {
    final startOfNextMonth = DateTime(year, month + 1, 1);
    final endOfNextMonth = DateTime(year, month + 2, 0).dayEnd;
    return Range(start: startOfNextMonth, end: endOfNextMonth);
  }

  Range<DateTime> get nextTrimesterDateRange {
    final nextTrimesterStartMonth = ((month - 1) ~/ 3 + 1) * 3 + 1;
    final nextTrimesterStartYear = nextTrimesterStartMonth > 12
        ? year + 1
        : year;
    final adjustedStartMonth = nextTrimesterStartMonth > 12
        ? nextTrimesterStartMonth - 12
        : nextTrimesterStartMonth;
    final nextTrimesterEndMonth = adjustedStartMonth + 2;
    final nextTrimesterEndYear = nextTrimesterEndMonth > 12
        ? nextTrimesterStartYear + 1
        : nextTrimesterStartYear;

    final startOfNextTrimester = DateTime(
      nextTrimesterStartYear,
      adjustedStartMonth,
      1,
    );
    final endOfNextTrimester = DateTime(
      nextTrimesterEndYear,
      nextTrimesterEndMonth + 1,
      0,
    ).dayEnd;

    return Range(start: startOfNextTrimester, end: endOfNextTrimester);
  }

  Range<DateTime> get getNextSemesterDateRange {
    final nextSemesterStartMonth = month <= 6 ? 7 : 1;
    final nextSemesterStartYear = month <= 6 ? year : year + 1;
    final nextSemesterEndMonth = nextSemesterStartMonth + 5;
    final nextSemesterEndYear = nextSemesterEndMonth > 12
        ? nextSemesterStartYear + 1
        : nextSemesterStartYear;

    final startOfNextSemester = DateTime(
      nextSemesterStartYear,
      nextSemesterStartMonth,
      1,
    );
    final endOfNextSemester = DateTime(
      nextSemesterEndYear,
      nextSemesterEndMonth + 1,
      0,
    ).dayEnd;

    return Range(start: startOfNextSemester, end: endOfNextSemester);
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

  // Examples: 09:00, 14:30, 13:03, 00:15
  String get toTime {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  // Examples: 01/09, 15/12, 23/06
  String get toMonthDay {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}';
  }

  DateTime get dayEnd {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  DateTime get monthStart {
    return DateTime(year, month, 1);
  }

  DateTime get monthEnd {
    final lastDayOfMonth = DateTime(year, month + 1, 0).day;
    return DateTime(year, month, lastDayOfMonth, 23, 59, 59, 999);
  }

  DateTime getfirstWeekdayOfMonth(int weekday) {
    DateTime date = DateTime(year, month, 1);

    while (date.weekday != weekday) {
      date = date.add(const Duration(days: 1));
    }

    return date;
  }

  bool isInTheSameWeekAs(DateTime other) {
    final thisWeekRange = getWeekDateRange;
    final otherWeekRange = other.getWeekDateRange;

    return thisWeekRange.start.toDateOnly == otherWeekRange.start.toDateOnly &&
        thisWeekRange.end.toDateOnly == otherWeekRange.end.toDateOnly;
  }

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}
