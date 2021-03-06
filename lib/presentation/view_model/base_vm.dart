import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:toptal_test/utils/localizations.dart';

class BaseVM extends ChangeNotifier {
  final AppLocalizations _appLocalizations;

  BaseVM(@factoryParam AppLocalizations appLocalizations)
      : _appLocalizations = appLocalizations;

  AppLocalizations get appLocalizations => _appLocalizations;
  var _toast = '';

  void sendMessage(String s) => _toast = s;

  String get toast {
    var t = _toast;
    _toast = '';
    return t;
  }
}
