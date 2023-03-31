
enum WeekDay {

  monday(1),
  tuesday(2),
  wednesday(3),
  thursday(4),
  friday(5),
  saturday(6),
  sunday(7);

  final int value;

  const WeekDay(this.value);

  factory WeekDay.fromValue(int weekday) {

    switch(weekday) {
      case 1: return WeekDay.monday;
      case 2: return WeekDay.tuesday;
      case 3: return WeekDay.wednesday;
      case 4: return WeekDay.thursday;
      case 5: return WeekDay.friday;
      case 6: return WeekDay.saturday;
      case 7: return WeekDay.sunday;
      default: return throw ArgumentError("The weekday value hasn't been recognized!");
    }

  }

  String getName() {

    switch(value) {
      case 1: return "Monday";
      case 2: return "Tuesday";
      case 3: return "Wednesday";
      case 4: return "Thursday";
      case 5: return "Friday";
      case 6: return "Saturday";
      case 7: return "Sunday";
      default: return "NOT_RECOGNIZED";
    }

  }

}

