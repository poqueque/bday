import 'package:bday/viewmodels/main_model.dart';
import 'package:flutter/material.dart';

import 'birthday_item.dart';

class BirthdayList extends StatelessWidget {
  final MainModel model;

  BirthdayList(this.model);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: model.birthdays.length,
        itemBuilder: (BuildContext context, int index) {
        debugPrint("Print item: ${model.birthdays[index].person.name}");
          return BirthdayItem(model.birthdays[index]);
        });
  }
}