import 'dart:convert';
import 'package:flutter_application_1/vespario_tugas16/api/endpoint/endpoint.dart';
import 'package:flutter_application_1/vespario_tugas16/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthServiceFinal {
  // Register User
  static Future<RegisterResponseFinal> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse(EndpointFinal.register);

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        return RegisterResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Registrasi gagal");
      }
    } catch (e) {
      throw Exception("Connection error: $e");
    }
  }

  // Login User
  static Future<LoginResponseFinal> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse(EndpointFinal.login);

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        return LoginResponseFinal.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception("Email atau password salah");
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Login gagal");
      }
    } catch (e) {
      if (e.toString().contains("Email atau password salah")) {
        throw Exception("Email atau password salah");
      }
      throw Exception("Connection error: $e");
    }
  }

  // Get Profile (if needed in future)
  static Future<UserFinal> getProfile(String token) async {
    try {
      final url = Uri.parse(EndpointFinal.profile);

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserFinal.fromJson(data["data"]);
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Gagal mengambil profil");
      }
    } catch (e) {
      throw Exception("Connection error: $e");
    }
  }
}
