import 'package:bday/providers/database_provider.dart';
import 'package:bday/providers/people.dart';
import 'package:bday/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'locator.dart';
import 'ui/views/splash_view.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Steps to change the package name
  // https://medium.com/@skyblazar.cc/how-to-change-the-package-name-of-your-flutter-app-4529e6e6e6fc
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PeopleProvider>(create: (_) => PeopleProvider()),
        ChangeNotifierProvider<DatabaseProvider>(create: (_) => DatabaseProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter bday App',
        theme: ThemeData(
            primarySwatch: Colors.red,
            primaryTextTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).primaryTextTheme,
            ),
            textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme,
            )),
        routes: Routes.getRoutes(),
        home: SplashView(),
      ),
    );
  }
}
