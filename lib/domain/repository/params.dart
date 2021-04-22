import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';

import '../entities/review.dart';

class LoginSignInParams {
  final String email;
  final String pass;
  LoginSignInParams(this.email, this.pass);
}

class LoginSignUpParams extends LoginSignInParams {
  LoginSignUpParams(String email, String pass) : super(email, pass);
}

class GetRestaurantReviewsParams {
  final String id;
  GetRestaurantReviewsParams(this.id);
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

class GetRestaurantsParams {
  final String? ownerId;
  final int filterByRating;
  GetRestaurantsParams(this.ownerId,this.filterByRating);
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
  AddRestaurantParams(this.name);
}

class AddRestaurantReviewParams {
  final String restaurantId;

  final int rating;
  final DateTime dateTime;
  final String comment;

  AddRestaurantReviewParams(
      this.restaurantId, this.rating, this.dateTime, this.comment);

  Map<String, dynamic> toReview() => {
        'comment': comment,
        'dateVisited': Timestamp.fromDate(dateTime),
        'rating': rating,
        'reply': '',
        'replied': false,
      };
}
