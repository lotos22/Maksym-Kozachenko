import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/presentation/pages/home/dialogs/edit_restaurant_dialog.dart';
import 'package:toptal_test/presentation/pages/home/dialogs/enter_message_dialog.dart';
import 'package:toptal_test/presentation/routes/user_routes.dart';
import 'package:toptal_test/presentation/view_model/home/list_restaurant/list_restaurant_admin_vm.dart';
import 'package:toptal_test/presentation/view_model/home/list_restaurant/list_restaurant_owner_vm.dart';
import 'package:toptal_test/presentation/view_model/home/list_restaurant/list_restaurant_vm.dart';
import 'package:toptal_test/presentation/widgets/loading_modal.dart';
import 'package:toptal_test/presentation/widgets/rating_row_widget.dart';
import 'package:toptal_test/utils/localizations.dart';
import 'package:toptal_test/domain/repository/params.dart';

class ListRestaurantsPage extends StatefulWidget {
  @override
  _ListRestaurantsPageState createState() => _ListRestaurantsPageState();
}

class _ListRestaurantsPageState extends State<ListRestaurantsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final vm = Provider.of<ListRestaurantsVM>(context);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      vm.initialLoading();
    });

    return LoadingModalWidget(
      loading: () {
        if (vm is ListRestaurantOwnerVM) return vm.addRestaurantLoading;
        return false;
      }(),
      child: Scaffold(
        body: SmartRefresher(
          controller: vm.refreshController,
          onRefresh: () => vm.pagingController.refresh(),
          child: PagedListView<String?, Restaurant>.separated(
            pagingController: vm.pagingController,
            separatorBuilder: (context, index) => Divider(),
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (context, item, index) =>
                  getRestaurantCell(vm, context, item),
            ),
          ),
        ),
        floatingActionButton: vm is ListRestaurantOwnerVM
            ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EnterMessageDialog(
                        AppLocalizations.of(context)
                            .dialog_add_restaurant_name),
                  ).then((value) {
                    if (value != null && value is String) {
                      vm.addRestaurant(value);
                    }
                  });
                },
                child: Icon(Icons.add),
              )
            : null,
      ),
    );
  }

  Widget getRestaurantCell(
    ListRestaurantsVM vm,
    BuildContext context,
    Restaurant restaurant,
  ) {
    return ListTile(
        onLongPress: () {
          if (vm is ListRestaurantAdminVM) {
            showDialog(
              context: context,
              builder: (context) => EditRestaurantDialog(restaurant),
            ).then((value) {
              if (value is UpdateRestaurantParams) {
                vm.updateRestaurant(value);
              }
              if (value is DeleteRestaurantParams) {
                vm.deleteRestaurant(value);
              }
            });
          }
        },
        onTap: () => Provider.of<UserRouteDelegate>(
              context,
              listen: false,
            ).setRestaurant(restaurant),
        title: RatingRowWidget(
          rating: restaurant.avgRating,
          text: restaurant.name,
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
