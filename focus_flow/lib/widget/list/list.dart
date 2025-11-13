import 'package:flutter/material.dart';
import 'package:focus_flow/controller/add_activities.dart';
import 'package:focus_flow/controller/get_activities_json.dart';
import 'package:focus_flow/widget/list/tile.dart';
import '../../main.dart';
import 'add_item_dialog.dart';

class ToDoList extends StatefulWidget {
  final Function getColors;

  const ToDoList({super.key, required this.getColors});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  Map<String, Map<String, dynamic>> json = {}; // проще хранить Map с данными

  @override
  void initState() {
    super.initState();
    json = getActivitiesJson();
  }

  void _addItemDialog() {
    showAddItemDialog(
      context: context,
      onAdd: (key, value) {
        setState(() {
          json[key] = addActivities(
            name: value,
            colorId: json.length % typeColors.length,
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: ListView.builder(
        itemCount: json.length,
        itemBuilder: (context, index) {
          String key = json.keys.elementAt(index);
          String name = json[key]?["Name"] ?? "";
          int colorIndex = json[key]?["Color"] ?? 0;

          return CalendarTile(
            type: key,
            name: name,
            backgroundColor: colorIndex,
            onTap: widget.getColors,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
