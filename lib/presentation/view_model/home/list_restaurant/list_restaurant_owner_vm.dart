import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/interactor/restaurant/add_restaurant.dart';
import 'package:toptal_test/domain/interactor/restaurant/get_restaurants.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/presentation/routes/user_routes.dart';
import 'package:toptal_test/presentation/view_model/home/list_restaurant/list_restaurant_vm.dart';
import 'package:toptal_test/utils/localizations.dart';
import 'package:toptal_test/domain/repository/params.dart';

@injectable
class ListRestaurantOwnerVM extends ListRestaurantsVM {
  final AddRestaurant _addRestaurant;
  final AppUser _appUser;

  ListRestaurantOwnerVM(
    AddRestaurant addRestaurant,
    AppLocalizations appLocalizations,
    GetRestaurants getRestaurants,
    AppUser appUser,
    @factoryParam String? ownerId,
    @factoryParam FilterParams? filterParams,
  )   : _addRestaurant = addRestaurant,
        _appUser = appUser,
        super(
          appLocalizations,
          getRestaurants,
          appUser,
          ownerId,
          filterParams,
        );

  bool addRestaurantLoading = false;

  void addRestaurant(String name) {
    if (name.trim().isEmpty) return;
    addRestaurantLoading = true;
    notifyListeners();
    _addRestaurant.execute(
        AddRestaurantParams(
          name,
          _appUser.id,
        ), (oneOf) {
      if (oneOf.isError) {
        sendMessage(appLocalizations.something_went_wrong);
      }
      if (oneOf.isSuccess) {
        pagingController.itemList?.insert(0, (oneOf as Success).data);
      }
      addRestaurantLoading = false;
      notifyListeners();
    });
  }
}
