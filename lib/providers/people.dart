import 'package:bday/core/database.dart';
import 'package:bday/core/model/birthday.dart';
import 'package:bday/core/model/person.dart';
import 'package:flutter/foundation.dart';

import '../locator.dart';
import 'database_provider.dart';

class PeopleProvider with ChangeNotifier {
  List<Person> _people = [];
  List<Birthday> _birthdays = [];

  get people => _people;

  List<Birthday> get birthdays => _birthdays;

  DatabaseProvider databaseProvider = locator<DatabaseProvider>();

  Future<int> loadPeople() async {
    _people = await databaseProvider.dao.findAllPersons();
    return _people.length;
  }

  void addPerson(Person person) {
    _people.add(person);
    databaseProvider.dao.insertPerson(person);
  }

  void calculate() {
    _birthdays.clear();
    _people.forEach((person) {
      var b1 = person.nextDayEvent();
      if (b1 != null) _birthdays.add(b1);
      var b2 = person.nextMonthEvent();
      if (b2 != null) _birthdays.add(b2);
      var b3 = person.nextYearEvent();
      if (b3 != null) _birthdays.add(b3);
    });
    _birthdays.sort();
  }
}
