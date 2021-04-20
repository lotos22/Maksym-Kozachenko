import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/interactor/restaurant/add_restaurant.dart';
import 'package:toptal_test/domain/interactor/restaurant/delete_restaurant.dart';
import 'package:toptal_test/domain/interactor/restaurant/get_restaurants.dart';
import 'package:toptal_test/domain/interactor/restaurant/update_restaurant.dart';
import 'package:toptal_test/presentation/view_model/home/list_restaurant/list_restaurant_owner_vm.dart';
import 'package:toptal_test/utils/localizations.dart';
import 'package:toptal_test/domain/params.dart';

@injectable
class ListRestaurantAdminVM extends ListRestaurantOwnerVM {
  final UpdateRestaurant _updateRestaurant;
  final DeleteRestaurant _deleteRestaurant;

  ListRestaurantAdminVM(
    UpdateRestaurant updateRestaurant,
    DeleteRestaurant deleteRestaurant,
    AddRestaurant addRestaurant,
    AppLocalizations appLocalizations,
    GetRestaurants getRestaurants,
    @factoryParam String? ownerId,
  )   : _deleteRestaurant = deleteRestaurant,
        _updateRestaurant = updateRestaurant,
        super(addRestaurant, appLocalizations, getRestaurants, ownerId);

  void updateRestaurant(UpdateRestaurantParams params) {
    addRestaurantLoading = true;
    notifyListeners();
    _updateRestaurant.execute(params, (oneOf) {
      if (oneOf.isSuccess) {
        loadRestaurants();
      }
      addRestaurantLoading = false;
      notifyListeners();
    });
  }

    void deleteRestaurant(DeleteRestaurantParams params) {
    addRestaurantLoading = true;
    notifyListeners();
    _deleteRestaurant.execute(params, (oneOf) {
      if (oneOf.isSuccess) {
        loadRestaurants();
      }
      addRestaurantLoading = false;
      notifyListeners();
    });
  }
}
