import 'package:bday/ui/widgets/app_drawer.dart';
import 'package:bday/ui/widgets/people_list.dart';
import 'package:bday/viewmodels/people_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_people_view.dart';
import 'base_view.dart';

class PeopleView extends StatefulWidget {
  @override
  _PeopleViewState createState() => _PeopleViewState();
}

class _PeopleViewState extends State<PeopleView> {
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
            appBar: AppBar(title: Text("People")),
            drawer: AppDrawer(),
            body: Stack(
              children: <Widget>[
                PeopleList(model),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.to(AddPeopleView());
              },
              child: Container(
                margin: EdgeInsets.all(15.0),
                child: Icon(Icons.add),
              ),
              elevation: 4.0,
              heroTag: "peopleHeroTag",
            ),
          );
        });
  }
}
