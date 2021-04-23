import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/interactor/review/add_reply.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import '../mocks/utils.mocks.dart';

void main() {
  final params = AddReplyParams(
    'reply',
    'restId',
    'docId',
  );
  final repository = MockIReviewRepository();
  late AddReply addReply;

  setUp(() {
    addReply = AddReply(repository);
    when(repository.addReply(params)).thenAnswer(
      (realInvocation) async => OneOf.success(null),
    );
  });

  group('Add restaurant review reply tests', () {
    test('Should call addReply ', () async {
      await addReply.run(params);
      verify(repository.addReply(params)).called(1);
    });

    test('Should return result of addReply from IReviewRepository', () async {
      final response = await addReply.run(params);
      assert(response == OneOf.success(null));
    });
  });
}
