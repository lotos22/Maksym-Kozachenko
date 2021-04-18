import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/presentation/pages/login/sign_in.dart';
import 'package:toptal_test/presentation/pages/login/sign_up.dart';
import 'package:toptal_test/presentation/pages/home/user_home_router.dart';
import 'package:toptal_test/presentation/routes/user_routes.dart';
import 'package:toptal_test/presentation/view_model/home/user_home_router_vm.dart';
import 'package:toptal_test/presentation/view_model/login/sign_in_vm.dart';
import 'package:toptal_test/presentation/view_model/login/sign_up_vm.dart';
import 'package:toptal_test/utils/localizations.dart';

class RoutePath {
  final String name;

  RoutePath(this.name);

  RoutePath.splash() : name = SPLASH;
  RoutePath.signIn() : name = SIGN_IN;
  RoutePath.signUp() : name = SIGN_UP;

  static const SPLASH = '/';
  static const SIGN_IN = '/sign_in';
  static const SIGN_UP = '/sign_up';

  bool get isSignIn => SIGN_IN == name;
  bool get isSignUp => SIGN_UP == name;
}

@singleton
class LoginRouteInformationParser extends RouteInformationParser<RoutePath> {
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

@singleton
class LoginRouteDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  RoutePath get currentConfiguration =>
      _isSignUp ? RoutePath.signIn() : RoutePath.signUp();

  bool get _isUserLogged => getIt<FirebaseAuth>().currentUser != null;
  bool _isSignUp = true;

  LoginRouteDelegate() {
    getIt<FirebaseAuth>().authStateChanges().listen((event) {
      _isSignUp = false;
      notifyListeners();
    });
  }

  @override
  Future<void> setInitialRoutePath(RoutePath configuration) {
    return super.setInitialRoutePath(RoutePath.signIn());
  }

  @override
  Widget build(BuildContext context) {
    if (!getIt.isRegistered<AppLocalizations>()) {
      getIt.registerSingleton<AppLocalizations>(AppLocalizations.of(context));
    }
    List<Page<dynamic>> pages;
    if (_isUserLogged) {
      pages = [
        MaterialPage(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: UserRouteDelegate()),
              ChangeNotifierProvider(
                  create: (BuildContext context) => getIt<UserHomeRouterVM>())
            ],
            child: UserHomeRouterPage(),
          ),
        ),
      ];
    } else {
      pages = [
        MaterialPage(
          key: ValueKey(RoutePath.SIGN_IN),
          name: RoutePath.SIGN_IN,
          child: ChangeNotifierProvider(
            create: (BuildContext context) => getIt<SignInVM>(),
            child: SignInPage(),
          ),
        ),
        if (_isSignUp)
          MaterialPage(
            key: ValueKey(RoutePath.SIGN_UP),
            name: RoutePath.SIGN_UP,
            child: ChangeNotifierProvider(
              create: (BuildContext context) => getIt<SignUpVM>(),
              child: SignUpPage(),
            ),
          ),
      ];
    }

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        _isSignUp = false;
        notifyListeners();
        return false;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {
    _isSignUp = configuration.isSignUp;
    notifyListeners();
  }
}
