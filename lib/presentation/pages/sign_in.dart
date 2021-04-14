import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toptal_test/presentation/view_model/sign_in_vm.dart';
import 'package:toptal_test/presentation/widgets/toast_widget.dart';

class SignInPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailReg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SignInVM>(context);

    return Scaffold(
      body: ToastWidget(
        toast: vm.toast,
        child: SafeArea(
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
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) => signIn(context, vm),
                    validator: (value) {
                      if (value != null && value.length < 6) {
                        return 'Password must be more than 6 symbols';
                      }
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  vm.isLoading
                      ? CircularProgressIndicator()
                      : TextButton(
                          onPressed: () => signIn(context, vm),
                          child: Text('SIGN IN'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(BuildContext context, SignInVM vm) {
    FocusScope.of(context).unfocus();
    if (formKey.currentState?.validate() ?? false) {
      vm.login();
    }
  }
}
