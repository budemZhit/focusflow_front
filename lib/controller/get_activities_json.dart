import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/activities.dart';

Future<Categories> fetchCategories() async {
  final url = Uri.parse('http://89.111.173.169/calendar/events');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    var ressult = Categories.fromJson(jsonData);

    return ressult;
  } else {
    throw Exception('Failed to load categories: ${response.statusCode}');
  }
}
