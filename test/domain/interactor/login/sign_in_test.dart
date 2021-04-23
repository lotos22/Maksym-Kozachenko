import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/interactor/login/sign_in.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import '../mocks/utils.mocks.dart';

void main() {
  final params = LoginSignInParams('test@test.com', '111111');
  final repository = MockILoginRepository();
  late SignIn signIn;

  setUp(() {
    signIn = SignIn(repository);
    when(repository.signIn(params)).thenAnswer(
      (realInvocation) async => OneOf.success(null),
    );
  });

  group('SignIn tests', () {
    test('Should call signIn signIn', () async {
      await signIn.run(params);
      verify(repository.signIn(params)).called(1);
    });

    test('Should return result of signIn from ILoginRepository', () async {
      final response = await signIn.run(params);
      assert(response == OneOf.success(null));
    });
  });
}
