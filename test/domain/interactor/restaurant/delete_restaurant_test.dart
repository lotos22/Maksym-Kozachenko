import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toptal_test/domain/interactor/restaurant/delete_restaurant.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import '../mocks/utils.mocks.dart';

void main() {
  final params = DeleteRestaurantParams('test');
  final repository = MockIRestaurantRepository();
  late DeleteRestaurant deleteRestaurant;

  setUp(() {
    deleteRestaurant = DeleteRestaurant(repository);
    when(repository.deleteRestaurant(params)).thenAnswer(
      (realInvocation) async => OneOf.success(null),
    );
  });

  group('Delete restaurant tests', () {
    test('Should call deleteRestaurant ', () async {
      await deleteRestaurant.run(params);
      verify(repository.deleteRestaurant(params)).called(1);
    });

    test('Should return result of deleteRestaurant from IRestaurantRepository',
        () async {
      final response = await deleteRestaurant.run(params);
      assert(response == OneOf.success(null));
    });
  });
}
