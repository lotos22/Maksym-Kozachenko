abstract class Failure {
  Failure();
  factory Failure.loginFailure(String code) = LoginFailure;
}

class LoginFailure extends Failure {
  final String code;
  LoginFailure(this.code);

  bool get isInvalidEmail => code == 'invalid-email';
  bool get isUserDisabled => code == 'user-disabled';
  bool get isUserNotFound => code == 'user-not-found';
  bool get isWrongPassword => code == 'wrong-password';
}
