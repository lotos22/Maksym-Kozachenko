abstract class Failure {
  Failure();

  factory Failure.unknownFailure(String message) = UnknownFailure;

  factory Failure.signInFailure(String code) = SignInFailure;
  factory Failure.signUpFailure(String code) = SignUpFailure;
}

class UnknownFailure extends Failure {
  final String message;
  UnknownFailure(this.message);
}

class SignInFailure extends Failure {
  final String code;
  SignInFailure(this.code);

  bool get isInvalidEmail => code == 'invalid-email';
  bool get isUserDisabled => code == 'user-disabled';
  bool get isUserNotFound => code == 'user-not-found';
  bool get isWrongPassword => code == 'wrong-password';
}

class SignUpFailure extends Failure {
  final String code;
  SignUpFailure(this.code);

  bool get isEmailInUse => code == 'email-already-in-use';
  bool get isInvalidEmail => code == 'invalid-email';
  bool get isWeakPassword => code == 'weak-password';
  bool get isOperationNotAloowed => code == 'operation-not-allowed';
}
