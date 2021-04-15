import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastWidget extends StatelessWidget {
  final Widget child;
  final String? toast;
  ToastWidget({required this.child, this.toast});
  @override
  Widget build(BuildContext context) {
    if (toast != null && toast!.isNotEmpty) {
      Fluttertoast.showToast(msg: toast!);
    }
    return child;
  }

  static void showToast(String toast){
      Fluttertoast.showToast(msg: toast);
  }
}
