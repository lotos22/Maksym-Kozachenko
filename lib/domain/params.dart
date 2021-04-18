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
