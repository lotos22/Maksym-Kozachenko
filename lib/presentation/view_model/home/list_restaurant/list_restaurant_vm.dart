import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/interactor/restaurant/get_restaurants.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/presentation/routes/user_routes.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/const.dart';
import 'package:toptal_test/utils/localizations.dart';

@injectable
class ListRestaurantsVM extends BaseVM {
  final GetRestaurants _getRestaurants;
  final String? ownerId;
  final FilterParams _filterParams;

  ListRestaurantsVM(
    AppLocalizations appLocalizations,
    GetRestaurants getRestaurants,
    AppUser appUser,
    @factoryParam String? idOwner,
    @factoryParam FilterParams? filterParams,
  )   : ownerId = idOwner,
        _filterParams = filterParams!,
        _getRestaurants = getRestaurants,
        super(appLocalizations) {
    _filterParams.onChangedListener = () {
      refreshController.requestRefresh();
    };
    pagingController.addPageRequestListener((pageKey) {
      loadRestaurants();
    });
  }

  RefreshController refreshController = RefreshController();
  PagingController<String?, Restaurant> pagingController =
      PagingController(firstPageKey: null);

  void loadRestaurants() async {
    final pageKey = pagingController.nextPageKey;
    final params = GetRestaurantsParams(
      ownerId,
      _filterParams.filterRating,
      lastDocId: pageKey,
      pageSize: PageSize.pageSize,
    );
    await _getRestaurants.execute(params, (oneOf) async {
      if (oneOf.isSuccess) {
        final data = (oneOf as Success).data as List<Restaurant>;
        if (data.length == PageSize.pageSize) {
          pagingController.appendPage(data, data.last.id);
        } else {
          pagingController.appendLastPage(data);
        }
      } else {
        pagingController.appendLastPage([]);
        sendMessage(appLocalizations.something_went_wrong);
      }
      refreshController.refreshCompleted();
      notifyListeners();
    });
  }
}
