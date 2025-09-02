class EndpointFinal {
  static const String baseUrl = "https://appbengkel.mobileprojp.com";

  // Auth Endpoints
  static const String register = "$baseUrl/api/register";
  static const String login = "$baseUrl/api/login";
  static const String profile = "$baseUrl/api/profile";

  // Service Endpoints
  static const String bookingServis = "$baseUrl/api/booking-servis";
  static const String servis = "$baseUrl/api/servis";
  static const String riwayatServis = "$baseUrl/api/riwayat-servis";

  // Service Status Endpoints
  static String servisStatus(int id) => "$baseUrl/api/servis/$id/status";
  static String deleteServis(int id) => "$baseUrl/api/servis/$id";
}
