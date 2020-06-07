import 'package:flutter/material.dart';

class AppIcons {
  static double _iconSize = 24;
  static Image birthday = Image.asset("assets/images/cake.png",
      width: _iconSize, height: _iconSize);
  static Image person = Image.asset("assets/images/birthday_girl.png",
      width: _iconSize, height: _iconSize);
  static Image mail = Image.asset("assets/images/mail.png",
      width: _iconSize, height: _iconSize);
  static Image card = Image.asset("assets/images/card.png",
      width: _iconSize, height: _iconSize);
  static Image message = Image.asset("assets/images/mail.png",
      width: _iconSize, height: _iconSize);
  static Image import = Image.asset("assets/images/sparkler.png",
      width: _iconSize, height: _iconSize);
  static Image notifications = Image.asset("assets/images/party_horn.png",
      width: _iconSize, height: _iconSize);
  static Image settings = Image.asset("assets/images/disco_ball.png",
      width: _iconSize, height: _iconSize);

  static Image birthdayS(double size) =>
      Image.asset("assets/images/cake.png", width: size, height: size);

  static Image personS(double size) =>
      Image.asset("assets/images/birthday_girl.png", width: size, height: size);

  static Image mailS(double size) =>
      Image.asset("assets/images/mail.png", width: size, height: size);

  static Image cardS(double size) =>
      Image.asset("assets/images/card.png", width: size, height: size);

  static Image messageS(double size) =>
      Image.asset("assets/images/mail.png", width: size, height: size);

  static Image importS(double size) =>
      Image.asset("assets/images/sparkler.png", width: size, height: size);

  static Image notificationsS(double size) =>
      Image.asset("assets/images/party_horn.png", width: size, height: size);

  static Image settingsS(double size) =>
      Image.asset("assets/images/disco_ball.png", width: size, height: size);
}
