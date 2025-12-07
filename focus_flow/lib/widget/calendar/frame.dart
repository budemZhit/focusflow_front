import 'package:flutter/material.dart';
import 'package:focus_flow/controller/Is_number.dart';
import 'package:focus_flow/controller/get_colors.dart';
import 'package:focus_flow/main.dart';

class CalendarFrame extends StatelessWidget {
  final int index;
  final String txt;
  final List<int> colors; // список выбранных цветов
  final VoidCallback onTap;

  const CalendarFrame({
    super.key,
    required this.index,
    required this.colors,
    required this.onTap,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          8,
        ),
        color: colors.contains(0) ? Colors.green.withValues(alpha: 0.55) : Colors.transparent,
      ),
      child: InkWell(
        onTap: txt == "" || !isNumber(txt) ? () {} : onTap,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 35.0,
              child: Center(child: Text(txt, style: TextStyle(fontSize: 19))),
            ),
            Row(
              children:
                  colors.map((id) {
                    return Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.all(2),
                      color: getColor(typeColors, id),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
