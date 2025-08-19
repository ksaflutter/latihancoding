import 'package:shared_preferences/shared_preferences.dart';

class AuthPreferences {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUsername = 'username';
  static const String _keyEmail = 'email';
  static const String _keyUserPassword =
      'user_password'; // In real app, never store password
  // Login user
  static Future<bool> loginUser(
      String username, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    // validasi lebih dulu
    final savedEmail = prefs.getString(_keyEmail) ?? '';
    final savedPassword = prefs.getString(_keyUserPassword) ?? '';
    // Simple validation
    if (email == savedEmail && password == savedPassword) {
      // jika sudah match, set isLoggedIn ke true
      await prefs.setBool(_keyIsLoggedIn, true);
      return true;
    }
    return false;
  }

  // Register user
  static Future<bool> registerUser(
      String username, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    // Simple validation
    if (username.isNotEmpty && email.isNotEmpty && password.length >= 6) {
      await prefs.setBool(_keyIsLoggedIn, true);
      await prefs.setString(_keyUsername, username);
      await prefs.setString(_keyEmail, email);
      await prefs.setString(_keyUserPassword, password); // ???
      return true;
    }
    return false;
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // Get current username
  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername) ?? 'User';
  }

  // Get current email
  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail) ?? '';
  }

  // Logout user
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, false);
  }

  // Validate login credentials
  static Future<bool> validateCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString(_keyEmail) ?? '';
    final savedPassword = prefs.getString(_keyUserPassword) ?? '';
    return email == savedEmail && password == savedPassword;
  }

  // Check if user exists (for registration)
  static Future<bool> userExists(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString(_keyEmail) ?? '';
    return savedEmail == email;
  }
}
