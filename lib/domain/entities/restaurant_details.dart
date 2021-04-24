import 'package:toptal_test/domain/entities/review.dart';

class RestaurantDetails {
  final Review? bestReview;
  final Review? worstReview;
  RestaurantDetails({
    this.bestReview,
    this.worstReview,
  });
}
