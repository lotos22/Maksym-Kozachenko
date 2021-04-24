import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/interactor/review/add_restaurant_review.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import '../mocks/utils.mocks.dart';

void main() {
  final params = AddRestaurantReviewParams(
    'restId',
    5,
    DateTime.now(),
    'comment',
  );
  final review = Review(
    comment: 'comment',
    dateVisited: DateTime.now(),
    id: 'docId',
    rate: 5,
    reply: 'test',
  );
  final repository = MockIReviewRepository();
  late AddRestaurantReview addRestaurantReview;

  setUp(() {
    addRestaurantReview = AddRestaurantReview(repository);
    when(repository.addRestaurantReview(params)).thenAnswer(
      (realInvocation) async => OneOf.success(review),
    );
  });

  group('Add restaurant review tests', () {
    test('Should call addRestaurantReview ', () async {
      await addRestaurantReview.run(params);
      verify(repository.addRestaurantReview(params)).called(1);
    });

    test('Should return result of addRestaurantReview from IReviewRepository',
        () async {
      final response = await addRestaurantReview.run(params);
      assert(response == OneOf.success(review));
    });
  });
}
