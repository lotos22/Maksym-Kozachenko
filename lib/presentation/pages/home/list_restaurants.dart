import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/presentation/routes/user_routes.dart';
import 'package:toptal_test/presentation/view_model/home/list_restaurant_vm.dart';
import 'package:toptal_test/presentation/widgets/rating_row_widget.dart';

class ListRestaurant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ListRestaurantsVM>(context);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      vm.initialLoading();
    });

    return Scaffold(
      body: SmartRefresher(
        onRefresh: () => vm.loadRestaurants(),
        controller: vm.refreshController,
        child: ListView.separated(
          itemBuilder: (context, index) =>
              getRestaurantCell(context, vm.restaurants[index]),
          separatorBuilder: (context, index) => Divider(),
          itemCount: vm.restaurants.length,
        ),
      ),
    );
  }

  Widget getRestaurantCell(BuildContext context, Restaurant restaurant) {
    return ListTile(
        onTap: () => Provider.of<UserRouteDelegate>(
              context,
              listen: false,
            ).setRestaurant(restaurant),
        title: RatingRowWidget(
          rating: restaurant.avgRating,
          text: restaurant.name,
        ));
  }
}
