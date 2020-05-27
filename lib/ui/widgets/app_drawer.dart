import 'package:bday/ui/utils/app_icons.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';
import 'animated_logo.dart';
import 'oval_right_clipper.dart';

class AppDrawer extends StatelessWidget {
  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: active,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: AnimatedLogo(),
                  ),
                  SizedBox(height: 30.0),
                  DrawerRow(AppIcons.birthday, "Birthdays", Routes.Main),
                  Divider(color: divider),
                  DrawerRow(AppIcons.person, "People", Routes.People),
                  Divider(color: divider),
                  DrawerRow(AppIcons.message, "Messages", Routes.Main,
                      showBadge: true),
                  Divider(color: divider),
                  DrawerRow(
                      AppIcons.notifications, "Notifications", Routes.Main,
                      showBadge: true),
                  Divider(color: divider),
                  DrawerRow(AppIcons.settings, "Settings", Routes.Main),
                  Divider(color: divider),
                  DrawerRow(AppIcons.mail, "Contact us", Routes.Main),
                  Divider(color: divider),
                  DrawerRow(AppIcons.card, "Credits", Routes.Credits),
                  Divider(color: divider),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerRow extends StatelessWidget {
  final Image image;
  final String title;
  final String route;
  final bool showBadge;

  final Color active = Colors.grey.shade800;

  DrawerRow(this.image, this.title, this.route, {this.showBadge = false});

  @override
  Widget build(BuildContext context) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, route);
        },
        child: Row(children: [
          image,
          SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
          if (showBadge)
            Material(
              color: Colors.deepOrange,
              elevation: 5.0,
              shadowColor: Colors.red,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "10+",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  DrawerMenu(this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Align(
        alignment: FractionalOffset.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0, left: 16),
          child: Icon(
            Icons.menu,
            size: 32,
          ),
        ),
      ),
      onTap: () {
        scaffoldKey.currentState.openDrawer();
      },
    );
  }
}

