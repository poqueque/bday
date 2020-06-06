import 'package:bday/core/model/person.dart';
import 'package:bday/providers/people.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../locator.dart';
import 'base_model.dart';

class PeopleModel extends BaseModel {

  List<Person> get people => peopleProvider.people;

  bool _clickedCentreFAB = false;

  bool get clickedCentreFAB => _clickedCentreFAB;

  set clickedCentreFAB(bool value) {
    _clickedCentreFAB = value;
    notifyListeners();
  }

  void addPerson(Person person) async {
    await peopleProvider.addPerson(person);
    peopleProvider.calculate();
    notifyListeners();
  }

  void updatePerson(Person person, String newName, DateTime newBirthday) async {
    person.name = newName;
    person.year = newBirthday.year;
    person.month = newBirthday.month;
    person.day = newBirthday.day;

    await peopleProvider.updatePerson(person);
    peopleProvider.calculate();
    notifyListeners();
  }

  bool personExists(String value) {
    return (people.firstWhere((person) => (person.name == value), orElse: () => null) != null);
  }

  PeopleProvider peopleProvider = locator<PeopleProvider>();

}
