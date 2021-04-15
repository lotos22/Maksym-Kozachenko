import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';

abstract class ILoginRepository {
  Future<OneOf<Failure, Null>> signIn(LoginSignInParams params);
}
