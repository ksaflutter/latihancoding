import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AuthPrefsSatu {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _loginTimeKey = 'login_time';

  // Set login status
  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);

    if (value) {
      await prefs.setString(_loginTimeKey, DateTime.now().toIso8601String());
    } else {
      // Clear all user data when logging out
      await clearUserData();
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Save user data
  static Future<void> saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, user.id!);
    await prefs.setString(_userNameKey, user.name);
    await prefs.setString(_userEmailKey, user.email);
  }

  // Get user ID
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  // Get user name
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  // Get user email
  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  // Get login time
  static Future<DateTime?> getLoginTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timeString = prefs.getString(_loginTimeKey);
    if (timeString != null) {
      return DateTime.parse(timeString);
    }
    return null;
  }

  // Clear all user data
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.remove(_userNameKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_loginTimeKey);
  }

  // Logout
  static Future<void> logout() async {
    await setLoggedIn(false);
  }

  // Check if session is still valid (optional: implement session timeout)
  static Future<bool> isSessionValid() async {
    if (!await isLoggedIn()) return false;

    final loginTime = await getLoginTime();
    if (loginTime == null) return false;

    // Session valid for 24 hours
    final sessionDuration = Duration(hours: 24);
    return DateTime.now().difference(loginTime) < sessionDuration;
  }

  // Get complete user data
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    if (!await isLoggedIn()) return null;

    return {
      'id': await getUserId(),
      'name': await getUserName(),
      'email': await getUserEmail(),
      'loginTime': await getLoginTime(),
    };
  }
}
