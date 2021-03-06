import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';

import '../entities/review.dart';

class LoginSignInParams {
  final String email;
  final String pass;
  LoginSignInParams(this.email, this.pass);
}

class LoginSignUpParams extends LoginSignInParams {
  final int role;
  LoginSignUpParams(String email, String pass, this.role) : super(email, pass);
}

class GetRestaurantDetailsParams {
  final String restId;
  GetRestaurantDetailsParams(this.restId);
}

class GetRestaurantReviewsParams extends _PaginationParams {
  final String id;
  GetRestaurantReviewsParams(
    this.id, {
    String? lastDocId,
    int pageSize = 2,
  }) : super(
          lastDocId: lastDocId,
          pageSize: pageSize,
        );
}

class UpdateRestaurantParams {
  final Restaurant restaurant;
  UpdateRestaurantParams(this.restaurant);
}

class UpdateReviewParams {
  final String restaurantId;
  final Review review;
  UpdateReviewParams(
    this.restaurantId,
    this.review,
  );
}

class DeleteReviewParams {
  final String restaurantId;
  final String reviewId;
  DeleteReviewParams(this.restaurantId, this.reviewId);
}

class DeleteRestaurantParams {
  final String id;
  DeleteRestaurantParams(this.id);
}

class DeleteUserParams {
  final String id;
  DeleteUserParams(this.id);
}

class UpdateUserParams {
  final String id;
  final int role;
  UpdateUserParams(this.id, this.role);
}

class _PaginationParams {
  final String? lastDocId;
  final int pageSize;
  _PaginationParams({
    this.lastDocId,
    this.pageSize = 2,
  });
}

class GetRestaurantsParams extends _PaginationParams {
  final String? ownerId;
  final int filterByRating;
  GetRestaurantsParams(
    this.ownerId,
    this.filterByRating, {
    String? lastDocId,
    int pageSize = 2,
  }) : super(
          lastDocId: lastDocId,
          pageSize: pageSize,
        );
}

class GetPendingRepliesParams {
  final int page;
  final int pageSize;
  GetPendingRepliesParams({
    required this.page,
    required this.pageSize,
  });
}

class GetUsersParams extends _PaginationParams {
  GetUsersParams({
    String? lastDocId,
    int pageSize = 2,
  }) : super(
          lastDocId: lastDocId,
          pageSize: pageSize,
        );
}

class AddReplyParams {
  final String reply;
  final String restId;
  final String docId;
  AddReplyParams(
    this.reply,
    this.restId,
    this.docId,
  );
}

class AddRestaurantParams {
  final String name;
  final String ownerId;
  AddRestaurantParams(this.name, this.ownerId);
}

class AddRestaurantReviewParams {
  final String restaurantId;

  final int rating;
  final DateTime dateTime;
  final String comment;

  AddRestaurantReviewParams(
      this.restaurantId, this.rating, this.dateTime, this.comment);

  Map<String, dynamic> toReview(String userId) => {
        'userId': userId,
        'comment': comment,
        'dateVisited': Timestamp.fromDate(dateTime),
        'rating': rating,
        'reply': '',
        'replied': false,
      };
}
