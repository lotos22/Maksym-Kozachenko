import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/presentation/pages/home/list_restoraunts.dart';
import 'package:toptal_test/presentation/view_model/home/list_restoraunts_vm.dart';
import 'package:toptal_test/utils/localizations.dart';

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
    final pages = getUserPages(getIt<AppUser>().userRole!);

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(UserRoutePath configuration) async {}

  List<Page> getUserPages(UserRole role) {
    switch (role) {
      case UserRole.REGULAR:
      case UserRole.OWNER:
      case UserRole.ADMIN:
        return getRegularUserPages();
    }
  }

  List<Page> getRegularUserPages() {
    return [
      MaterialPage(
        child: ChangeNotifierProvider(
          create: (buildContext) => getIt<ListRestorauntsVM>(),
          child: ListRestoraunts(),
        ),
      ),
    ];
  }
}
