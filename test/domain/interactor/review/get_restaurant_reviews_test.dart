import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/entities/review.dart';

import 'package:toptal_test/domain/interactor/review/get_restaurant_reviews.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import '../mocks/utils.mocks.dart';

void main() {
  final reviews = [
    Review(
      comment: 'comment',
      dateVisited: DateTime.now(),
      docId: 'docId',
      rate: 5,
      reply: 'test',
    ),
  ];
  final params = GetRestaurantReviewsParams(
    'restaurantId',
  );
  final repository = MockIReviewRepository();
  late GetRestaurantReviews getRestaurantReviews;

  setUp(() {
    getRestaurantReviews = GetRestaurantReviews(repository);
    when(repository.getReviews(params)).thenAnswer(
      (realInvocation) async => OneOf.success(reviews),
    );
  });

  group('Get restaurant reviews tests', () {
    test('Should call getRestaurantReviews ', () async {
      await getRestaurantReviews.run(params);
      verify(repository.getReviews(params)).called(1);
    });

    test('Should return result of getRestaurantReviews from IReviewRepository',
        () async {
      final response = await getRestaurantReviews.run(params);
      assert(response == OneOf.success(reviews));
    });
  });
}
