import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_user_repository.dart';
import 'package:toptal_test/domain/use_case.dart';

@injectable
class DeleteUser extends UseCase<Null, DeleteUserParams> {
  final IUserRepository _userRepository;
  DeleteUser(IUserRepository userRepository) : _userRepository = userRepository;
  @override
  Future<OneOf<Failure, Null>> run(DeleteUserParams params) =>
      _userRepository.deleteUser(params);
}
