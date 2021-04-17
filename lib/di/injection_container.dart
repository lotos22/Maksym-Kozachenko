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
  getIt.registerFactory(() => FirebaseAuth.instance);
  getIt.registerFactory(() => FirebaseAuth.instance.currentUser!);
  getIt.registerFactory(() => FirebaseFirestore.instance);
  $initGetIt(getIt);
}

extension DiUtils on GetIt {
  T? getSafe<T extends Object>() {
    try {
      return getIt<T>();
    } catch (E) {
      return null;
    }
  }
}
