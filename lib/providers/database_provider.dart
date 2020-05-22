import 'package:bday/core/database.dart';
import 'package:bday/core/model/person.dart';
import 'package:flutter/foundation.dart';

class DatabaseProvider with ChangeNotifier {
  var _dao;

  PersonDao get dao => _dao;
  bool initialized = false;

  init() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('bday_database.db').build();
    _dao = database.personDao;
    initialized = true;
  }
}
