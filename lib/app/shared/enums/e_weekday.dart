enum EWeekday {
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
      case EWeekday.monday:
        return 'monday';
      case EWeekday.tuesday:
        return 'tuesday';
      case EWeekday.wednesday:
        return 'wednesday';
      case EWeekday.thursday:
        return 'thursday';
      case EWeekday.friday:
        return 'friday';
      case EWeekday.saturday:
        return 'saturday';
      case EWeekday.sunday:
        return 'sunday';
    }
  }
}
