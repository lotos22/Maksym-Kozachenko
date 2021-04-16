import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() {
  $initGetIt(getIt);
  getIt.registerFactory(() => FirebaseAuth.instance);
  getIt.registerFactory(() => FirebaseAuth.instance.currentUser!);
  getIt.registerFactory(() => FirebaseFirestore.instance);
}
