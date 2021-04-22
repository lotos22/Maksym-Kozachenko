import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/interactor/login/sign_out.dart';
import 'package:toptal_test/domain/one_of.dart';

import '../mocks/utils.mocks.dart';



void main() {
  final repository = MockILoginRepository();
  late SignOut signOut;

  setUp(() {
    signOut = SignOut(repository);
    when(repository.signOut()).thenAnswer(
      (realInvocation) async => OneOf.success(null),
    );
  });

  group('SignIn tests', () {
    test('Should call signOut signOut', () async {
      await signOut.run(null);
      verify(repository.signOut()).called(1);
    });

    test('Should return result of signOut from ILoginRepository', () async {
      final response = await signOut.run(null);
      assert(response is Success);
    });
  });
}
