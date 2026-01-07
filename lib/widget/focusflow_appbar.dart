import 'package:flutter/material.dart';

class FocusFlowAppBar extends StatelessWidget implements PreferredSizeWidget {
  final appBarHeight = 60.0;

  const FocusFlowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double iconSize = appBarHeight - 3.0;
    return Container(
      height: appBarHeight,
      decoration: BoxDecoration(
        color: Colors.orange,
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: iconSize,
            width: iconSize,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
