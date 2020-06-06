import 'package:bday/core/model/person.dart';
import 'package:bday/extensions/extensions.dart';
import 'package:bday/viewmodels/people_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class InputPerson extends StatefulWidget {
  final PeopleModel model;
  final Person person;

  const InputPerson({Key key, this.model, this.person}) : super(key: key);

  @override
  _InputPersonState createState() => _InputPersonState();
}

class _InputPersonState extends State<InputPerson> {
  DateTime selectedDate;
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isValid = true;

  @override
  void initState() {
    super.initState();
    if (widget.person != null) {
      controller.text = widget.person.name;
      selectedDate = widget.person.birthday;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        onChanged: () {
          final isValid = _formKey.currentState.validate();
          if (_isValid != isValid) {
            setState(() {
              _isValid = isValid;
            });
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/birthday_girl.png",
                      width: 42, height: 42),
                ),
                Flexible(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 30),
                        validator: (value) {
                          value = value.trim();
                          if (value.length < 3) return "Enter at least 3 text";
                          if (value != widget.person.name &&
                              widget.model.personExists(value))
                            return "$value already exists";
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(fontSize: 30),
                        ),
                        controller: controller,
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/calendar.png",
                        width: 42, height: 42),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (selectedDate != null)
                        ? Row(
                            children: <Widget>[
                              Text(selectedDate.toDateString()),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ButtonTheme(
                                  height: 20.0,
                                  minWidth: 20.0,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    color: Colors.blue,
                                    child: Text("Change"),
                                    onPressed: _pickDate,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                side: BorderSide(color: Colors.blue)),
                            color: Colors.blue,
                            child: Text("Pick Birthday Date"),
                            onPressed: _pickDate,
                          ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                color: Colors.blue,
                child: (widget.person == null) ? Text("Add") : Text("Update"),
                onPressed: (selectedDate != null && _isValid)
                    ? () {
                        if (widget.person == null)
                          widget.model.addPerson(Person.withRandomId(
                              controller.text, selectedDate));
                        else
                          widget.model.updatePerson(
                              widget.person, controller.text, selectedDate);
                        controller.text = "";
                        selectedDate = null;
                        widget.model.clickedCentreFAB = false;
                        Get.back();
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _pickDate() async {
    FocusScope.of(context).requestFocus(FocusNode());
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateUtils.today(),
      firstDate: DateTime(1900),
      lastDate: DateUtils.today(),
    );
    setState(() {});
  }
}
