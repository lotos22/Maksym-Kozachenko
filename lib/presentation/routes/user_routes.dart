import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/presentation/pages/home/list_restaurants.dart';
import 'package:toptal_test/presentation/pages/home/pending_replies.dart';
import 'package:toptal_test/presentation/pages/home/restaurant_details.dart';
import 'package:toptal_test/presentation/pages/home/user_deleted.dart';
import 'package:toptal_test/presentation/pages/home/users.dart';
import 'package:toptal_test/presentation/view_model/home/list_restaurant/list_restaurant_admin_vm.dart';
import 'package:toptal_test/presentation/view_model/home/list_restaurant/list_restaurant_owner_vm.dart';
import 'package:toptal_test/presentation/view_model/home/list_restaurant/list_restaurant_vm.dart';
import 'package:toptal_test/presentation/view_model/home/pending_replies_vm.dart';
import 'package:toptal_test/presentation/view_model/home/restaurant_details/restaurant_details_admin_vm.dart';
import 'package:toptal_test/presentation/view_model/home/restaurant_details/restaurant_details_vm.dart';
import 'package:toptal_test/presentation/view_model/home/users_vm.dart';

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
  final listSubscriptions = <StreamSubscription>[];

  bool isUserPresent = false;
  UserRouteDelegate() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    listSubscriptions.add(FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .listen((event) {
      isUserPresent = event.exists && event.data() != null;
      if (getIt.isRegistered<AppUser>()) getIt.unregister<AppUser>();
      if (isUserPresent) {
        final user = AppUser.fromMap(uid, event.data()!);
        if (getIt.isRegistered<AppUser>()) getIt.unregister<AppUser>();
        getIt.registerSingleton<AppUser>(user);
      } else {
        _restaurant = null;
      }
      notifyListeners();
    }));
  }

  var _pageIndex = 0;
  int get pageIndex => _pageIndex;
  set pageIndex(int value) {
    _pageIndex = value;
    _restaurant = null;
    notifyListeners();
  }

  Restaurant? _restaurant;

  final filterParams = FilterParams();
  final filterRatings = [1, 2, 3, 4];

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  bool get isHomePage => _restaurant == null;

  @override
  Future<void> setInitialRoutePath(UserRoutePath configuration) {
    return super.setInitialRoutePath(UserRoutePath.home());
  }

  @override
  Widget build(BuildContext context) {
    if (!isUserPresent || !getIt.isRegistered<AppUser>()) {
      return UserDeletedPage();
    } else {
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
  }

  @override
  Future<void> setNewRoutePath(UserRoutePath configuration) async {}

  List<Page> getUserPages(AppUser user) {
    return [
      if (_pageIndex == 0)
        MaterialPage(
          key: ValueKey(user.userRole.toString()),
          child: ChangeNotifierProvider(
            create: (buidContext) {
              ListRestaurantsVM? vm;
              if (user.isRegular) {
                vm = getIt.get<ListRestaurantsVM>(param2: filterParams);
              }
              if (user.isOwner) {
                vm = getIt.get<ListRestaurantOwnerVM>(
                    param1: user.id, param2: filterParams);
              }
              if (user.isAdmin) {
                vm = getIt<ListRestaurantAdminVM>(param2: filterParams);
              }
              return vm!;
            },
            child: ListRestaurantsPage(),
          ),
        ),
      if (_restaurant != null)
        MaterialPage(
          name: _restaurant!.id,
          child: ChangeNotifierProvider(
            create: (context) {
              RestaurantDetailsVM? vm;
              if (user.isOwner || user.isRegular) {
                vm = getIt.get<RestaurantDetailsVM>(param1: _restaurant);
              }
              if (user.isAdmin) {
                vm = getIt.get<RestaurantDetailsAdminVM>(param1: _restaurant);
              }
              return vm!;
            },
            child: RestaurantDetailsPage(),
          ),
        ),
      if (pageIndex == 1)
        MaterialPage(
          child: ChangeNotifierProvider(
            create: (context) => getIt<PendingRepliesVM>(),
            child: PendingRepliesPage(),
          ),
        ),
      if (pageIndex == 2)
        MaterialPage(
          child: ChangeNotifierProvider(
            create: (context) => getIt<UsersVM>(),
            child: UsersPage(),
          ),
        ),
    ];
  }

  void setRestaurant(Restaurant restaurant) {
    _restaurant = restaurant;
    notifyListeners();
  }

  @override
  void dispose() {
    listSubscriptions.forEach((element) {
      element.cancel();
    });
    super.dispose();
  }

  void onFilterChanged() {
    if (filterRatings != filterParams.filterRatings) {
      filterParams.filterRatings = filterRatings;
      filterParams.onChanged();
    }
  }
}

class FilterParams {
  Function? onChangedListener;
  var filterRatings = <int>[1, 2, 3, 4];
  void onChanged() {
    onChangedListener?.call();
  }
}
