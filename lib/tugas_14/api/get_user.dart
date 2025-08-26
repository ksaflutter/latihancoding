import 'dart:convert';

import 'package:flutter_application_1/tugas_14/models/user_model.dart';
import 'package:http/http.dart' as http;

Future<List<Welcome>> getUser() async {
  final response = await http.get(
    Uri.parse("https://hp-api.onrender.com/api/characters"),
  );
  print(response.body);
  if (response.statusCode == 200) {
    final List<dynamic> userJson = json.decode(response.body);
    return userJson.map((json) => Welcome.fromJson(json)).toList();
  } else {
    throw Exception("Gagal memuat data");
  }
}
