import 'package:flutter/material.dart';
import 'package:focus_flow/controller/get_activities_json.dart';
import 'package:focus_flow/model/activities.dart';
import 'package:focus_flow/widget/list/tile.dart';
import 'add_item_dialog.dart';

class ToDoList extends StatefulWidget {
  final Function getColors;

  const ToDoList({super.key, required this.getColors});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  late Future<Categories> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories(); // ← Загружаем один раз
  }

  void _addItemDialog() {
    showAddItemDialog(
      context: context,
      onAdd: (key, value) {
        setState(() {
          futureCategories = fetchCategories(); // обновляем список
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: Scaffold(
        body: FutureBuilder<Categories>(
          future: futureCategories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Ошибка: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.activities == null) {
              return const Center(child: Text('Нет данных'));
            }

            final activities = snapshot.data!.activities!;

            return ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final item = activities[index];

                return CalendarTile(
                  type: item.key!,
                  name: item.name!,
                  backgroundColor: item.color!,
                  onTap: widget.getColors,
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addItemDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
