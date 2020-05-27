import 'dart:math';

import 'package:bday/core/services/random_people.dart';
import 'package:bday/extensions/extensions.dart';
import 'package:floor/floor.dart';

import 'birthday.dart';

@entity
class Person {
  static List<int> thresholds = [for (var i = 0; i < 10; i += 1) i * 10] +
      [for (var i = 1; i < 10; i += 1) i * 100] +
      [for (var i = 1; i < 10; i += 1) i * 1000] +
      [for (var i = 1; i < 10; i += 1) i * 10000] +
      [for (var i = 1; i < 10; i += 1) i * 10000];

  @primaryKey
  String name;
  String contactId;
  int year;
  int month;
  int day;

  DateTime get birthday => DateTime(year, month, day);

  Person(this.name, this.contactId, this.year, this.month, this.day);

  Person.fromBirthday(this.name, this.contactId, DateTime birthday){
    year = birthday.year;
    month = birthday.month;
    day = birthday.day;
  }

  Person.withRandomId(this.name, DateTime birthday) {
    year = birthday.year;
    month = birthday.month;
    day = birthday.day;
    contactId = Random().nextInt(100000000).toString();
  }

  static getRandom() => Person.fromBirthday("${RandomPeople.name()} ${RandomPeople.surname()}",
      Random().nextInt(100000000).toString(), RandomPeople.birthday());

  Birthday nextDayEvent() {
    var days = birthday.days();
    for (var value in thresholds) {
      if (value > days)
        return Birthday(this, BirthdayType.days, value, value - days);
    }
    return null;
  }

  Birthday nextMonthEvent() {
    var next = DateTime.now().year * 12 + DateTime.now().month - (this.birthday.year * 12 + this.birthday.month);
    if (this.birthday.day < DateTime.now().day) next ++;

    for (var value in thresholds) {
      if (value >= next) {
        var nextDate = DateTime(this.birthday.year+(value~/12), this.birthday.month+(value%12),this.birthday.day);
        var daysLeft = nextDate
            .difference(DateUtils
            .today())
            .inDays;
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
    return Birthday(this, BirthdayType.years, b.year - this.birthday.year, daysLeft);
  }

  @override
  String toString() {
    return "$name [$contactId] $day/$month/$year";
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
}
