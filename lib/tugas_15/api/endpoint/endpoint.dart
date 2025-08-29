class Endpoint {
  static const String baseUrl = "https://absensib1.mobileprojp.com/api";
  static const String register = "$baseUrl/register";
  static const String login = "$baseUrl/login";
  static const String profile = "$baseUrl/profile";
  //static const String updateProfile = "$baseUrl/profile/update";
  // KEMUNGKINAN ENDPOINT YANG BENAR:
  // Option 1: Tanpa /update
  static const String updateProfile = "$baseUrl/profile";
  // Option 2: Dengan user/update
  // static const String updateProfile = "$baseUrl/user/update";
  // Option 3: Dengan users/{id}
  // static const String updateProfile = "$baseUrl/users";
  static const String logout = "$baseUrl/logout";
}
