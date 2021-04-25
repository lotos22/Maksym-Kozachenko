import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_user_repository.dart';

@Injectable(as: IUserRepository)
class FirebaseUserDoc implements IUserRepository {
  final USERS = 'users';
  final ROLE = 'roles';

  final USER_FIELD_EMAIL = 'email';
  final USER_FIELD_ROLE = 'role';

  final CALL_DELETE_USER = 'deleteUser';

  final FIELD_UID = 'uId';

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final FirebaseFunctions _functions;
  FirebaseUserDoc(
    FirebaseFirestore firestore,
    FirebaseAuth auth,
    FirebaseFunctions functions,
  )   : _firestore = firestore,
        _functions = functions,
        _auth = auth;

  DocumentReference get userDoc =>
      _firestore.collection(USERS).doc(_auth.currentUser!.uid);

  @override
  Future<OneOf<Failure, List<AppUser>>> getUsers(GetUsersParams params) async {
    try {
      QuerySnapshot response;

      if (params.lastDocId != null) {
        final snapshot =
            await _firestore.collection(USERS).doc(params.lastDocId).get();

        response = await _firestore
            .collection(USERS)
            .startAfterDocument(snapshot)
            .limit(params.pageSize)
            .get();
      } else {
        response =
            await _firestore.collection(USERS).limit(params.pageSize).get();
      }

      final list = response.docs
          .map((e) => AppUser(
                userRole: mapToUserRole(e.data()['role']),
                id: e.id,
                email: e.data()['email'],
              ))
          .toList();
      return OneOf.success(list);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }

  @override
  Future<OneOf<Failure, Null>> deleteUser(DeleteUserParams params) async {
    try {
      await _functions.httpsCallable(CALL_DELETE_USER).call({
        'uId': params.id,
      });
      return OneOf.success(null);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }

  @override
  Future<OneOf<Failure, Null>> updateUser(UpdateUserParams params) async {
    try {
      await _firestore
          .collection(USERS)
          .doc(params.id)
          .update({'role': params.role});

      return OneOf.success(null);
    } on FirebaseException catch (E) {
      E.stackTrace;
      return OneOf.error(Failure.notFoundFailure());
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }
}
