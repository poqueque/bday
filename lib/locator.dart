import 'package:bday/providers/database_provider.dart';
import 'package:bday/viewmodels/people_model.dart';
import 'package:get_it/get_it.dart';
import 'package:bday/providers/people.dart';
import 'package:bday/viewmodels/main_model.dart';

import 'core/services/api.dart';
import 'viewmodels/splash_model.dart';

GetIt locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton(() => SplashModel());
  locator.registerLazySingleton(() => MainModel());
  locator.registerLazySingleton(() => PeopleModel());

  locator.registerLazySingleton(() => PeopleProvider());

  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => DatabaseProvider());
}
