import 'package:flutter/material.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: TextField(
        expands: true,
        // растягивает поле на всю доступную высоту
        maxLines: null,
        // убирает ограничение по строкам
        minLines: null,
        // вместе с expands делает поле гибким
        textAlignVertical: TextAlignVertical.top,
        // текст начинается сверху
        decoration: InputDecoration(
          hintText: "Введите заметку...",
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
