import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/interactor/restaurant/get_restaurant_details.dart';
import 'package:toptal_test/domain/interactor/review/delete_review.dart';
import 'package:toptal_test/domain/interactor/review/get_restaurant_reviews.dart';
import 'package:toptal_test/domain/interactor/review/update_review.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/presentation/view_model/home/restaurant_details/restaurant_details_vm.dart';
import 'package:toptal_test/utils/localizations.dart';

@injectable
class RestaurantDetailsAdminVM extends RestaurantDetailsVM {
  final UpdateReview _updateReview;
  final DeleteReview _deleteReview;

  RestaurantDetailsAdminVM(
    @factoryParam Restaurant? rest,
    UpdateReview updateReview,
    DeleteReview deleteReview,
    AppUser appUser,
    GetRestaurantDetails getRestaurantDetails,
    GetRestaurantReviews getRestaurantReviews,
    AppLocalizations appLocalizations,
  )   : _updateReview = updateReview,
        _deleteReview = deleteReview,
        super(
          rest,
          appUser,
          getRestaurantDetails,
          getRestaurantReviews,
          appLocalizations,
        );

  void deleteReview(DeleteReviewParams params) {
    _deleteReview.execute(params, (oneOf) {
      if (oneOf.isSuccess) {
        pagingController.itemList?.removeWhere(
          (element) => element.id == params.reviewId,
        );
      } else {
        sendMessage(appLocalizations.something_went_wrong);
      }
      notifyListeners();
    });
  }

  void updateReview(UpdateReviewParams params) {
    _updateReview.execute(params, (oneOf) {
      if (oneOf.isSuccess) {
        final listReview = pagingController.itemList!.singleWhere(
          (element) => element.id == params.review.id,
        );
        final index = pagingController.itemList!.indexOf(listReview);
        pagingController.itemList?.removeAt(index);
        pagingController.itemList!.insert(index, params.review);
      } else {
        sendMessage(appLocalizations.something_went_wrong);
      }
      notifyListeners();
    });
  }
}
