import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_user_repository.dart';
import 'package:toptal_test/domain/use_case.dart';


@injectable
class GetUsers extends UseCase<List<AppUser>, Null> {
  final IUserRepository _userRepository;
  GetUsers(IUserRepository userRepository) : _userRepository = userRepository;

  @override
  Future<OneOf<Failure, List<AppUser>>> run(Null params) =>
      _userRepository.getUsers();
}
