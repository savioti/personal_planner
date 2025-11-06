enum Weekday {
  monday(),
  tuesday(),
  wednesday(),
  thursday(),
  friday(),
  saturday(),
  sunday();

  factory Weekday.fromString(String value) {
    switch (value.toLowerCase()) {
      case 'monday':
        return Weekday.monday;
      case 'tuesday':
        return Weekday.tuesday;
      case 'wednesday':
        return Weekday.wednesday;
      case 'thursday':
        return Weekday.thursday;
      case 'friday':
        return Weekday.friday;
      case 'saturday':
        return Weekday.saturday;
      case 'sunday':
        return Weekday.sunday;
      default:
        throw ArgumentError('Invalid weekday string: $value');
    }
  }

  factory Weekday.fromInt(int value) {
    switch (value) {
      case 1:
        return Weekday.monday;
      case 2:
        return Weekday.tuesday;
      case 3:
        return Weekday.wednesday;
      case 4:
        return Weekday.thursday;
      case 5:
        return Weekday.friday;
      case 6:
        return Weekday.saturday;
      case 7:
        return Weekday.sunday;
      default:
        throw ArgumentError('Invalid weekday integer: $value');
    }
  }

  int toInt() {
    switch (this) {
      case Weekday.monday:
        return 1;
      case Weekday.tuesday:
        return 2;
      case Weekday.wednesday:
        return 3;
      case Weekday.thursday:
        return 4;
      case Weekday.friday:
        return 5;
      case Weekday.saturday:
        return 6;
      case Weekday.sunday:
        return 7;
    }
  }

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
