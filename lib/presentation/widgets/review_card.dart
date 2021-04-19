import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/presentation/widgets/rating_row_widget.dart';
import 'package:toptal_test/utils/localizations.dart';

class ReviewCardWidget extends StatelessWidget {
  final Review review;
  final EdgeInsets margin;
  final Function? onTap;
  ReviewCardWidget(this.review, {this.margin = const EdgeInsets.all(4),this.onTap});
  @override
  Widget build(BuildContext context) {
    return getReviewCell(context);
  }

  Widget getReviewCell(
    BuildContext context
  ) {
    final date = DateFormat('dd-MM-yyyy').format(review.dateVisited);

    return Card(
      margin: margin,
      child: ListTile(
        onTap: () => onTap?.call(),
        title: RatingRowWidget(
          rating: review.rate.toString(),
          text: date,
        ),
        subtitle: review.comment.isEmpty && review.reply.isEmpty
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
