import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_login_repository.dart';
import 'package:toptal_test/domain/use_case.dart';

@injectable
class SignIn extends UseCase<Null, LoginSignInParams> {
  final ILoginRepository _loginRepository;
  SignIn(ILoginRepository loginRepository) : _loginRepository = loginRepository;

  @override
  Future<OneOf<Failure, Null>> run(LoginSignInParams params) =>
      _loginRepository.signIn(params);
}
