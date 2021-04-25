import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_login_repository.dart';
import 'package:toptal_test/utils/utils.dart';

@Injectable(as: ILoginRepository)
class AppFirebaseAuth implements ILoginRepository {
  final COLLECTION_USERS = 'users';

  final FirebaseAuth _auth;

  AppFirebaseAuth(
    FirebaseAuth auth,
  ) : _auth = auth;

  @override
  Future<OneOf<Failure, Null>> signIn(LoginSignInParams params) async {
    OneOf<Failure, Null>? response;
    try {
      await _auth.signInWithEmailAndPassword(
        email: params.email,
        password: params.pass,
      );
      response = OneOf.success(null);
    } on PlatformException catch (e) {
      response = OneOf.error(Failure.signInFailure(e.code));
    } on FirebaseAuthException catch (e) {
      response = OneOf.error(Failure.signInFailure(e.code));
    }
    return response;
  }

  @override
  Future<OneOf<Failure, Null>> signUp(LoginSignUpParams params) async {
    OneOf<Failure, Null>? response;
    FirebaseApp? secondApp;
    try {
      try {
        await Firebase.initializeApp(
          name: 'secondary',
          options: Firebase.app().options,
        );
      } catch (e) {}
      secondApp = Firebase.app('secondary');
      final auth = FirebaseAuth.instanceFor(app: secondApp);
      final user = await auth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.pass,
      );

      await FirebaseFirestore.instanceFor(app: secondApp)
          .collection(COLLECTION_USERS)
          .doc(user.user!.uid)
          .set({
        'role': params.role,
        'email': params.email,
      });

      await auth.signOut();

      response = OneOf.success(null);
    } on PlatformException catch (e) {
      response = OneOf.error(Failure.signUpFailure(e.code));
    } on FirebaseAuthException catch (e) {
      response = OneOf.error(Failure.signUpFailure(e.code));
    } on Exception catch (e) {
      response = OneOf.error(Failure.unknownFailure(''));
    }

    return response;
  }

  @override
  Future<OneOf<Failure, Null>> signOut() async {
    try {
      await _auth.signOut();
      getIt.unregister<AppUser>();
      return OneOf.success(null);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }
}
