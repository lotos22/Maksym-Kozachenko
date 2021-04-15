import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/presentation/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  //TODO wrap with loading widget
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: getIt<AppRouteInformationParser>(),
      routerDelegate: getIt<AppRouteDelegate>(),
    );
  }
}
