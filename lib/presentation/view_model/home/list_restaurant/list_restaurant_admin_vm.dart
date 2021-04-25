import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/interactor/restaurant/add_restaurant.dart';
import 'package:toptal_test/domain/interactor/restaurant/delete_restaurant.dart';
import 'package:toptal_test/domain/interactor/restaurant/get_restaurants.dart';
import 'package:toptal_test/domain/interactor/restaurant/update_restaurant.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/presentation/routes/user_routes.dart';
import 'package:toptal_test/presentation/view_model/home/list_restaurant/list_restaurant_owner_vm.dart';
import 'package:toptal_test/utils/localizations.dart';
import 'package:toptal_test/domain/repository/params.dart';

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
    AppUser appUser,
    @factoryParam String? ownerId,
    @factoryParam FilterParams? filterParams,
  )   : _deleteRestaurant = deleteRestaurant,
        _updateRestaurant = updateRestaurant,
        super(
          addRestaurant,
          appLocalizations,
          getRestaurants,
          appUser,
          ownerId,
          filterParams,
        );

  void updateRestaurant(UpdateRestaurantParams params) {
    addRestaurantLoading = true;
    notifyListeners();
    _updateRestaurant.execute(params, (oneOf) {
      if (oneOf.isSuccess) {
        final listRestaurant = pagingController.itemList!.singleWhere(
          (element) => element.id == params.restaurant.id,
        );
        final index = pagingController.itemList!.indexOf(listRestaurant);
        pagingController.itemList?.removeAt(index);
        pagingController.itemList!.insert(index, params.restaurant);
      } else {
        if ((oneOf as Error).error is NotFoundFailure) {
          pagingController.itemList
              ?.removeWhere((element) => element.id == params.restaurant.id);
          sendMessage(appLocalizations.item_not_found);
        } else {
          sendMessage(appLocalizations.something_went_wrong);
        }
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
        pagingController.itemList?.removeWhere(
          (element) => element.id == params.id,
        );
      } else {
        sendMessage(appLocalizations.something_went_wrong);
      }
      addRestaurantLoading = false;
      notifyListeners();
    });
  }
}
