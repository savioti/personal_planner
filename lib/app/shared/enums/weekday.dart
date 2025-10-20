enum Weekday {
  monday(),
  tuesday(),
  wednesday(),
  thursday(),
  friday(),
  saturday(),
  sunday();

  @override
  String toString() {
    switch (this) {
      case Weekday.monday:
        return 'monday';
      case Weekday.tuesday:
        return 'tuesday';
      case Weekday.wednesday:
        return 'wednesday';
      case Weekday.thursday:
        return 'thursday';
      case Weekday.friday:
        return 'friday';
      case Weekday.saturday:
        return 'saturday';
      case Weekday.sunday:
        return 'sunday';
    }
  }
}
