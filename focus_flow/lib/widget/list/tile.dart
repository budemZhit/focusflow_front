import 'package:flutter/material.dart';
import 'package:focus_flow/main.dart';

import '../../controller/get_colors.dart';

class CalendarTile extends StatelessWidget {
  final String name;
  final String type;
  final int backgroundColor;
  final Function onTap;

  const CalendarTile({
    super.key,
    required this.type,
    required this.name,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(backgroundColor),
      child: Card(
        color: getColor(typeColors, backgroundColor),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.check,
              color: getColor(typeColors, backgroundColor),
            ),
          ),
          title: Text(name),
          subtitle: Text(type),
          trailing: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Моё кастомное окно", style: TextStyle(fontSize: 18)),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Закрыть"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 10,
              child: const Icon(Icons.arrow_drop_down, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}
