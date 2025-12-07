import 'package:flutter/material.dart';
import 'package:focus_flow/controller/Is_number.dart';
import 'package:focus_flow/controller/get_colors.dart';
import 'package:focus_flow/main.dart';
import 'package:focus_flow/model/my_data.dart';
import 'package:focus_flow/widget/calendar/selected_mouth.dart';
import 'package:focus_flow/widget/calendar/week_day.dart';

import '../../controller/get_days_with_moth.dart';
import 'frame.dart';

class Calendar extends StatefulWidget {
  final int colorID;
  final Function deleteColor;

  const Calendar({super.key, required this.colorID, required this.deleteColor});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Map<int, List<int>> markedColors = {};
  MyData selectData = MyData(0, 0);
  int countFrame = 49;
  Map<int, Map<int, List<int>>> mothDay = {};

  @override
  void initState() {
    super.initState();
    selectData.currentDate();
    _rebuildMonthData();
  }

  int countsFrame() {
    int k = 0;
    mothDay.forEach((key, value) {
      if (value.keys.first == 1) {
        k = key;
      }
    });
    int res = mothDay.length + k - 7;
    return res;
  }

  void _onFrameTap(int index) {
    if (widget.colorID >= 0) {
      setState(() {
        if (markedColors[index]!.length > 6) {
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
      default:
        mothDay = getDaysWithMoth(selectData);
        if (mothDay[index] != null) {
          return "${mothDay[index]!.keys.first}";
        }
        return "";
    }
  }

  void onTapLeft() {
    setState(() {
      selectData = selectData.previewMouth(selectData);
      _rebuildMonthData();
    });
  }

  void onTapRight() {
    setState(() {
      selectData = selectData.nextMouth(selectData);
      _rebuildMonthData();
    });
  }

  void _rebuildMonthData() {
    mothDay = getDaysWithMoth(selectData);
    countFrame = countsFrame();
    final Map<int, List<int>> next = {};
    mothDay.forEach((index, dayMap) {
      next[index] = dayMap.values.expand((list) => list).toList();
    });
    setState(() {
      markedColors = next; // новая ссылка
    });
  }

  void deleteColor() {
    setState(() {
      widget.deleteColor();
    });
  }

  double getRatio(double height, weight) {
    const c = 7; // columns
    final n = countsFrame(); // days + header
    final r = (n / c).ceil();

    const crossSpacing = 1.0;
    const mainSpacing = 1.0;

    final wTile = (weight - (c - 1) * crossSpacing) / c;
    final hTile = (height - (r - 1) * mainSpacing) / r;
    final aspect = wTile / hTile;
    return aspect;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          widget.colorID != -1
              ? FloatingActionButton(
                backgroundColor:
                    widget.colorID == -1
                        ? Colors.transparent
                        : getColor(typeColors, widget.colorID),
                onPressed: () {
                  deleteColor();
                },
                child: const Icon(Icons.delete),
              )
              : Container(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectedMouth(
            selectedData: selectData,
            onTapLeft: () => onTapLeft(),
            onTapRight: () => onTapRight(),
          ),
          WeekDay(),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          childAspectRatio: getRatio(
                            constraints.maxHeight ,
                            constraints.maxWidth,
                          ),
                        ),
                        itemCount: countFrame,
                        itemBuilder: (context, index) {
                          index = index + 7;
                          var text = _getLabel(index);
                          if (text.isEmpty) {
                            return Container();
                          }
                          if (!isNumber(text)) {
                            return CalendarFrame(
                              index: index,
                              txt: text,
                              colors: markedColors[index] ?? [],
                              onTap: () => _onFrameTap(index),
                            );
                          }
                          return Container(
                            margin: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CalendarFrame(
                              index: index,
                              txt: text,
                              colors: markedColors[index] ?? [],
                              onTap: () => _onFrameTap(index),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
