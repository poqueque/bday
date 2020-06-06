import 'package:bday/core/model/birthday.dart';
import 'package:bday/core/model/person.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

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

  Future<void> addPerson(Person person) async {
    try {
      await databaseProvider.dao.insertPerson(person);
      _people.add(person);
    } on Exception catch (e){
      Get.snackbar("Error","Error adding person ${person.name}");
      debugPrint("Error inserting on DB: $person");
    }
  }

  Future<void> updatePerson(Person person) async {
    try {
      await databaseProvider.dao.updatePerson(person);
      _people.add(person);
    } on Exception catch (e){
      Get.snackbar("Error","Error adding person ${person.name}");
      debugPrint("Error inserting on DB: $person");
    }
  }

  void calculate() {
    _birthdays.clear();
    _people.forEach((person) {
      var b3 = person.nextYearEvent();
      if (b3 != null) _birthdays.add(b3);
      var b2 = person.nextMonthEvent();
      if (b2 != null && b2.daysLeft != b3.daysLeft && b2.daysLeft < 400)
        _birthdays.add(b2);
      var b1 = person.nextDayEvent();
      if (b1 != null && b1.daysLeft < 400) _birthdays.add(b1);
    });
    _birthdays.sort();
  }
}
