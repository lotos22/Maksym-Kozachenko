import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/params.dart';
import 'package:toptal_test/domain/restaurant/get_restaurant_reviews.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/localizations.dart';

@injectable
class RestaurantDetailsVM extends BaseVM {
  final Restaurant restaurant;
  final GetRestaurantReviews _getResaurantReviews;
  RestaurantDetailsVM(
    @factoryParam Restaurant? rest,
    GetRestaurantReviews getRestaurantReviews,
    AppLocalizations appLocalizations,
  )   : assert(rest != null),
        restaurant = rest!,
        _getResaurantReviews = getRestaurantReviews,
        super(appLocalizations) {
    loadReviews();
  }

  List<Review> reviews = [];
  Review? get bestReview {
    Review? bestReview;
    for (var r in reviews) {
      if (bestReview == null || bestReview.rate < r.rate) {
        bestReview = r;
      }
      if (r.rate == 5) break;
    }
    return bestReview;
  }

  Review? get worstReview {
    Review? worstReview;
    for (var r in reviews) {
      if (worstReview == null || worstReview.rate < r.rate) {
        worstReview = r;
      }
      if (r.rate == 1) break;
    }
    return bestReview;
  }

  bool isLoadError = false;
  bool isLoading = false;


  void loadReviews() {
    isLoading = true;
    notifyListeners();
    _getResaurantReviews.execute(GetRestaurantReviewsParams(restaurant.id),
        (oneOf) {
      if (oneOf.isSuccess) {
        reviews = (oneOf as Success).data;
      }
      isLoadError = oneOf.isError;
      isLoading = false;
      notifyListeners();
    });
  }

}
