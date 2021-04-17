import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:toptal_test/presentation/view_model/login/sign_up_vm.dart';
import 'package:toptal_test/presentation/widgets/loading_button.dart';
import 'package:toptal_test/presentation/widgets/toast_widget.dart';
import 'package:toptal_test/utils/localizations.dart';

class SignUpPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailReg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SignUpVM>(context);

    if (vm.isSuccess) showMessageSuccess(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ToastWidget(
        toast: vm.toast,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: vm.emailController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).login_email,
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) => emailReg.hasMatch(value ?? '')
                      ? null
                      : AppLocalizations.of(context).login_invalid_email,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: vm.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).login_password,
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: vm.passwordController2,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).login_password,
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) => signUp(context, vm),
                  validator: (value) {
                    if (value != null &&
                        vm.passwordController.value.text.trim() !=
                            value.trim()) {
                      return AppLocalizations.of(context)
                          .sign_up_passwords_dont_match;
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedLoading(
                  isLoading: vm.isLoading,
                  child: ElevatedButton(
                    onPressed: () => signUp(context, vm),
                    child: Text(AppLocalizations.of(context).login_sign_up),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp(BuildContext context, SignUpVM vm) {
    FocusScope.of(context).unfocus();
    if (formKey.currentState?.validate() ?? false) {
      vm.signUp();
    }
  }

  void showMessageSuccess(BuildContext context) {
    ToastWidget.showToast(AppLocalizations.of(context).sign_up_account_created);
  }
}
