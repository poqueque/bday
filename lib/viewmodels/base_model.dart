import 'package:flutter/foundation.dart';

enum ViewState { Idle, Busy }

//From: https://www.youtube.com/watch?v=kDEflMYTFlk&feature=youtu.be
class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  String _status = "";

  ViewState get state => _state;
  String get status => _status;

  set state(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  set status(String newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  delay(Duration duration) async {
    await Future.delayed(duration, () => {});
  }
}
