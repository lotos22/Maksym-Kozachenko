import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/interactor/restaurant/add_restaurant.dart';
import 'package:toptal_test/domain/interactor/restaurant/get_restaurants.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import '../mocks/utils.mocks.dart';

void main() {
  final params = GetRestaurantsParams(null, 0);
  final repository = MockIRestaurantRepository();
  late GetRestaurants getRestaurants;
  final restaurants = [
    Restaurant(
      id: 'testId',
      name: 'test',
      ownerId: 'testOwnerId',
      avgRating: '2.2',
      numRatings: 2,
    )
  ];

  setUp(() {
    getRestaurants = GetRestaurants(repository);
    when(repository.getRestaurants(params)).thenAnswer(
      (realInvocation) async => OneOf.success(restaurants),
    );
  });

  group('Get restaurants tests', () {
    test('Should call getRestaurants ', () async {
      await getRestaurants.run(params);
      verify(repository.getRestaurants(params)).called(1);
    });

    test('Should return result of getRestaurants from IRestaurantRepository',
        () async {
      final response = await getRestaurants.run(params);
      assert(response == OneOf.success(restaurants));
    });
  });
}
