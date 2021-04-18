import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/presentation/pages/home/review_dialog.dart';
import 'package:toptal_test/presentation/view_model/home/restaurant_details_vm.dart';
import 'package:toptal_test/presentation/view_model/home/review_dialog_vm.dart';
import 'package:toptal_test/presentation/widgets/rating_row_widget.dart';
import 'package:toptal_test/utils/localizations.dart';

class RestaurantDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RestaurantDetailsVM>(context);
    final restaurant = vm.restaurant;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: ListTile(
              title: RatingRowWidget(
                rating: restaurant.avgRating,
                text: restaurant.name,
              ),
            ),
          ),
          if (vm.bestReview != null)
            SliverToBoxAdapter(
              child: getTopReviewWidget(
                context,
                AppLocalizations.of(context).restaurant_details_best_review,
                vm.bestReview!,
              ),
            ),
          if (vm.worstReview != null)
            SliverToBoxAdapter(
              child: getTopReviewWidget(
                context,
                AppLocalizations.of(context).restaurant_details_worst_review,
                vm.worstReview!,
              ),
            ),
          if (vm.reviews.isNotEmpty)
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
                      AppLocalizations.of(context).restaurant_details_comments,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
            ),
          vm.isLoading
              ? SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()))
              : vm.isLoadError
                  ? ElevatedButton(
                      onPressed: () => vm.loadReviews(),
                      child: Text(AppLocalizations.of(context).home_root_retry))
                  : getReviewsWidget(context)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ChangeNotifierProvider(
              create: (context) => getIt<ReviewDialogVM>(param1: vm.restaurant),
              child: ReviewDialog(),
            ),
          ).then((value) {
            if (value != null && value is Review) {
              vm.addPostedReview(value);
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getReviewsWidget(BuildContext context) {
    final vm = Provider.of<RestaurantDetailsVM>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => getReviewCell(context, vm.reviews[index]),
        childCount: vm.reviews.length,
      ),
    );
  }

  Widget getTopReviewWidget(BuildContext context, String title, Review review) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headline6),
          SizedBox(
            height: 4,
          ),
          getReviewCell(context, review, margin: EdgeInsets.zero),
        ],
      ),
    );
  }

  Widget getReviewCell(
    BuildContext context,
    Review review, {
    EdgeInsets margin = const EdgeInsets.all(4),
  }) {
    final date = DateFormat('dd-MM-yyyy').format(review.dateVisited);

    return Card(
      margin: margin,
      child: ListTile(
        title: RatingRowWidget(
          rating: review.rate.toString(),
          text: date,
        ),
        subtitle: review.comment.isEmpty
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    AppLocalizations.of(context).restaurant_details_comment,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(review.comment),
                  if (review.reply.isNotEmpty)
                    SizedBox(
                      height: 8,
                    ),
                  if (review.reply.isNotEmpty)
                    Text(
                      AppLocalizations.of(context).restaurant_details_reply,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  if (review.reply.isNotEmpty) Text(review.reply),
                ],
              ),
      ),
    );
  }
}
