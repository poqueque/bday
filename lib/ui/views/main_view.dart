import 'package:bday/ui/widgets/birthday_list.dart';
import 'package:bday/ui/widgets/input_person.dart';
import 'package:bday/viewmodels/main_model.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int selectedIndex = 0;
  String text = "Home";
  TextEditingController controller = TextEditingController();

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
      builder: (BuildContext context, MainModel model, Widget child) =>
          Scaffold(
        extendBody: true,
        body: Stack(
          children: <Widget>[
            BirthdayList(model),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                height: model.clickedCentreFAB
                    ? MediaQuery.of(context).size.height
                    : 10.0,
                width: model.clickedCentreFAB
                    ? MediaQuery.of(context).size.height
                    : 10.0,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(model.clickedCentreFAB ? 0.0 : 300.0),
                    color: Colors.blue),
                child: Align(
                  alignment: Alignment.center,
                  child: InputPerson(
                    model: model,
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              model.clickedCentreFAB = !model.clickedCentreFAB;
            });
          },
          tooltip: "Centre FAB",
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Icon(Icons.add),
          ),
          elevation: 4.0,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            margin: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  //update the bottom app bar view each time an item is clicked
                  onPressed: () {
                    updateTabSelection(0, "Home");
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.home,
                    //darken the icon if it is selected or else give it a different color
                    color: selectedIndex == 0
                        ? Colors.blue.shade900
                        : Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    updateTabSelection(1, "Outgoing");
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.call_made,
                    color: selectedIndex == 1
                        ? Colors.blue.shade900
                        : Colors.grey.shade400,
                  ),
                ),
                //to leave space in between the bottom app bar items and below the FAB
                SizedBox(
                  width: 50.0,
                ),
                IconButton(
                  onPressed: () {
                    updateTabSelection(2, "Incoming");
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.call_received,
                    color: selectedIndex == 2
                        ? Colors.blue.shade900
                        : Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    updateTabSelection(3, "Settings");
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.settings,
                    color: selectedIndex == 3
                        ? Colors.blue.shade900
                        : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          //to add a space between the FAB and BottomAppBar
          shape: CircularNotchedRectangle(),
          //color of the BottomAppBar
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
