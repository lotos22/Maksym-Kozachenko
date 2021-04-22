import 'package:flutter/material.dart';

class FilterRestaurantsPopupItem extends PopupMenuItem {
  final Function? onChanged;
  // ignore: annotate_overrides
  final int value;

  const FilterRestaurantsPopupItem({
    Key? key,
    Widget? child,
    this.onChanged,
    required this.value,
  }) : super(
          key: key,
          child: child,
        );

  @override
  PopupMenuItemState<dynamic, PopupMenuItem> createState() =>
      _CheckedPopupItemState();
}

class _CheckedPopupItemState extends PopupMenuItemState {
  late var minRating = widget.value;

  @override
  void initState() {
    super.initState();
  }

  @override
  void handleTap() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(title: Text('Minimum rating')),
        getListTile(4),
        getListTile(3),
        getListTile(2),
        getListTile(1),
        getListTile(0),
      ],
    );
  }

  Widget getListTile(int value) {
    return RadioListTile(
      title: Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
          SizedBox(
            width: 8,
          ),
          Text(value.toString()),
        ],
      ),
      groupValue: minRating,
      onChanged: (value) {
        setState(() {
          minRating = value!;
          (widget as FilterRestaurantsPopupItem).onChanged?.call(minRating);
        });
      },
      value: value,
    );
  }
}
