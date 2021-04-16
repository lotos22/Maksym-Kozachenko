import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_user_repository.dart';
import 'package:toptal_test/model/roles.dart';

@Injectable(as: IUserRepository)
class FirebaseDatabase extends IUserRepository {
  final USERS_COLLECTION = 'users';
  final DOC_ROLES = 'roles';

  DocumentReference get rolesDoc =>
      getIt<FirebaseFirestore>().collection(USERS_COLLECTION).doc(DOC_ROLES);

  @override
  Future<OneOf<Failure, UserRole>> getRole() async {
    try {
      final userId = getIt<User>().uid;
      final role = await rolesDoc.get().then((value) => value.data()?[userId]);
      if (role == null) {
        await rolesDoc.update({userId: 1});
      }
      return OneOf.success(mapToUserRole(role));
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }
}
