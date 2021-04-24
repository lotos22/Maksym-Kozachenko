import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/entities/restaurant_details.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/interactor/restaurant/get_restaurant_details.dart';
import 'package:toptal_test/domain/interactor/review/get_restaurant_reviews.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/const.dart';
import 'package:toptal_test/utils/localizations.dart';

@injectable
class RestaurantDetailsVM extends BaseVM {
  final Restaurant restaurant;
  final GetRestaurantDetails _getRestaurantDetails;
  final GetRestaurantReviews _getResaurantReviews;
  final bool isOwner;
  RestaurantDetailsVM(
    @factoryParam Restaurant? rest,
    AppUser appUser,
    GetRestaurantDetails getRestaurantDetails,
    GetRestaurantReviews getRestaurantReviews,
    AppLocalizations appLocalizations,
  )   : assert(rest != null),
        restaurant = rest!,
        _getRestaurantDetails = getRestaurantDetails,
        isOwner = appUser.isOwner,
        _getResaurantReviews = getRestaurantReviews,
        super(appLocalizations) {
    loadRestaurantDetails();
    pagingController.addPageRequestListener((pageKey) {
      loadReviews();
    });
  }

  bool isUserLoading = false;
  PagingController<String?, Review> pagingController =
      PagingController(firstPageKey: null);

  RestaurantDetails? restaurantDetails;

  void loadReviews() {
    final params = GetRestaurantReviewsParams(
      restaurant.id,
      lastDocId: pagingController.nextPageKey,
      pageSize: PageSize.pageSize,
    );
    _getResaurantReviews.execute(params, (oneOf) {
      if (oneOf.isSuccess) {
        final data = (oneOf as Success).data as List<Review>;
        if (data.isNotEmpty && data.last.id != pagingController.nextPageKey) {
          if (data.length == PageSize.pageSize) {
            pagingController.appendPage(data, data.last.id);
          } else {
            pagingController.appendLastPage(data);
          }
        }
        if (data.isEmpty) {
          pagingController.appendLastPage([]);
        }
      } else {
        pagingController.appendLastPage([]);
        sendMessage(appLocalizations.something_went_wrong);
      }
      notifyListeners();
    });
  }

  void loadRestaurantDetails() {
    final params = GetRestaurantDetailsParams(restaurant.id);
    _getRestaurantDetails.execute(params, (oneOf) {
      if (oneOf.isSuccess) {
        final details = (oneOf as Success).data as RestaurantDetails;
        restaurantDetails = details;
      } else {
        sendMessage(appLocalizations.something_went_wrong);
      }
      notifyListeners();
    });
  }

  void addPostedReview(Review value) {
    pagingController.itemList?.insert(0,value);
    notifyListeners();
  }
}
