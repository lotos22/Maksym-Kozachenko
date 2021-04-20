import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_user_repository.dart';

@Injectable(as: IUserRepository)
class FirebaseUserDoc extends IUserRepository {
  final USERS = 'users';
  final ROLE = 'roles';

  final USER_FIELD_EMAIL = 'email';
  final USER_FIELD_ROLE = 'role';

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  FirebaseUserDoc(
    FirebaseFirestore firestore,
    FirebaseAuth auth,
  )   : _firestore = firestore,
        _auth = auth;

  DocumentReference get userDoc =>
      _firestore.collection(USERS).doc(_auth.currentUser!.uid);

  @override
  Future<OneOf<Failure, AppUser>> getUser() async {
    try {
      var user = await userDoc.get();
      if (user.data() != null) {
        final appUser = AppUser.fromMap(_auth.currentUser!.uid, user.data()!);
        getIt.registerSingleton<AppUser>(appUser);
        return OneOf.success(appUser);
      } else {
        final appUser =
            AppUser(id: _auth.currentUser!.uid, userRole: UserRole.REGULAR);
        getIt.registerSingleton<AppUser>(appUser);
        return OneOf.success(appUser);
      }
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }

  @override
  Future<OneOf<Failure, List<AppUser>>> getUsers() async {
    try {
      final response = await _firestore.collection(USERS).get();
      final list = response.docs
          .map((e) =>
              AppUser(userRole: mapToUserRole(e.data()['role']), id: e.id))
          .toList();
      return OneOf.success(list);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }
}
