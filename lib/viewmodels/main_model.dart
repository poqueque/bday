import 'package:bday/core/model/birthday.dart';
import 'package:bday/core/model/person.dart';
import 'package:bday/providers/people.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../locator.dart';
import 'base_model.dart';

class MainModel extends BaseModel {
  List<Birthday> get birthdays => peopleProvider.birthdays;

  PeopleProvider peopleProvider = locator<PeopleProvider>();
}
