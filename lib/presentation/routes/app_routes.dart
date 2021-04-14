import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/presentation/pages/sign_in.dart';
import 'package:toptal_test/presentation/view_model/sign_in_vm.dart';

class RoutePath {
  final String name;

  RoutePath(this.name) : assert(name != null);

  RoutePath.splash() : name = SPLASH;
  RoutePath.signIn() : name = SIGN_IN;
  RoutePath.signUp() : name = SIGN_UP;

  static const SPLASH = '/';
  static const SIGN_IN = 'sign_in';
  static const SIGN_UP = 'sign_up';
}

class AppRouteInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/');
    if (uri.pathSegments.isEmpty) return RoutePath.splash();
    switch (uri.pathSegments.last) {
      case RoutePath.SIGN_IN:
        return RoutePath.signIn();
      case RoutePath.SIGN_UP:
        return RoutePath.signUp();
    }
    throw Exception();
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath configuration) {
    return RouteInformation(location: '/' + configuration.name);
  }
}

class AppRouteDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        CupertinoPage(
          name: RoutePath.SIGN_IN,
          child: ChangeNotifierProvider(
            create: (BuildContext context) => getIt<SignInVM>(),
            child: SignInPage(),
          ),
        ),
      ],
      onPopPage: (route, result) {
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {}
}
