import 'package:flutter/material.dart';

class LeftArrow extends StatelessWidget {
  final Function onTap;

  const LeftArrow({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Arrow(onTap: onTap, icon: Icon(Icons.arrow_left));
  }
}

class RightArrow extends StatelessWidget {
  final Function onTap;

  const RightArrow({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Arrow(onTap: onTap, icon: Icon(Icons.arrow_right));
  }
}

class Arrow extends StatelessWidget {
  final Function onTap;
  final Icon icon;

  const Arrow({super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey, // цвет окружности
            width: 2, // толщина линии
          ),
        ),
        child: icon,
      ),),
    );
  }
}
