import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/repository/failure.dart';

import '../one_of.dart';

abstract class IRestaurantRepository {
  Future<OneOf<Failure, List<Restaurant>>> getRestaurants();
}
