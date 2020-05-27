import 'package:bday/ui/widgets/MarkdownText.dart';
import 'package:bday/viewmodels/main_model.dart';
import 'package:flutter/material.dart';

import 'Space.dart';
import 'birthday_item.dart';

class BirthdayList extends StatelessWidget {
  final MainModel model;

  BirthdayList(this.model);

  @override
  Widget build(BuildContext context) {
    return (model.birthdays.length == 0)
        ? Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "I just need to know the birthday dates of the people!",
                  textAlign: TextAlign.center,
                ),
                Space(),
                MarkdownText("Select *People* menu and fill them"),
              ],
            ),
          )
        : ListView.builder(
            itemCount: model.birthdays.length,
            itemBuilder: (BuildContext context, int index) {
              debugPrint("Print item: ${model.birthdays[index].person.name}");
              return BirthdayItem(model.birthdays[index]);
            });
  }
}
