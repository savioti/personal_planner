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
}
