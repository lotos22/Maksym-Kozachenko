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

  Review? _bestReview;
  Review? get bestReview {
    if (_bestReview != null) return _bestReview;

    for (var r in reviews) {
      if (_bestReview == null || _bestReview!.rate < r.rate) {
        _bestReview = r;
      }
      if (r.rate == 5) break;
    }
    return _bestReview;
  }

  Review? _worstReview;
  Review? get worstReview {
    if (_worstReview != null) return _worstReview;
    for (var r in reviews) {
      if (_worstReview == null || _worstReview!.rate > r.rate) {
        _worstReview = r;
      }
      if (r.rate == 1) break;
    }
    return _worstReview;
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

  void addPostedReview(Review value) {
    _worstReview = null;
    _bestReview = null;
    reviews.insert(0, value);
    notifyListeners();
  }
}
