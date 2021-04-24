import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/entities/restaurant_details.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';

import '../one_of.dart';

abstract class IRestaurantRepository {
  Future<OneOf<Failure, List<Restaurant>>> getRestaurants(
    GetRestaurantsParams params,
  );
  Future<OneOf<Failure, Null>> addRestaurant(AddRestaurantParams params);
  Future<OneOf<Failure, Null>> updateRestaurant(UpdateRestaurantParams params);
  Future<OneOf<Failure, Null>> deleteRestaurant(DeleteRestaurantParams params);
  Future<OneOf<Failure, RestaurantDetails>> getRestaurantDetails(
    GetRestaurantDetailsParams params,
  );
}
