import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/params.dart';

class EditReviewDialog extends StatefulWidget {
  final Restaurant restaurant;
  final Review review;
  EditReviewDialog(
    this.restaurant,
    this.review,
  );

  @override
  _EditReviewDialogState createState() => _EditReviewDialogState();
}

class _EditReviewDialogState extends State<EditReviewDialog> {
  final formKey = GlobalKey<FormState>();

  late final commentController =
      TextEditingController(text: widget.review.comment);
  late DateTime dateVisited = widget.review.dateVisited;
  late final rateController =
      TextEditingController(text: widget.review.rate.toString());
  late final replyController = TextEditingController(text: widget.review.reply);
  late bool replied = widget.review.replied;

  InputDecoration getInputDecoration(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      );

  bool get isChanged =>
      commentController.text != widget.review.comment ||
      dateVisited != widget.review.dateVisited ||
      rateController.text != widget.review.rate.toString() ||
      replyController.text != widget.review.reply ||
      replied != widget.review.replied;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: commentController,
                  decoration: getInputDecoration('Comment'),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: dateVisited,
                          firstDate: DateTime(2010),
                          lastDate: DateTime.now(),
                        ).then((value) {
                          setState(() {
                            if (value != null) dateVisited = value;
                          });
                        });
                      },
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(DateFormat('dd-MM-yyyy').format(dateVisited)),
                  ],
                ),
                SizedBox(
                  width: 8,
                ),
                TextFormField(
                  controller: rateController,
                  decoration: getInputDecoration('Rating'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || int.tryParse(value) == null) {
                      return 'Value required';
                    }
                    if (int.parse(value) < 1 || int.parse(value) > 5) {
                      return 'Value must be in range 1..5';
                    }
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: replyController,
                  decoration: getInputDecoration('Reply'),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Text('Replied'),
                    Checkbox(
                      value: replied,
                      onChanged: (value) => setState(() {
                        replied = value ?? widget.review.replied;
                      }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      if (isChanged) {
                        Navigator.pop(
                          context,
                          UpdateReviewParams(
                            widget.restaurant.id,
                            Review(
                              comment: commentController.text,
                              dateVisited: dateVisited,
                              docId: widget.review.docId,
                              rate: int.parse(rateController.text),
                              reply: replyController.text,
                              replied: replied,
                            ),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text('Update'),
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      DeleteReviewParams(
                        widget.restaurant.id,
                        widget.review.docId,
                      ),
                    );
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
