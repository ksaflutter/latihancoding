import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/character.dart';

class ApiServiceAll1 {
  static const String baseUrl = 'https://hp-api.onrender.com/api';

  static Future<List<Character>> getCharacters() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/characters'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);

        // Limit to 20 characters for performance
        final limitedList = jsonList.take(20).toList();

        return limitedList.map((json) => Character.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load characters');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
