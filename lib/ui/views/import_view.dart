import 'package:bday/ui/views/people_view.dart';
import 'package:bday/ui/widgets/Space.dart';
import 'package:bday/ui/widgets/app_drawer.dart';
import 'package:bday/viewmodels/import_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markup_text/markup_text.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../routes.dart';
import 'base_view.dart';

class ImportView extends StatefulWidget {
  @override
  _ImportViewState createState() => _ImportViewState();
}

class _ImportViewState extends State<ImportView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ImportModel>(
        onModelReady: (model) {},
        builder: (BuildContext context, ImportModel model, Widget child) {
          WidgetsBinding.instance.addPostFrameCallback((Duration d) {
            progressDialog.update(message: model.status);
          });
          return Scaffold(
            key: scaffoldKey,
            extendBody: true,
            appBar: AppBar(title: Text("Import")),
            drawer: AppDrawer(),
            body: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      MarkupText("You can easily import the Birthday dates from your"
                          " (b)contacts(/b) ((i)it will ask for permissions(/i)) and from"
                          " (b)Facebook(/b) ((i)you'll need to log into facebook and also"
                          " grant permissions for getting the Birthday dates(/i))."),
                      Space(),
                      RaisedButton(
                        child: Text("Import from contacts"),
                        onPressed: () async {
                          progressDialog.show();
                          await model.readContacts();
                          progressDialog.hide();
                          Get.off(PeopleView());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
