import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_login_repository.dart';
import 'package:toptal_test/domain/use_case.dart';

@injectable
class SignUp extends UseCase<Null, LoginSignUpParams> {
  final ILoginRepository _repository;
  SignUp(ILoginRepository repository) : _repository = repository;

  @override
  Future<OneOf<Failure, Null>> run(LoginSignUpParams params) =>
      _repository.signUp(params);
}