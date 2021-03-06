import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toptal_test/domain/entities/review.dart';

class PendingReply extends Review {
  final String restId;
  PendingReply({
    required this.restId,
    required String id,
    required String comment,
    required DateTime dateVisited,
    required int rate,
    required String reply,
  }) : super(
          id: id,
          comment: comment,
          dateVisited: dateVisited,
          rate: rate,
          reply: reply,
          replied: false,
        );
  factory PendingReply.fromJson(Map<dynamic, dynamic> data) => PendingReply(
        restId: data['restId'],
        id: data['reviewId'],
        comment: data['comment'],
        dateVisited: Timestamp(
          data['dateVisited']['_seconds'],
          data['dateVisited']['_nanoseconds'],
        ).toDate(),
        rate: data['rating'],
        reply: data['reply'] ?? '',
      );
}
