import 'package:flutter/material.dart';

import '../../controller/get_days_with_moth.dart';
import 'frame.dart';

class Calendar extends StatefulWidget {
  final int colorID;
  const Calendar({super.key, required this.colorID});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Map<int, List<int>> markedColors = {};

  @override
  void initState() {
    super.initState();
    // Заполняем начальными данными месяца
    final mothDay = getDaysWithMoth(11);
    mothDay.forEach((index, dayMap) {
      markedColors[index] = dayMap.values.expand((list) => list).toList();
    });
  }

  void _onFrameTap(int index) {
    if (widget.colorID >= 0) {
      setState(() {
        if (markedColors[index]!.length > 6){
          print(markedColors.length );
          return;
        }
        markedColors.putIfAbsent(index, () => []);
        if (markedColors[index]!.contains(widget.colorID)) {
          markedColors[index]!.remove(widget.colorID);
        } else {
          markedColors[index]!.add(widget.colorID);
        }
      });
    }
  }

  String _getLabel(int index) {
    switch (index) {
      case 0: return "Пн";
      case 1: return "Вт";
      case 2: return "Ср";
      case 3: return "Чт";
      case 4: return "Пт";
      case 5: return "Сб";
      case 6: return "Вс";
      default:
        final mothDay = getDaysWithMoth(11);
        if (mothDay[index] != null) {
          return "${mothDay[index]!.keys.first}";
        }
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ширина и высота контейнера
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        // размеры одного квадрата
        final squareWidth = width / 7;
        final squareHeight = height / 7;

        return GridView.count(
          crossAxisCount: 7, // 7 колонок
          physics: NeverScrollableScrollPhysics(), // без скролла
          childAspectRatio: squareWidth / squareHeight, // делаем квадраты
          children: List.generate(49, (index) {


            return CalendarFrame(
              index: index,
              txt: _getLabel(index),
              colors: markedColors[index] ?? [],
              onTap: () => _onFrameTap(index),
            );
          }),
        );
      },
    );

  }
}
