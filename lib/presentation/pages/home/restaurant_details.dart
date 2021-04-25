import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/presentation/pages/home/dialogs/edit_review.dart';
import 'package:toptal_test/presentation/pages/home/dialogs/review_dialog.dart';
import 'package:toptal_test/presentation/view_model/home/restaurant_details/restaurant_details_admin_vm.dart';
import 'package:toptal_test/presentation/view_model/home/restaurant_details/restaurant_details_vm.dart';
import 'package:toptal_test/presentation/view_model/home/review_dialog_vm.dart';
import 'package:toptal_test/presentation/widgets/rating_row_widget.dart';
import 'package:toptal_test/presentation/widgets/review_card.dart';
import 'package:toptal_test/presentation/widgets/toast_widget.dart';
import 'package:toptal_test/utils/const.dart';
import 'package:toptal_test/utils/localizations.dart';

class RestaurantDetailsPage extends StatefulWidget {
  @override
  _RestaurantDetailsPageState createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RestaurantDetailsVM>(context);
    final restaurant = vm.restaurant;
    return ToastWidget(
      toast: vm.toast,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: ListTile(
                title: RatingRowWidget(
                  rating: NumberFormat('0.0').format(restaurant.avgRating),
                  text: restaurant.name,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: AnimatedOpacity(
                opacity: vm.restaurantDetails?.bestReview != null ? 1 : 0,
                duration: AnimationDuration.long(),
                child: AnimatedSize(
                  duration: AnimationDuration.normal(),
                  vsync: this,
                  child: vm.restaurantDetails?.bestReview != null
                      ? Column(
                          children: [
                            getTopReviewWidget(
                              vm,
                              context,
                              AppLocalizations.of(context)
                                  .restaurant_details_best_review,
                              vm.restaurantDetails!.bestReview!,
                            ),
                            getTopReviewWidget(
                              vm,
                              context,
                              AppLocalizations.of(context)
                                  .restaurant_details_worst_review,
                              vm.restaurantDetails!.worstReview!,
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
              ),
            ),
            if (vm.pagingController.itemList?.isNotEmpty ?? false)
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        AppLocalizations.of(context)
                            .restaurant_details_comments,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                ),
              ),
            PagedSliverList<String?, Review>(
              pagingController: vm.pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, item, index) => ReviewCardWidget(
                  item,
                  onLongTap: () {
                    onLongTapOnReview(vm, context, item);
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        ),
        floatingActionButton: !vm.isOwner
            ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) =>
                          getIt<ReviewDialogVM>(param1: vm.restaurant),
                      child: ReviewDialog(),
                    ),
                  ).then((value) {
                    if (value != null && value is Review) {
                      vm.addPostedReview(value);
                    }
                  });
                },
                child: Icon(Icons.add),
              )
            : null,
      ),
    );
  }

  Widget getTopReviewWidget(RestaurantDetailsVM vm, BuildContext context,
      String title, Review review) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headline6),
          SizedBox(
            height: 4,
          ),
          ReviewCardWidget(
            review,
            margin: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  void onLongTapOnReview(
    RestaurantDetailsVM vm,
    BuildContext context,
    Review review,
  ) {
    if (vm is RestaurantDetailsAdminVM) {
      showDialog(
        context: context,
        builder: (context) => EditReviewDialog(vm.restaurant, review),
      ).then((value) {
        if (value is DeleteReviewParams) {
          vm.deleteReview(value);
        }
        if (value is UpdateReviewParams) {
          vm.updateReview(value);
        }
      });
    }
  }
}
