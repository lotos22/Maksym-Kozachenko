import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;
  final String comment;
  final DateTime dateVisited;
  final int rate;
  final String reply;
  final bool replied;

  Review({
    required this.id,
    required this.comment,
    required this.dateVisited,
    required this.rate,
    required this.reply,
    this.replied = false,
  });
  factory Review.fromMap(String id,Map<String, dynamic> data) => Review(
        id: id,
        comment: data['comment'],
        dateVisited: (data['dateVisited'] as Timestamp).toDate(),
        rate: data['rating'],
        reply: data['reply'],
        replied: data['replied'],
      );

  Map<String, dynamic> toMap() => {
        'comment': comment,
        'dateVisited': Timestamp.fromDate(dateVisited),
        'rating': rate,
        'reply': reply,
        'replied': replied,
      };
}
