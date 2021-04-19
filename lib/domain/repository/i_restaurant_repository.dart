import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/interactor/restaurant/add_restaurant_review.dart';
import 'package:toptal_test/domain/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';

import '../one_of.dart';

abstract class IRestaurantRepository {
  Future<OneOf<Failure, List<Restaurant>>> getRestaurants(
      GetRestaurantsParams params);
  Future<OneOf<Failure, List<Review>>> getReviews(
      GetRestaurantReviewsParams params);
  Future<OneOf<Failure, Null>> addRestaurantReview(
      AddRestaurantReviewParams params);
  Future<OneOf<Failure, Null>> addRestaurant(AddRestaurantParams params);
}