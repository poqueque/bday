import 'package:bday/ui/widgets/input_person.dart';
import 'package:bday/viewmodels/people_model.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';

class AddPeopleView extends StatefulWidget {
  @override
  _AddPeopleViewState createState() => _AddPeopleViewState();
}

class _AddPeopleViewState extends State<AddPeopleView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<PeopleModel>(
        onModelReady: (model) {},
        builder: (BuildContext context, PeopleModel model, Widget child) {
          WidgetsBinding.instance.addPostFrameCallback((Duration d) {
            progressDialog.update(message: model.status);
          });
          return Scaffold(
            key: scaffoldKey,
            extendBody: true,
            backgroundColor: Colors.blue,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: "peopleHeroTag",
                  child: InputPerson(model: model),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
              child: Container(
                margin: EdgeInsets.all(15.0),
                child: Icon(Icons.close),
              ),
              elevation: 4.0,
            ),
          );
        });
  }
}
