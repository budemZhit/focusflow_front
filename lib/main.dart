import 'package:flutter/material.dart';
import 'package:focus_flow/widget/calendar/calendar.dart';
import 'package:focus_flow/widget/list/list.dart';
import 'package:focus_flow/widget/notes/notes.dart';

final typeColors = [
  Colors.red.withValues(alpha: 0.85),
  Colors.green.withValues(alpha: 0.55),
  Colors.blue.withValues(alpha: 0.65),
  Colors.orange.withValues(alpha: 0.75),
  Colors.purple.withValues(alpha: 0.90),
  Colors.yellow.withValues(alpha: 0.95),
  Colors.cyan,
  Colors.pink.withValues(alpha: 0.55),
  Colors.pinkAccent,
  Colors.grey,
  Colors.brown,
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedColor = -1;

  void setColor(int colorsId) {
    setState(() {
      if (selectedColor == colorsId) {
        selectedColor = -1;
      } else {
        selectedColor = colorsId;
      }
    });
    print(colorsId);
  }

  void deleteColor() {
    setState(() {
      selectedColor = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Верная структура проекта pfgecnbncm")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 815) {
            return Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Calendar(
                    colorID: selectedColor,
                    deleteColor: () => deleteColor(),
                  ), // Calendar разворачивается на весь экран
                ),
                Expanded(
                  child: ToDoList(
                    getColors: setColor,
                  ), // Notes заменяется на ToDoList
                ),
              ],
            );
          } else {
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Calendar(
                          colorID: selectedColor,
                          deleteColor: () => deleteColor(),
                        ),
                      ),
                      Expanded(
                        flex: 1, // 1/5 высоты
                        child: Notes(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1, // 1/3 ширины
                  child: ToDoList(getColors: setColor),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
