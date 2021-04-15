import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/presentation/routes/app_routes.dart';
import 'package:toptal_test/presentation/view_model/sign_in_vm.dart';
import 'package:toptal_test/presentation/widgets/loading_button.dart';
import 'package:toptal_test/presentation/widgets/toast_widget.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  final emailReg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SignInVM>(context);

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
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) => signIn(context, vm),
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedLoading(
                  isLoading: vm.isLoading,
                  child: ElevatedButton(
                    onPressed: () => signIn(context, vm),
                    child: Text('SIGN IN'),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());

                    getIt<AppRouteDelegate>()
                        .setNewRoutePath(RoutePath.signUp());
                  },
                  child: Text('SIGN UP'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn(BuildContext context, SignInVM vm) {
    FocusScope.of(context).unfocus();
    if (formKey.currentState?.validate() ?? false) {
      vm.signIn();
    }
  }
}
