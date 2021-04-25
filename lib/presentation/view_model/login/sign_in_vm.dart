import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/interactor/login/sign_in.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/localizations.dart';

@injectable
class SignInVM extends BaseVM {
  final SignIn _signIn;

  SignInVM(
    AppLocalizations appLocalizations,
    SignIn signIn,
  )   : _signIn = signIn,
        super(appLocalizations);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  void signIn() {
    isLoading = true;
    notifyListeners();
    _signIn.execute(
      LoginSignInParams(
        emailController.text.trim(),
        passwordController.text.trim(),
      ),
      (oneOf) {
        //omit success, should be handled by root
        if (oneOf.isError && (oneOf as Error).error is SignInFailure) {
          _onErrorSignIn(oneOf);
        }
        isLoading = false;
        notifyListeners();
      },
    );
  }

  void _onErrorSignIn(OneOf<Failure, Null> oneOf) {
    final error = (oneOf as Error).error as SignInFailure;
    var message = appLocalizations.something_went_wrong;
    if (error.isInvalidEmail || error.isUserNotFound || error.isUserDisabled) {
      message = appLocalizations.login_user_error;
    } else if (error.isWrongPassword) {
      message = appLocalizations.login_wrong_password;
    }
    sendMessage(message);
    notifyListeners();
  }
}
