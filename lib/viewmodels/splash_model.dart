import 'package:bday/providers/database_provider.dart';
import 'package:bday/providers/people.dart';

import '../locator.dart';
import 'base_model.dart';

class SplashModel extends BaseModel {
  PeopleProvider peopleProvider = locator<PeopleProvider>();
  DatabaseProvider databaseProvider = locator<DatabaseProvider>();

  Future<bool> workflow() async {
    status = "Initializing database...";

    await databaseProvider.init();
    int c = await peopleProvider.loadPeople();

    status = "Database initialized with $c people";

/*
    for (int i = 1; i <= 10; ++i) {
      peopleProvider.addPerson(Person.getRandom());
      status = "Reading $i people...";
    }
    peopleProvider.addPerson(Person.withRandomId("Edi",DateTime(1970,7,24)));
    peopleProvider.addPerson(Person.withRandomId("Mar",DateTime(1972,9,11)));
    peopleProvider.addPerson(Person.withRandomId("Nerea",DateTime(2012,8,22)));
*/
    await new Future.delayed(const Duration(milliseconds: 1000));
    peopleProvider.calculate();
    await new Future.delayed(const Duration(milliseconds: 1000));
    status = "Done.";
    return true;
  }
}
