import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/presentation/routes/app_routes.dart';
import 'package:toptal_test/presentation/view_model/sign_up_vm.dart';
import 'package:toptal_test/presentation/widgets/toast_widget.dart';

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
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      emailReg.hasMatch(value ?? '') ? null : 'Invalid email',
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: vm.passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: vm.passwordController2,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) => signUp(context, vm),
                  validator: (value) {
                    if (value != null &&
                        vm.passwordController.value.text.trim() != value.trim()) {
                      return 'Passwords don\'t match';
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                vm.isLoading
                    ? CircularProgressIndicator()
                    : TextButton(
                        onPressed: () => signUp(context, vm),
                        child: Text('SIGN UP'),
                      ),
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
    ToastWidget.showToast('Account successfully created');
    getIt<AppRouteDelegate>().popRoute();
  }
}
