enum RecurrenceType {
  none,
  daily,
  weekly,
  monthly,
  yearly,
  firstWeekdayOfTheMonth;

  factory RecurrenceType.fromString(String value) {
    switch (value) {
      case 'daily':
        return RecurrenceType.daily;
      case 'weekly':
        return RecurrenceType.weekly;
      case 'monthly':
        return RecurrenceType.monthly;
      case 'yearly':
        return RecurrenceType.yearly;
      case 'month_1st_weekday':
        return RecurrenceType.firstWeekdayOfTheMonth;
      default:
        return RecurrenceType.none;
    }
  }

  @override
  String toString() {
    switch (this) {
      case RecurrenceType.daily:
        return 'daily';
      case RecurrenceType.weekly:
        return 'weekly';
      case RecurrenceType.monthly:
        return 'monthly';
      case RecurrenceType.yearly:
        return 'yearly';
      case RecurrenceType.firstWeekdayOfTheMonth:
        return 'month_1st_weekday';
      case RecurrenceType.none:
        return 'none';
    }
  }
}
