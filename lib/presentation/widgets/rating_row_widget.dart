import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RatingRowWidget extends StatelessWidget {
  final String rating;
  final String text;

  RatingRowWidget({required this.rating, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(rating),
        SizedBox(width: 8),
        Icon(
          Icons.star,
          color: Colors.black,
        ),
        SizedBox(width: 24),
        Flexible(
          child: Text(text),
        ),
      ],
    );
  }
}
