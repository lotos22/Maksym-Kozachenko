import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';

abstract class ILoginRepository {
  Future<OneOf<Failure, Null>> signIn(LoginSignInParams params);
  Future<OneOf<Failure, Null>> signUp(LoginSignUpParams params);
  Future<OneOf<Failure, Null>> signOut();
}
