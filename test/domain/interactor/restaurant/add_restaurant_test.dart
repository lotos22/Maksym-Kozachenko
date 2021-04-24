import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/interactor/restaurant/add_restaurant.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import '../mocks/utils.mocks.dart';

void main() {
  final params = AddRestaurantParams('test', 'testID');
  final restaurant = Restaurant(
    id: 'testId',
    name: 'testName',
    ownerId: 'testOwnerId',
    avgRating: 2.2,
    numRatings: 2,
  );
  final repository = MockIRestaurantRepository();
  late AddRestaurant addRestaurant;

  setUp(() {
    addRestaurant = AddRestaurant(repository);
    when(repository.addRestaurant(params)).thenAnswer(
      (realInvocation) async => OneOf.success(restaurant),
    );
  });

  group('AddRestaurant tests', () {
    test('Should call addRestaurant ', () async {
      await addRestaurant.run(params);
      verify(repository.addRestaurant(params)).called(1);
    });

    test('Should return result of addRestaurant from IRestaurantRepository',
        () async {
      final response = await addRestaurant.run(params);
      assert(response == OneOf.success(restaurant));
    });
  });
}
