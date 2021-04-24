import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/repository/params.dart';

class EditRestaurantDialog extends StatefulWidget {
  final Restaurant restaurant;
  EditRestaurantDialog(this.restaurant);

  @override
  _EditRestaurantDialogState createState() => _EditRestaurantDialogState();
}

class _EditRestaurantDialogState extends State<EditRestaurantDialog> {
  final formKey = GlobalKey<FormState>();

  late final ownerIdController =
      TextEditingController(text: widget.restaurant.ownerId);
  late final nameController =
      TextEditingController(text: widget.restaurant.name);
  late final ratingController = TextEditingController(
      text: NumberFormat('0.0').format(widget.restaurant.avgRating));
  late final numRatingController =
      TextEditingController(text: widget.restaurant.numRatings.toString());

  InputDecoration getInputDecoration(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      );

  bool get isChanged =>
      ownerIdController.text != widget.restaurant.ownerId ||
      nameController.text != widget.restaurant.name ||
      ratingController.text !=
          NumberFormat('0.0').format(widget.restaurant.avgRating) ||
      numRatingController.text != widget.restaurant.numRatings.toString();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: ownerIdController,
                  decoration: getInputDecoration('Owner Id'),
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: nameController,
                  decoration: getInputDecoration('Name'),
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: ratingController,
                  decoration: getInputDecoration('Rating'),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || double.tryParse(value) == null) {
                      return 'Can\'t be empty';
                    }
                    if ((double.tryParse(value) ?? 6) > 5) {
                      return 'Can\'t be > 5';
                    }
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: numRatingController,
                  decoration: getInputDecoration('Number of ratings'),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || int.tryParse(value) == null) {
                      return 'Can\'t be empty';
                    }
                  },
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
                          UpdateRestaurantParams(
                            Restaurant(
                              id: widget.restaurant.id,
                              name: nameController.text,
                              ownerId: ownerIdController.text,
                              avgRating:
                                  num.parse(ratingController.text).toDouble(),
                              numRatings: int.parse(
                                numRatingController.text,
                              ),
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
                        context, DeleteRestaurantParams(widget.restaurant.id));
                  },
                  child: Text('Delete'),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
