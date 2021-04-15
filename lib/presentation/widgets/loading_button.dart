import 'package:flutter/material.dart';
import 'package:toptal_test/utils/const.dart';

class AnimatedLoading extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  AnimatedLoading({
    required this.isLoading,
    required this.child,
  });

  @override
  _AnimatedLoadingState createState() => _AnimatedLoadingState();
}

class _AnimatedLoadingState extends State<AnimatedLoading>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      duration: AnimationDuration.short(),
      child: widget.isLoading ? CircularProgressIndicator() : widget.child,
    );
  }
}
