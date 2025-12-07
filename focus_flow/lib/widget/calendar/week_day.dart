import 'package:flutter/material.dart';

class WeekDay extends StatelessWidget {
  const WeekDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Day(text: "Пн")),
        Expanded(child: Day(text: "Вт")),
        Expanded(child: Day(text: "Ср")),
        Expanded(child: Day(text: "Чт")),
        Expanded(child: Day(text: "Пт")),
        Expanded(child: Day(text: "Сб")),
        Expanded(child: Day(text: "Вс")),
      ],
    );
  }
}

class Day extends StatelessWidget {
  final String text;
  const Day({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 45,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
