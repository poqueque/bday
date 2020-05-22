import 'package:bday/core/model/birthday.dart';
import 'package:bday/core/model/person.dart';
import 'package:bday/providers/people.dart';

import '../locator.dart';
import 'base_model.dart';

class MainModel extends BaseModel {
  List<Birthday> get birthdays => peopleProvider.birthdays;
  bool _clickedCentreFAB = false;

  bool get clickedCentreFAB => _clickedCentreFAB;

  set clickedCentreFAB(bool value) {
    _clickedCentreFAB = value;
    notifyListeners();
  }

  void addPerson(Person person) {
    peopleProvider.addPerson(person);
    peopleProvider.calculate();
    notifyListeners();
  }

  PeopleProvider peopleProvider = locator<PeopleProvider>();
}
