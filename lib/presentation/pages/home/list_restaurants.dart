import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/presentation/view_model/home/list_restaurant_vm.dart';

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
              getRestaurantCell(vm.restaurants[index]),
          separatorBuilder: (context, index) => Divider(),
          itemCount: vm.restaurants.length,
        ),
      ),
    );
  }

  Widget getRestaurantCell(Restaurant restaurant) {
    return ListTile(
      title: Row(
        children: [
          Text(restaurant.avgRating),
          SizedBox(width: 8),
          Icon(Icons.star),
          SizedBox(width: 24),
          Flexible(
            child: Text(restaurant.name),
          ),
        ],
      ),
    );
  }
}
