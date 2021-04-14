import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/presentation/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  //TODO wrap with loading widget
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _routeDelegate = AppRouteDelegate();
  final _routeInformationParser = AppRouteInformationParser();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _routeInformationParser,
      routerDelegate: _routeDelegate,
    );
  }
}
