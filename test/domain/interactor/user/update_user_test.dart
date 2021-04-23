import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/interactor/user/delete_user.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import '../mocks/utils.mocks.dart';

void main() {
  
  final params = DeleteUserParams('test');
  final repository = MockIUserRepository();
  late DeleteUser deleteUser;

  setUp(() {
    deleteUser = DeleteUser(repository);
    when(repository.deleteUser(params)).thenAnswer(
      (realInvocation) async => OneOf.success(null),
    );
  });

  group('Delete users user tests', () {
    test('Should call deleteUser ', () async {
      await deleteUser.run(params);
      verify(repository.deleteUser(params)).called(1);
    });

    test('Should return result of deleteUser from IUserRepository', () async {
      final response = await deleteUser.run(params);
      assert(response == OneOf.success(null));
    });
  });
}
