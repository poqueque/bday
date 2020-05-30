import 'package:bday/core/model/birthday.dart';
import 'package:bday/providers/people.dart';

import '../locator.dart';
import 'base_model.dart';

class MainModel extends BaseModel {
  List<Birthday> get birthdays => peopleProvider.birthdays;

  PeopleProvider peopleProvider = locator<PeopleProvider>();
}
