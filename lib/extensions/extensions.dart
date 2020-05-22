import 'dart:core';

import 'package:bday/core/model/birthday.dart';
import 'package:bday/core/model/person.dart';
import 'package:intl/intl.dart';

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }
}

extension DateUtils on DateTime {

  static DateTime today() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static DateTime tomonth() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  int days() {
    return today().difference(this).inDays;
  }

  int months(DateTime other) {
    var m1 = this.year * 12 + this.month;
    var m2 = other.year * 12 + other.month;
    return m2 - m1;
  }

  String toDateString() {
    return DateFormat.yMMMd().format(this);
  }
}


extension DaysLeft on int {
  String toWhenHumanReadable() {
    var today = DateUtils.today();
    var day = today.add(Duration(days: this));
    var weekDay = DateFormat('EEEE').format(day);
    var longDate = DateFormat.yMMMMEEEEd().format(day);

    if (this == -1)
      return "Ayer";
    if (this == 0)
      return "Hoy";
    if (this == 1)
      return "Mañana";
    if (this == 2)
      return "Pasado Mañana";
    if (this < 8)
      return "El próximo $weekDay";
    return longDate;
  }
}
