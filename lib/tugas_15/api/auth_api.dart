import 'dart:convert';

import 'package:flutter_application_1/tugas_15/api/endpoint/endpoint.dart';
import 'package:flutter_application_1/tugas_15/models/get_user_model.dart';
import 'package:flutter_application_1/tugas_15/models/login_model.dart';
import 'package:flutter_application_1/tugas_15/models/register_model.dart';
import 'package:flutter_application_1/tugas_15/models/update_user_model.dart';
import 'package:flutter_application_1/tugas_15/preference/shared_preference.dart';
import 'package:http/http.dart' as http;

class AuthAPI {
  // Register User
  static Future<RegisterModel> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    final url = Uri.parse(Endpoint.register);
    final response = await http.post(
      url,
      body: {
        "name": name,
        "email": email,
        "password": password,
      },
      headers: {
        "Accept": "application/json",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterModel.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Register gagal");
    }
  }

  // Login User
  static Future<LoginModel> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(Endpoint.login);
    final response = await http.post(
      url,
      body: {
        "email": email,
        "password": password,
      },
      headers: {
        "Accept": "application/json",
      },
    );
    if (response.statusCode == 200) {
      return LoginModel.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Login gagal");
    }
  }

  // Get Profile
  static Future<GetUserModel> getProfile() async {
    final url = Uri.parse(Endpoint.profile);
    final token = await PreferenceHandler.getToken();
    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      return GetUserModel.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Gagal mengambil profile");
    }
  }

  // Update Profile
  static Future<UpdateUserModel> updateProfile({
    required String name,
    required String email,
  }) async {
    final url = Uri.parse(Endpoint.updateProfile);
    final token = await PreferenceHandler.getToken();
    final response = await http.put(
      url,
      body: {
        "name": name,
        "email": email,
      },
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      return UpdateUserModel.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Update profile gagal");
    }
  }

  // Logout
  static Future<void> logout() async {
    final url = Uri.parse(Endpoint.logout);
    final token = await PreferenceHandler.getToken();
    await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }
}
