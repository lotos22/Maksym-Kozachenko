import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/entities/user.dart';

import 'package:toptal_test/domain/interactor/user/get_users.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import '../mocks/utils.mocks.dart';

void main() {
  final users = [
    AppUser(
      id: 'test',
      userRole: UserRole.REGULAR,
    ),
  ];
  final params = GetUsersParams();
  final repository = MockIUserRepository();
  late GetUsers getUsers;

  setUp(() {
    getUsers = GetUsers(repository);
    when(repository.getUsers(params)).thenAnswer(
      (realInvocation) async => OneOf.success(users),
    );
  });

  group('Get users user tests', () {
    test('Should call getUsers ', () async {
      await getUsers.run(params);
      verify(repository.getUsers(params)).called(1);
    });

    test('Should return result of getUsers from IUserRepository', () async {
      final response = await getUsers.run(params);
      assert(response == OneOf.success(users));
    });
  });
}
