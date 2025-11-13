import 'package:flutter/material.dart';
import 'package:focus_flow/controller/get_colors.dart';
import 'package:focus_flow/widget/calendar/calendar.dart';
import 'package:focus_flow/widget/list/list.dart';
import 'package:focus_flow/widget/notes/notes.dart';

final typeColors = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.orange,
  Colors.purple,
  Colors.yellow,
  Colors.cyan,
  Colors.pink,
  Colors.black,
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
      selectedColor = colorsId;
    });
    print(colorsId);
  }

  void deleteColor(){
    setState(() {
      selectedColor = -1;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: selectedColor == -1 ? Theme.of(context).colorScheme.inversePrimary: getColor(typeColors, selectedColor),
        title: Row(
          children: [
            Text("Calendar"),
            InkWell(
              onTap: ()=> deleteColor(),
              child: Card(
                child: Icon(Icons.abc_sharp),
              ),
            )
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 815) {
            return Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Calendar(colorID: selectedColor,), // Calendar разворачивается на весь экран
                ),
                Expanded(
                  child: ToDoList(getColors: setColor,), // Notes заменяется на ToDoList
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Expanded(
                  flex: 4, // 4/5 высоты
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2, // 2/3 ширины
                        child: Calendar(colorID: selectedColor,),
                      ),
                      Expanded(
                        flex: 1, // 1/3 ширины
                        child: ToDoList(getColors: setColor,),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1, // 1/5 высоты
                  child: Notes(),
                ),
              ],
            );
          }
        },
      )
    );
  }
}
