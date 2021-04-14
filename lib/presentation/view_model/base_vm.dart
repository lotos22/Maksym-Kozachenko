import 'package:flutter/material.dart';

class BaseVM extends ChangeNotifier {
  var _toast = '';

  void sendMessage(String s) => _toast = s;

  String get toast {
    var t = _toast;
    _toast = '';
    return t;
  }
}
