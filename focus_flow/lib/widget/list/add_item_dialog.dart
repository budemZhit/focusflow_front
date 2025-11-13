import 'package:flutter/material.dart';

Future<void> showAddItemDialog({
  required BuildContext context,
  required Function(String key, String value) onAdd,
}) async {
  String key = "";
  String value = "";

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Добавить вид занятости"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Ключ (тип)"),
              onChanged: (text) => key = text,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Название деятельности"),
              onChanged: (text) => value = text,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Отмена"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text("Добавить"),
            onPressed: () {
              if (key.isNotEmpty && value.isNotEmpty) {
                onAdd(key, value); // передаём данные обратно
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
