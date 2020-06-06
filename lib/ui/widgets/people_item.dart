import 'package:bday/core/model/person.dart';
import 'package:bday/ui/views/add_people_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PeopleItem extends StatelessWidget {
  final Person person;

  PeopleItem(this.person);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(AddPeopleView(person: person));
      },
      child: Container(
          height: 120.0,
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 124.0,
                margin: EdgeInsets.only(left: 46.0),
                decoration: BoxDecoration(
                  color: Color(0xFF333366),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      person.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "(${person.day} / ${person.month} / ${person.year})",
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
                  image: AssetImage("assets/images/birthday_girl.png"),
                  height: 92.0,
                  width: 92.0,
                ),
              ),
            ],
          )),
    );
  }
}
