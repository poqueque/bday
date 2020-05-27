import 'package:bday/core/model/person.dart';
import 'package:bday/providers/people.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../locator.dart';
import 'base_model.dart';

class PeopleModel extends BaseModel {

  List<Person> get people => peopleProvider.people;

  bool _clickedCentreFAB = false;

  bool get clickedCentreFAB => _clickedCentreFAB;

  set clickedCentreFAB(bool value) {
    _clickedCentreFAB = value;
    notifyListeners();
  }

  void addPerson(Person person) {
    peopleProvider.addPerson(person);
    peopleProvider.calculate();
    notifyListeners();
  }

  Future<void> readContacts() async {
    state = ViewState.Busy;
    notifyListeners();
    status = "Reading contacts";
    //Ask for permissions
    var permissionStatus = await Permission.contacts.status;
    if (permissionStatus.isUndetermined) {
      // We didn't ask for permission yet.
    }

    if (await Permission.contacts.request().isGranted) {
      // Get all contacts on device
      Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
      contacts.forEach((contact) {
        if (contact.birthday != null) {
          Person person = Person.fromBirthday(
              contact.displayName, contact.identifier, contact.birthday);
          addPerson(person);
          debugPrint("Added contact: $person");
        }
      });
      await Future.delayed(Duration(seconds: 2));
      //Add Birthdays
      state = ViewState.Idle;
    } else {
      status = "You need to grant permissions to read contacts";
      await Future.delayed(Duration(seconds: 2));
    }
    notifyListeners();
  }

  PeopleProvider peopleProvider = locator<PeopleProvider>();
}
