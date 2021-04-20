import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_user_repository.dart';
import 'package:toptal_test/domain/use_case.dart';

@injectable
class UpdateUser extends UseCase<Null, UpdateUserParams> {
  final IUserRepository _userRepository;
  UpdateUser(IUserRepository userRepository) : _userRepository = userRepository;
  @override
  Future<OneOf<Failure, Null>> run(UpdateUserParams params) =>
      _userRepository.updateUser(params);
}
