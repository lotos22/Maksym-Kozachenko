import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/interactor/restaurant/add_restaurant_review.dart';
import 'package:toptal_test/domain/params.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/localizations.dart';
import 'package:toptal_test/utils/utils.dart';

@injectable
class ReviewDialogVM extends BaseVM {
  final AddRestaurantReview _addRestaurantReview;
  final Restaurant _restaurant;
  ReviewDialogVM(
    @factoryParam Restaurant? restaurant,
    AddRestaurantReview addRestaurantReview,
    AppLocalizations appLocalizations,
  )   : _addRestaurantReview = addRestaurantReview,
        assert(restaurant != null),
        _restaurant = restaurant!,
        super(appLocalizations);

  var _rating = 0;
  set rating(int value) {
    _rating = value;
    notifyListeners();
  }

  int get rating => _rating;

  var _dateVisited = DateTime.now();
  DateTime get dateVisited => _dateVisited;
  set dateVisited(DateTime dateTime) {
    _dateVisited = dateTime;
    notifyListeners();
  }

  String get dateVisitedFormatted =>
      DateFormat('dd-MM-yyyy').format(_dateVisited);

  final commentController = TextEditingController();

  Review? addedReview;
  bool addReviewLoading = false;
  bool isTimeOut = false;

  void addReview() {
    addReviewLoading = true;
    notifyListeners();
    Future.delayed(Duration(seconds: 3)).then((value) {
      if (addReviewLoading) {
        isTimeOut = true;
        notifyListeners();
      }
    });
    final params = AddRestaurantReviewParams(
        _restaurant.id, rating, _dateVisited, commentController.text.trim());
    _addRestaurantReview.execute(params, (oneOf) {
      if (oneOf.isSuccess) {
        addedReview = Review(
            comment: params.comment,
            dateVisited: dateVisited,
            rate: rating,
            reply: '');
      } else {
        sendMessage(appLocalizations.something_went_wrong);
      }
      addReviewLoading = false;
      runCatching(() {
        notifyListeners();
      });
    });
  }
}
