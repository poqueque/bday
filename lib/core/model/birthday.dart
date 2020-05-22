import 'package:bday/core/model/person.dart';
import 'package:floor/floor.dart';

enum BirthdayType { days, months, years }

class Birthday implements Comparable {
  Birthday(this.person, this.type, this.count, this.daysLeft);

  Person person;
  BirthdayType type;
  int count;
  int daysLeft;

  @override
  int compareTo(other) {
    if (other is Birthday) {
      return this.daysLeft - other.daysLeft;
    }
    return 100000000;
  }
}