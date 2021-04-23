import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/entities/pendingReply.dart';
import 'package:toptal_test/domain/entities/review.dart';

import 'package:toptal_test/domain/interactor/review/delete_review.dart';
import 'package:toptal_test/domain/interactor/review/get_pending_replies.dart';
import 'package:toptal_test/domain/interactor/review/get_restaurant_reviews.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import '../mocks/utils.mocks.dart';

void main() {
  final replies = [
    PendingReply(
      comment: 'comment',
      dateVisited: DateTime.now(),
      docId: 'docId',
      rate: 5,
      reply: 'test',
      restId: 'restID',
    ),
  ];
  final params = null;
  final repository = MockIReviewRepository();
  late GetPendingReplies getPendingReplies;

  setUp(() {
    getPendingReplies = GetPendingReplies(repository);
    when(repository.getPendingReplies()).thenAnswer(
      (realInvocation) async => OneOf.success(replies),
    );
  });

  group('Get pending replies tests', () {
    test('Should call getPendingReplies ', () async {
      await getPendingReplies.run(params);
      verify(repository.getPendingReplies()).called(1);
    });

    test('Should return result of getPendingReplies from IReviewRepository',
        () async {
      final response = await getPendingReplies.run(params);
      assert(response == OneOf.success(replies));
    });
  });
}
