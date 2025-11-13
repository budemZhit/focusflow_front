import 'package:flutter/material.dart';
import 'package:focus_flow/main.dart';

import '../../controller/get_colors.dart';

class CalendarTile extends StatelessWidget {
  final String name;
  final String type;
  final int backgroundColor;
  final Function onTap;

  const CalendarTile({
    super.key,
    required this.type,
    required this.name,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> onTap(backgroundColor),
      child: Container(
        color: getColor(typeColors, backgroundColor), // используем переданный цвет
        child: ListTile(title: Text(name), subtitle: Text(type)),
      ),
    );
  }
}
