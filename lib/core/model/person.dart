import 'dart:math';

import 'package:bday/core/services/random_people.dart';
import 'package:bday/extensions/extensions.dart';
import 'package:floor/floor.dart';

import 'birthday.dart';

@entity
class Person {
  static List<int> thresholds = [for (var i = 1; i < 10; i += 1) i] +
      [for (var i = 1; i < 10; i += 1) i * 10] +
      [for (var i = 1; i < 10; i += 1) i * 100] +
      [for (var i = 1; i < 10; i += 1) i * 1000] +
      [for (var i = 1; i < 10; i += 1) i * 10000] +
      [for (var i = 1; i < 10; i += 1) i * 10000];

  static const int MANUAL = 0;
  static const int CONTACTS = 1;
  static const int FACEBOOK = 2;

  @primaryKey
  String id;
  String name;
  int year;
  int month;
  int day;
  int origin;

  DateTime get birthday => DateTime(year, month, day);

  Person(this.name, this.id, this.year, this.month, this.day);

  Person.fromBirthday(this.name, this.id, DateTime birthday) {
    year = birthday.year;
    month = birthday.month;
    day = birthday.day;
  }

  Person.withRandomId(this.name, DateTime birthday) {
    year = birthday.year;
    month = birthday.month;
    day = birthday.day;
    origin = Person.MANUAL;
    id = Random().nextInt(100000000).toString();
  }

  static getRandom() => Person.fromBirthday(
      "${RandomPeople.name()} ${RandomPeople.surname()}",
      Random().nextInt(100000000).toString(),
      RandomPeople.birthday());

  Birthday nextDayEvent() {
    var days = birthday.days();
    for (var value in thresholds) {
      if (value >= days)
        return Birthday(this, BirthdayType.days, value, value - days);
    }
    return null;
  }

  Birthday nextMonthEvent() {
    var next = DateTime.now().year * 12 +
        DateTime.now().month -
        (this.birthday.year * 12 + this.birthday.month);
    if (this.birthday.day < DateTime.now().day) next++;

    for (var value in thresholds) {
      if (value >= next) {
        var nextDate = DateTime(this.birthday.year + (value ~/ 12),
            this.birthday.month + (value % 12), this.birthday.day);
        var daysLeft = nextDate.difference(DateUtils.today()).inDays;
        return Birthday(this, BirthdayType.months, value, daysLeft);
      }
    }
    return null;
  }

  Birthday nextYearEvent() {
    var b =
        DateTime(DateTime.now().year, this.birthday.month, this.birthday.day);
    if (b.isBefore(DateUtils.today()))
      b = DateTime(
          DateTime.now().year + 1, this.birthday.month, this.birthday.day);
    var daysLeft = b.difference(DateUtils.today()).inDays;
    return Birthday(
        this, BirthdayType.years, b.year - this.birthday.year, daysLeft);
  }

  @override
  String toString() {
    return "$name [$id] $day/$month/$year";
  }
}

@dao
abstract class PersonDao {
  @Query('SELECT * FROM Person')
  Future<List<Person>> findAllPersons();

  @Query('SELECT * FROM Person WHERE name = :name')
  Stream<Person> findPersonByName(int name);

  @insert
  Future<void> insertPerson(Person person);

  @update
  Future<void> updatePerson(Person person);
}
