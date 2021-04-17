import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String comment;
  final DateTime dateVisited;
  final int rate;
  final String reply;

  Review({
    required this.comment,
    required this.dateVisited,
    required this.rate,
    required this.reply,
  });
  factory Review.fromMap(Map<String, dynamic> data) => Review(
        comment: data['comment'],
        dateVisited: (data['date_visited'] as Timestamp).toDate(),
        rate: data['rate'],
        reply: data['reply'],
      );
}
