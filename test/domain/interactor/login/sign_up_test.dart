import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/interactor/login/sign_up.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import '../mocks/utils.mocks.dart';

void main() {
  final params = LoginSignUpParams(
    'test@test.com',
    '111111',
    mapFromUserRole(UserRole.REGULAR),
  );
  final repository = MockILoginRepository();
  late SignUp signUp;

  setUp(() {
    signUp = SignUp(repository);
    when(repository.signUp(params)).thenAnswer(
      (realInvocation) async => OneOf.success(null),
    );
  });

  group('SignUp tests', () {
    test('Should call signUp signUp', () async {
      await signUp.run(params);
      verify(repository.signUp(params)).called(1);
    });

    test('Should return result of signUp from ILoginRepository', () async {
      final response = await signUp.run(params);
      assert(response == OneOf.success(null));
    });
  });
}
