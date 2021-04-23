import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/interactor/restaurant/update_restaurant.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import '../mocks/utils.mocks.dart';

void main() {
  final restaurant = Restaurant(
    id: 'testId',
    name: 'test',
    ownerId: 'testOwnerId',
    avgRating: '2.2',
    numRatings: 2,
  );
  final params = UpdateRestaurantParams(restaurant);
  final repository = MockIRestaurantRepository();
  late UpdateRestaurant updateRestaurant;

  setUp(() {
    updateRestaurant = UpdateRestaurant(repository);
    when(repository.updateRestaurant(params)).thenAnswer(
      (realInvocation) async => OneOf.success(null),
    );
  });

  group('Update tests', () {
    test('Should call updateRestaurant ', () async {
      await updateRestaurant.run(params);
      verify(repository.updateRestaurant(params)).called(1);
    });

    test('Should return result of updateRestaurant from IRestaurantRepository',
        () async {
      final response = await updateRestaurant.run(params);
      assert(response == OneOf.success(null));
    });
  });
}
