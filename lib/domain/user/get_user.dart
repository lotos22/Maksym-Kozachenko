import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_user_repository.dart';

import '../use_case.dart';

// @injectable
// class GetUser extends UseCase<AppUser, Null> {
//   final IUserRepository _userRepository;
//   GetUser(IUserRepository userRepository)
//       : _userRepository = userRepository;

//   @override
//   Future<OneOf<Failure, AppUser>> run(Null params) => _userRepository.getUser();
// }
