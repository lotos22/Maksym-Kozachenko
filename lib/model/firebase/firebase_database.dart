import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_user_repository.dart';

@Injectable(as: IUserRepository)
class FirebaseDatabase extends IUserRepository {
  final USERS = 'users';
  final ROLE = 'roles';

  final USER_FIELD_ROLE = 'role';

  DocumentReference get userDoc => getIt<FirebaseFirestore>()
      .collection(USERS)
      .doc(getIt<FirebaseAuth>().currentUser!.uid);

  @override
  Future<OneOf<Failure, AppUser>> getUser() async {
    try {
    
      var user = await userDoc.get();
      if (user.data() == null) {
        await userDoc.set({USER_FIELD_ROLE: 1});
      }
      if (user.data()?[USER_FIELD_ROLE] == null) {
        await userDoc.update({USER_FIELD_ROLE: 1});
      }
      user = await userDoc.get();
      final appUser = AppUser.fromMap(user.data()!);
      getIt.registerSingleton<AppUser>(appUser);
      return OneOf.success(appUser);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }
}
