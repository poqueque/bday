import 'package:bday/ui/widgets/Space.dart';
import 'package:bday/ui/widgets/animated_logo.dart';
import 'package:bday/viewmodels/splash_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes.dart';
import 'base_view.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void workflow(SplashModel model) async {
    bool logged = await model.workflow();
    if (logged) Navigator.pushReplacementNamed(context, Routes.Main);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashModel>(
      onModelReady: workflow,
      builder: (BuildContext context, SplashModel model, Widget child) =>
          Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedLogo(),
              Space(size: 32),
              Text(model.status, style: GoogleFonts.montserrat()),
            ],
          ),
        ),
      ),
    );
  }
}
