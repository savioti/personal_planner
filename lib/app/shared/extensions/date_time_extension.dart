// class for string extensions
extension DateTimeExtension on DateTime {
  String get toEventTime {
    final baseDate =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

    if (year != DateTime.now().year) {
      return '$baseDate/$year';
    }

    return baseDate;
  }
}
