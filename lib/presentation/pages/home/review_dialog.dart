import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:toptal_test/presentation/view_model/home/review_dialog_vm.dart';
import 'package:toptal_test/presentation/widgets/animated_loading.dart';
import 'package:toptal_test/presentation/widgets/toast_widget.dart';
import 'package:toptal_test/utils/localizations.dart';

class ReviewDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ReviewDialogVM>(context);

    if (vm.addedReview != null) {
      Navigator.pop(context, vm.addedReview);
    }
    if (vm.isTimeOut) {
      ToastWidget.showToast(
          AppLocalizations.of(context).dialog_review_request_error);
      Navigator.pop(context, vm.addedReview);
    }

    return Dialog(
      child: ToastWidget(
        toast: vm.toast,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                maxRating: 5,
                minRating: 1,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                onRatingUpdate: (value) => vm.rating = value.toInt(),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: vm.dateVisited,
                          firstDate: DateTime(2010),
                          lastDate: DateTime.now(),
                        ).then((value) {
                          if (value != null) vm.dateVisited = value;
                        });
                      }),
                  SizedBox(
                    width: 8,
                  ),
                  Text(vm.dateVisitedFormatted)
                ],
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: vm.commentController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).dialog_review_comment,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Visibility(
                visible: vm.rating != 0,
                child: AnimatedLoading(
                  isLoading: vm.addReviewLoading,
                  child: ElevatedButton(
                    onPressed: () => vm.addReview(),
                    child: Text(
                        AppLocalizations.of(context).dialog_review_publish),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
