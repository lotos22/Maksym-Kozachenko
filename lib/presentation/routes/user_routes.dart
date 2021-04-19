import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/presentation/pages/home/list_restaurants.dart';
import 'package:toptal_test/presentation/pages/home/restaurant_details.dart';
import 'package:toptal_test/presentation/view_model/home/list_restaurant_owner_vm.dart';
import 'package:toptal_test/presentation/view_model/home/list_restaurant_vm.dart';
import 'package:toptal_test/presentation/view_model/home/restaurant_details_vm.dart';

class UserRoutePath {
  final String name;

  UserRoutePath(this.name);
  UserRoutePath.home() : name = '/home';
}

class UserRouteInformationParser extends RouteInformationParser<UserRoutePath> {
  @override
  Future<UserRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    return UserRoutePath.home();
  }
}

class UserRouteDelegate extends RouterDelegate<UserRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UserRoutePath> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  var _pageIndex = 0;
  int get pageIndex => _pageIndex;
  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  Restaurant? _restaurant;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  bool get isHomePage => _restaurant == null;

  @override
  Future<void> setInitialRoutePath(UserRoutePath configuration) {
    return super.setInitialRoutePath(UserRoutePath.home());
  }

  @override
  Widget build(BuildContext context) {
    if (!getIt.isRegistered<AppUser>()) return Scaffold();

    final pages = getUserPages(getIt.get<AppUser>());

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        _restaurant = null;
        notifyListeners();
        return false;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(UserRoutePath configuration) async {}

  List<Page> getUserPages(AppUser user) {
    switch (user.userRole) {
      case UserRole.REGULAR:
        return getRegularUserPages();
      case UserRole.OWNER:
        return getOwnerUserPages(user);
      case UserRole.ADMIN:
        return getAdminUserPages();
    }
  }

  List<Page> getRegularUserPages() {
    return [
      MaterialPage(
        child: ChangeNotifierProvider(
          create: (buildContext) => getIt<ListRestaurantsVM>(),
          child: ListRestaurantsPage(),
        ),
      ),
      if (_restaurant != null)
        MaterialPage(
          name: _restaurant!.id,
          child: ChangeNotifierProvider(
            create: (context) =>
                getIt.get<RestaurantDetailsVM>(param1: _restaurant),
            child: RestaurantDetailsPage(),
          ),
        )
    ];
  }

  List<Page> getOwnerUserPages(AppUser user) {
    ListRestaurantsVM restaurantsVM =
        getIt<ListRestaurantOwnerVM>(param1: user.id);
    return [
      MaterialPage(
        child: ChangeNotifierProvider(
          create: (buildContext) => restaurantsVM,
          child: ListRestaurantsPage(),
        ),
      ),
      if (_restaurant != null)
        MaterialPage(
          name: _restaurant!.id,
          child: ChangeNotifierProvider(
            create: (context) =>
                getIt.get<RestaurantDetailsVM>(param1: _restaurant),
            child: RestaurantDetailsPage(),
          ),
        )
    ];
  }

  void setRestaurant(Restaurant restaurant) {
    _restaurant = restaurant;
    notifyListeners();
  }

  List<Page> getAdminUserPages() {
    return [];
  }
}