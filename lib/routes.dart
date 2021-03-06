import 'package:bday/ui/views/credits_view.dart';
import 'package:bday/ui/views/import_view.dart';
import 'package:flutter/material.dart';

import 'ui/views/add_people_view.dart';
import 'ui/views/main_view.dart';
import 'ui/views/people_view.dart';
import 'ui/views/splash_view.dart';

// Based on https://itnext.io/flutter-navigation-routing-made-easy-816ddf9e2857
class Routes {
  static const String Splash = '/splash';
  static const String Main = '/main';
  static const String People = '/people';
  static const String AddPeople = '/add_people';
  static const String Import = '/import';
  static const String Credits = '/credits';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.Splash: (context) => SplashView(),
      Routes.Main: (context) => MainView(),
      Routes.People: (context) => PeopleView(),
      Routes.AddPeople: (context) => AddPeopleView(),
      Routes.Import: (context) => ImportView(),
      Routes.Credits: (context) => CreditsView(),
    };
  }
}
