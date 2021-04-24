import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/interactor/review/get_restaurant_reviews.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/const.dart';
import 'package:toptal_test/utils/localizations.dart';

@injectable
class RestaurantDetailsVM extends BaseVM {
  final Restaurant restaurant;
  final GetRestaurantReviews _getResaurantReviews;
  final bool isOwner;
  RestaurantDetailsVM(
    @factoryParam Restaurant? rest,
    AppUser appUser,
    GetRestaurantReviews getRestaurantReviews,
    AppLocalizations appLocalizations,
  )   : assert(rest != null),
        restaurant = rest!,
        isOwner = appUser.isOwner,
        _getResaurantReviews = getRestaurantReviews,
        super(appLocalizations) {
    loadReviews();
  }

  bool isUserLoading = false;
  PagingController<String?, Review> pagingController =
      PagingController(firstPageKey: null);

  Review? _bestReview;
  Review? get bestReview {
    if (_bestReview != null) return _bestReview;

    for (var r in pagingController.itemList ?? []) {
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
    for (var r in pagingController.itemList ?? []) {
      if (_worstReview == null || _worstReview!.rate > r.rate) {
        _worstReview = r;
      }
      if (r.rate == 1) break;
    }
    return _worstReview;
  }

  void loadReviews() {
    notifyListeners();
    _getResaurantReviews.execute(GetRestaurantReviewsParams(restaurant.id),
        (oneOf) {
      if (oneOf.isSuccess) {
        final data = (oneOf as Success).data as List<Review>;
        if (data.length == PageSize.pageSize) {
          pagingController.appendPage(data, data.last.id);
        } else {
          pagingController.appendLastPage(data);
        }
      } else {
        pagingController.appendLastPage([]);
        sendMessage(appLocalizations.something_went_wrong);
      }
      notifyListeners();
    });
  }

  void addPostedReview(Review value) {
    loadReviews();
  }

  
}
