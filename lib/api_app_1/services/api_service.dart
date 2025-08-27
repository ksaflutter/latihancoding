// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../models/attendance.dart';

import 'dart:convert';

import 'package:flutter_application_1/api_app_1/models/attendant.dart';
import 'package:http/http.dart' as http;

class ApiService1 {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<bool> sendAttendanceToAPI(Attendance attendance) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(attendance.toJson()),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Error sending attendance to API: $e');
      return false;
    }
  }
}
