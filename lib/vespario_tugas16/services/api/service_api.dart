import 'dart:convert';
import 'package:flutter_application_1/vespario_tugas16/api/endpoint/endpoint.dart';
import 'package:flutter_application_1/vespario_tugas16/models/service_model.dart';
import 'package:flutter_application_1/vespario_tugas16/preference/shared_preference.dart';
import 'package:http/http.dart' as http;

class ServiceApiFinal {
  // Book a Service
  static Future<BookingResponseFinal> bookingService({
    required String bookingDate,
    required String vehicleType,
    required String description,
  }) async {
    try {
      final token = await SharedPreferenceFinal.getToken();
      final url = Uri.parse(EndpointFinal.bookingServis);

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

      if (response.statusCode == 200) {
        return BookingResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Booking gagal");
      }
    } catch (e) {
      throw Exception("Connection error: $e");
    }
  }

  // Create Service
  static Future<ServiceResponseFinal> createService({
    required String vehicleType,
    required String complaint,
  }) async {
    try {
      final token = await SharedPreferenceFinal.getToken();
      final url = Uri.parse(EndpointFinal.servis);

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

      if (response.statusCode == 200) {
        return ServiceResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Gagal membuat servis");
      }
    } catch (e) {
      throw Exception("Connection error: $e");
    }
  }

  // Get All Services
  static Future<ServiceListResponseFinal> getAllServices() async {
    try {
      final token = await SharedPreferenceFinal.getToken();
      final url = Uri.parse(EndpointFinal.servis);

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return ServiceListResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Gagal mengambil data servis");
      }
    } catch (e) {
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

      if (response.statusCode == 200) {
        return ServiceResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Gagal mengupdate status servis");
      }
    } catch (e) {
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

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return ServiceListResponseFinal.fromJson(json.decode(response.body));
      } else {
        final error = json.decode(response.body);
        throw Exception(error["message"] ?? "Gagal mengambil riwayat servis");
      }
    } catch (e) {
      throw Exception("Connection error: $e");
    }
  }

  // Delete Service
  static Future<ServiceResponseFinal> deleteService(int serviceId) async {
    try {
      final token = await SharedPreferenceFinal.getToken();
      final url = Uri.parse(EndpointFinal.deleteServis(serviceId));

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
        throw Exception(error["message"] ?? "Gagal menghapus servis");
      }
    } catch (e) {
      throw Exception("Connection error: $e");
    }
  }
}
