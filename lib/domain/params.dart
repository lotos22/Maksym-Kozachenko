import 'package:cloud_firestore/cloud_firestore.dart';

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
      };
}
