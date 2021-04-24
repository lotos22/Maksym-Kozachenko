import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/entities/review.dart';

import 'package:toptal_test/domain/interactor/review/update_review.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import '../mocks/utils.mocks.dart';

void main() {
  final params = UpdateReviewParams(
    'restaurantId',
    Review(
      comment: 'comment',
      dateVisited: DateTime.now(),
      id: 'docId',
      rate: 5,
      reply: 'test',
    ),
  );
  final repository = MockIReviewRepository();
  late UpdateReview updateReview;

  setUp(() {
    updateReview = UpdateReview(repository);
    when(repository.updateReview(params)).thenAnswer(
      (realInvocation) async => OneOf.success(null),
    );
  });

  group('Update restaurant review tests', () {
    test('Should call updateReview ', () async {
      await updateReview.run(params);
      verify(repository.updateReview(params)).called(1);
    });

    test('Should return result of updateReview from IReviewRepository',
        () async {
      final response = await updateReview.run(params);
      assert(response == OneOf.success(null));
    });
  });
}
