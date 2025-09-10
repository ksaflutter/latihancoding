import 'dart:convert';

import 'package:flutter_application_1/vespario_tugas16/api/endpoint/endpoint.dart';
import 'package:flutter_application_1/vespario_tugas16/models/service_model.dart';
import 'package:flutter_application_1/vespario_tugas16/preference/shared_preference.dart';
import 'package:http/http.dart' as http;

class ServiceApiFinal {
  // =================== BOOKING OPERATIONS ===================

  // Book a Service
  static Future<BookingResponseFinal> bookingService({
    required String bookingDate,
    required String vehicleType,
    required String description,
  }) async {
    try {
      final token = await SharedPreferenceFinal.getToken();
      final url = Uri.parse(EndpointFinal.bookingServis);

      print("🔍 Booking API Call:");
      print("URL: $url");
      print("Token: ${token != null ? 'Available' : 'Missing'}");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "booking_date": bookingDate,
          "vehicle_type": vehicleType,
          "description": description,
        }),
      );

      print("📊 Booking Response Status: ${response.statusCode}");
      print("📊 Booking Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return BookingResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Booking gagal");
      }
    } catch (e) {
      print("❌ Booking Error: $e");
      throw Exception("Connection error: $e");
    }
  }

  // NEW: Get All Bookings
  static Future<BookingListResponseFinal> getAllBookings() async {
    try {
      final token = await SharedPreferenceFinal.getToken();
      final url = Uri.parse(EndpointFinal.bookingServis);

      print("🔍 Get All Bookings API Call:");
      print("URL: $url");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("📊 Bookings Response Status: ${response.statusCode}");
      print("📊 Bookings Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return BookingListResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Gagal mengambil data booking");
      }
    } catch (e) {
      print("❌ Get Bookings Error: $e");
      throw Exception("Connection error: $e");
    }
  }

  // NEW: Update Booking
  static Future<BookingResponseFinal> updateBooking({
    required int bookingId,
    required String bookingDate,
    required String vehicleType,
    required String description,
  }) async {
    try {
      final token = await SharedPreferenceFinal.getToken();
      final url = Uri.parse(EndpointFinal.updateBooking(bookingId));

      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "booking_date": bookingDate,
          "vehicle_type": vehicleType,
          "description": description,
        }),
      );

      if (response.statusCode == 200) {
        return BookingResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Gagal mengupdate booking");
      }
    } catch (e) {
      throw Exception("Connection error: $e");
    }
  }

  // NEW: Delete Booking
  static Future<ServiceResponseFinal> deleteBooking(int bookingId) async {
    try {
      final token = await SharedPreferenceFinal.getToken();
      final url = Uri.parse(EndpointFinal.deleteBooking(bookingId));

      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return ServiceResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Gagal menghapus booking");
      }
    } catch (e) {
      throw Exception("Connection error: $e");
    }
  }

  // NEW: Convert Booking to Service
  static Future<ServiceResponseFinal> convertBookingToService(
      int bookingId) async {
    try {
      final token = await SharedPreferenceFinal.getToken();
      final url = Uri.parse(EndpointFinal.convertBookingToService(bookingId));

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return ServiceResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(
            error["message"] ?? "Gagal konversi booking ke service");
      }
    } catch (e) {
      throw Exception("Connection error: $e");
    }
  }

  // =================== SERVICE OPERATIONS ===================

  // Create Service
  static Future<ServiceResponseFinal> createService({
    required String vehicleType,
    required String complaint,
  }) async {
    try {
      final token = await SharedPreferenceFinal.getToken();
      final url = Uri.parse(EndpointFinal.servis);

      print("🔍 Create Service API Call:");
      print("URL: $url");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "vehicle_type": vehicleType,
          "complaint": complaint,
        }),
      );

      print("📊 Create Service Response Status: ${response.statusCode}");
      print("📊 Create Service Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return ServiceResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Gagal membuat servis");
      }
    } catch (e) {
      print("❌ Create Service Error: $e");
      throw Exception("Connection error: $e");
    }
  }

  // Get All Services
  static Future<ServiceListResponseFinal> getAllServices() async {
    try {
      final token = await SharedPreferenceFinal.getToken();
      final url = Uri.parse(EndpointFinal.servis);

      print("🔍 Get All Services API Call:");
      print("URL: $url");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("📊 Services Response Status: ${response.statusCode}");
      print("📊 Services Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return ServiceListResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Gagal mengambil data servis");
      }
    } catch (e) {
      print("❌ Get Services Error: $e");
      throw Exception("Connection error: $e");
    }
  }

  // Update Service Status
  static Future<ServiceResponseFinal> updateServiceStatus({
    required int serviceId,
    required String status,
  }) async {
    try {
      final token = await SharedPreferenceFinal.getToken();
      final url = Uri.parse(EndpointFinal.servisStatus(serviceId));

      print("🔍 Update Status API Call:");
      print("URL: $url");
      print("Status: $status");

      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "status": status,
        }),
      );

      print("📊 Update Status Response Status: ${response.statusCode}");
      print("📊 Update Status Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return ServiceResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Gagal mengupdate status servis");
      }
    } catch (e) {
      print("❌ Update Status Error: $e");
      throw Exception("Connection error: $e");
    }
  }

  // Get Service Status
  static Future<ServiceStatusResponseFinal> getServiceStatus(
      int serviceId) async {
    try {
      final token = await SharedPreferenceFinal.getToken();
      final url = Uri.parse(EndpointFinal.servisStatus(serviceId));

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return ServiceStatusResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Gagal mengambil status servis");
      }
    } catch (e) {
      throw Exception("Connection error: $e");
    }
  }

  // Get Service History
  static Future<ServiceListResponseFinal> getServiceHistory() async {
    try {
      final token = await SharedPreferenceFinal.getToken();
      final url = Uri.parse(EndpointFinal.riwayatServis);

      print("🔍 Get Service History API Call:");
      print("URL: $url");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("📊 History Response Status: ${response.statusCode}");
      print("📊 History Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return ServiceListResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Gagal mengambil riwayat servis");
      }
    } catch (e) {
      print("❌ Get History Error: $e");
      throw Exception("Connection error: $e");
    }
  }

  // Delete Service
  static Future<ServiceResponseFinal> deleteService(int serviceId) async {
    try {
      final token = await SharedPreferenceFinal.getToken();
      final url = Uri.parse(EndpointFinal.deleteServis(serviceId));

      print("🔍 Delete Service API Call:");
      print("URL: $url");
      print("Service ID: $serviceId");

      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("📊 Delete Service Response Status: ${response.statusCode}");
      print("📊 Delete Service Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return ServiceResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Gagal menghapus servis");
      }
    } catch (e) {
      print("❌ Delete Service Error: $e");
      throw Exception("Connection error: $e");
    }
  }
}
