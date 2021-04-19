import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_login_repository.dart';
import 'package:toptal_test/domain/use_case.dart';


@injectable
class SignOut extends UseCase<Null, Null> {
  final ILoginRepository _repository;
  SignOut(ILoginRepository repository) : _repository = repository;

  @override
  Future<OneOf<Failure, Null>> run(Null n) => _repository.signOut();
}
