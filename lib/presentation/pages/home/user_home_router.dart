import 'package:flutter/material.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/presentation/routes/user_routes.dart';

class UserHomeRouter extends StatefulWidget {
  @override
  _UserHomeRouterState createState() => _UserHomeRouterState();
}

class _UserHomeRouterState extends State<UserHomeRouter> {
  ChildBackButtonDispatcher? _backButtonDispatcher;
  final UserRouteDelegate _userRouteDelegate = UserRouteDelegate();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher!
        .createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Router(
        routerDelegate: _userRouteDelegate,
        backButtonDispatcher: _backButtonDispatcher,
      ),
    );
  }
}
