import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';

abstract class IUserRepository {
  // Future<OneOf<Failure, AppUser>> getUser();
  Future<OneOf<Failure, List<AppUser>>> getUsers();
  Future<OneOf<Failure, Null>> deleteUser(DeleteUserParams params);
  Future<OneOf<Failure, Null>> updateUser(UpdateUserParams params);
}
