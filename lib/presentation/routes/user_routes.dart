import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toptal_test/presentation/pages/home/list_restoraunts.dart';

class UserRoutePath {
  final String name;

  UserRoutePath(this.name);
  UserRoutePath.home() : name = '/home';
}

class UserRouteInformationParser extends RouteInformationParser<UserRoutePath> {
  @override
  Future<UserRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    return UserRoutePath.home();
  }
}

class UserRouteDelegate extends RouterDelegate<UserRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UserRoutePath> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Future<void> setInitialRoutePath(UserRoutePath configuration) {
    return super.setInitialRoutePath(UserRoutePath.home());
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: ListRestoraunts(),
        ),
      ],
      onPopPage: (route, result) {
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(UserRoutePath configuration) async {}
}
