import 'package:flutter/material.dart';

class FilterRestaurantsPopupItem extends PopupMenuItem {
  final Function? onCancel;
  final isChecked;
  const FilterRestaurantsPopupItem({
    Key? key,
    Widget? child,
    this.onCancel,
    this.isChecked = false,
  }) : super(
          key: key,
          child: child,
        );

  @override
  PopupMenuItemState<dynamic, PopupMenuItem> createState() =>
      _CheckedPopupItemState();
}

class _CheckedPopupItemState extends PopupMenuItemState {
  var isChecked = false;

  @override
  void initState() {
    isChecked = (widget as FilterRestaurantsPopupItem).isChecked;
    super.initState();
  }

  @override
  void handleTap() {}

  @override
  void dispose() {
    (widget as FilterRestaurantsPopupItem).onCancel?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        
      ],
    );
  }
}
