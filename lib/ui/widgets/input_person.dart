import 'package:bday/core/model/person.dart';
import 'package:bday/extensions/extensions.dart';
import 'package:bday/viewmodels/main_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'animated_text_form_field.dart';

class InputPerson extends StatefulWidget {
  final MainModel model;

  const InputPerson({Key key, this.model}) : super(key: key);

  @override
  _InputPersonState createState() => _InputPersonState();
}

class _InputPersonState extends State<InputPerson> {
  DateTime selectedDate;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedTextFormField(
                labelText: "Name",
                successText: "Name Validated Successfully",
                validator: (value) {
                  if (value.length < 3) return "Enter at least 3 text";
                  return null;
                },
                inputIcon: Icon(Icons.person),
                controller: controller,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Center(
                child: Text(
                  selectedDate?.toDateString() ?? "Pick the Birthday Date",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              onTap: () async {
                selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateUtils.today(),
                    firstDate: DateTime(1900),
                    lastDate: DateUtils.today());
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text("Add"),
              onPressed: () {
                widget.model.addPerson(Person.withRandomId(controller.text, selectedDate));
                controller.text = "";
                selectedDate = null;
                widget.model.clickedCentreFAB = false;
              },
            ),
          ),
        ],
      ),
    );
  }
}
