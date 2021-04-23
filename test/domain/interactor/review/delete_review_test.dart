import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/interactor/review/delete_review.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import '../mocks/utils.mocks.dart';

void main() {
  final params = DeleteReviewParams(
    'restaurantId',
    'peviewId',
  );
  final repository = MockIReviewRepository();
  late DeleteReview deleteReview;

  setUp(() {
    deleteReview = DeleteReview(repository);
    when(repository.deleteReview(params)).thenAnswer(
      (realInvocation) async => OneOf.success(null),
    );
  });

  group('Delete restaurant review tests', () {
    test('Should call deleteReview ', () async {
      await deleteReview.run(params);
      verify(repository.deleteReview(params)).called(1);
    });

    test('Should return result of deleteReview from IReviewRepository',
        () async {
      final response = await deleteReview.run(params);
      assert(response == OneOf.success(null));
    });
  });
}
