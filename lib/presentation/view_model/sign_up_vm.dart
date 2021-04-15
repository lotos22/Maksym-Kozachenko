import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/login/sign_up.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';

@injectable
class SignUpVM extends BaseVM {
  final SignUp _signUp;

  SignUpVM(SignUp signUp) : _signUp = signUp;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();
  bool isLoading = false;
  bool isSuccess = false;

  void signUp() {
    isLoading = true;
    notifyListeners();
    _signUp.execute(
      LoginSignUpParams(emailController.text.trim(), passwordController.text.trim()),
      (oneOf) {
        if (oneOf.isError && (oneOf as Error).error is SignUpFailure) {
          _onErrorSignUp(oneOf);
        } else {
          isSuccess = true;
        }
        isLoading = false;
        notifyListeners();
      },
    );
  }

  void _onErrorSignUp(OneOf<Failure, Null> oneOf) {
    final error = (oneOf as Error).error as SignUpFailure;
    var message = 'Something went wrong';
    if (error.isInvalidEmail) {
      message = 'Email is incorrect';
    } else if (error.isEmailInUse) {
      message = 'Mail is already in use';
    } else if (error.isWeakPassword) {
      message = 'Week password';
    }
    sendMessage(message);
    notifyListeners();
  }
}
