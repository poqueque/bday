import 'package:bday/ui/widgets/app_drawer.dart';
import 'package:bday/ui/widgets/birthday_list.dart';
import 'package:bday/viewmodels/main_model.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'base_view.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int selectedIndex = 0;
  String text = "Home";
  TextEditingController controller = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(context);
  }

  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MainModel>(
        onModelReady: (model) {},
        builder: (BuildContext context, MainModel model, Widget child) {
          return Scaffold(
            key: scaffoldKey,
            extendBody: true,
            appBar: AppBar(
              title: Text("BDay"),
            ),
            drawer: AppDrawer(),
            body: Stack(
              children: <Widget>[
                BirthdayList(model),
              ],
            ),
          );
        });
  }
}
