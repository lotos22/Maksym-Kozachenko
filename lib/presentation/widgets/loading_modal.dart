import 'package:flutter/material.dart';

class LoadingModalWidget extends StatelessWidget {
  final bool loading;
  final Widget child;
  LoadingModalWidget({
    required this.loading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: loading,
          child: Stack(
            children: [
              ModalBarrier(
                  dismissible: false, color: Colors.grey.withOpacity(0.1)),
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
