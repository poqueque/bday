import 'package:bday/core/model/birthday.dart';
import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';

class BirthdayItem extends StatelessWidget {
  final Birthday birthday;

  BirthdayItem(this.birthday);

  @override
  Widget build(BuildContext context) {
    String typeStr = (birthday.type == BirthdayType.days)
        ? "dias"
        : (birthday.type == BirthdayType.months)
            ? "meses"
            : (birthday.type == BirthdayType.years) ? "años" : "";
    return Container(
        height: 120.0,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 124.0,
              margin: new EdgeInsets.only(left: 46.0),
              decoration: new BoxDecoration(
                color: new Color(0xFF333366),
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(8.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: new Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    birthday.person.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${birthday.count.toString()} $typeStr",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "(${birthday.person.day} / ${birthday.person.month} / ${birthday.person.year})",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${birthday.daysLeft.toWhenHumanReadable()}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              alignment: FractionalOffset.centerLeft,
              child: Image(
                image: (birthday.type == BirthdayType.days)
                    ? AssetImage("assets/images/earth.png")
                    : (birthday.type == BirthdayType.months)
                        ? AssetImage("assets/images/moon.png")
                        : AssetImage("assets/images/sun.png"),
                height: 92.0,
                width: 92.0,
              ),
            ),
          ],
        ));
  }
}
