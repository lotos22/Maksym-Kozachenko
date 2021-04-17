import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/restaurant/get_restaurants.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/localizations.dart';
import 'package:toptal_test/utils/utils.dart';

@injectable
class ListRestaurantsVM extends BaseVM {
  final GetRestaurants _getRestaurants;

  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  ListRestaurantsVM(
    AppLocalizations appLocalizations,
    GetRestaurants getRestaurants,
  )   : _getRestaurants = getRestaurants,
        super(appLocalizations);

  RefreshController refreshController = RefreshController();

  bool isInitialLoad = false;
  void initialLoading() {
    if (!isInitialLoad) {
      isInitialLoad = true;
      loadRestaurants();
    }
  }

  void loadRestaurants() async {
    await refreshController.requestRefresh();
    await _getRestaurants.execute(null, (oneOf) async {
      if (oneOf.isSuccess) {
        _restaurants = (oneOf as Success).data;
      } else {
        _restaurants = [];
      }
      refreshController.refreshCompleted();
      notifyListeners();
    });
  }
}
