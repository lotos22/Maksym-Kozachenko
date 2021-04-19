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
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(rating),
        ),
        SizedBox(width: 8),
        Icon(
          Icons.star,
          color: Colors.amber,
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 8,
          child: Text(text),
        ),
      ],
    );
  }
}
