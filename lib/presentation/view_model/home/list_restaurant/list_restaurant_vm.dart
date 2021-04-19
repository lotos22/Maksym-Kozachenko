import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/interactor/restaurant/get_restaurants.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/params.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/localizations.dart';

@injectable
class ListRestaurantsVM extends BaseVM {
  final GetRestaurants _getRestaurants;
  final String? _ownerId;

  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  ListRestaurantsVM(
    AppLocalizations appLocalizations,
    GetRestaurants getRestaurants,
    @factoryParam String? ownerId,
  )   : _ownerId = ownerId,
        _getRestaurants = getRestaurants,
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
    final params = GetRestaurantsParams(_ownerId);
    await _getRestaurants.execute(params, (oneOf) async {
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
