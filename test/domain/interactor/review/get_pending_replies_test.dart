import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/entities/pendingReply.dart';

import 'package:toptal_test/domain/interactor/review/get_pending_replies.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import '../mocks/utils.mocks.dart';

void main() {
  final replies = [
    PendingReply(
      comment: 'comment',
      dateVisited: DateTime.now(),
      id: 'docId',
      rate: 5,
      reply: 'test',
      restId: 'restID',
    ),
  ];
  final params = GetPendingRepliesParams(page: 1, pageSize: 2);
  final repository = MockIReviewRepository();
  late GetPendingReplies getPendingReplies;

  setUp(() {
    getPendingReplies = GetPendingReplies(repository);
    when(repository.getPendingReplies(params)).thenAnswer(
      (realInvocation) async => OneOf.success(replies),
    );
  });

  group('Get pending replies tests', () {
    test('Should call getPendingReplies ', () async {
      await getPendingReplies.run(params);
      verify(repository.getPendingReplies(params)).called(1);
    });

    test('Should return result of getPendingReplies from IReviewRepository',
        () async {
      final response = await getPendingReplies.run(params);
      assert(response == OneOf.success(replies));
    });
  });
}
