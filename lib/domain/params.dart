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
  GetRestaurantsParams(this.ownerId);
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
