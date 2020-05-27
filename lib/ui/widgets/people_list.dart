import 'package:bday/ui/widgets/MarkdownText.dart';
import 'package:bday/ui/widgets/people_item.dart';
import 'package:bday/viewmodels/people_model.dart';
import 'package:flutter/material.dart';

import 'Space.dart';

class PeopleList extends StatelessWidget {
  final PeopleModel model;

  PeopleList(this.model);

  @override
  Widget build(BuildContext context) {
    return (model.people.length == 0)
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "I just need to know the birthday dates of the people!",
                    textAlign: TextAlign.center,
                  ),
                  Space(),
                  MarkdownText("Click the *+ button* to add people",
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          )
        : ListView.builder(
            itemCount: model.people.length,
            itemBuilder: (BuildContext context, int index) {
              debugPrint("Print item: ${model.people[index].name}");
              return PeopleItem(model.people[index]);
            });
  }
}
