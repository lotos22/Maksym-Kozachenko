import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/model/roles.dart';

abstract class IUserRepository {
  Future<OneOf<Failure, UserRole>> getRole();
}
