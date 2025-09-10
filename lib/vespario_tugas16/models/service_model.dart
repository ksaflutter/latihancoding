import 'dart:convert';

// Booking Service Response Model
BookingResponseFinal bookingResponseFinalFromJson(String str) =>
    BookingResponseFinal.fromJson(json.decode(str));

String bookingResponseFinalToJson(BookingResponseFinal data) =>
    json.encode(data.toJson());

class BookingResponseFinal {
  String? message;
  BookingDataFinal? data;

  BookingResponseFinal({this.message, this.data});

  factory BookingResponseFinal.fromJson(Map<String, dynamic> json) =>
      BookingResponseFinal(
        message: json["message"],
        data: json["data"] == null
            ? null
            : BookingDataFinal.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class BookingDataFinal {
  int? id;
  String? bookingDate;
  String? vehicleType;
  String? description;
  int? userId;
  String? updatedAt;
  String? createdAt;

  BookingDataFinal({
    this.id,
    this.bookingDate,
    this.vehicleType,
    this.description,
    this.userId,
    this.updatedAt,
    this.createdAt,
  });

  factory BookingDataFinal.fromJson(Map<String, dynamic> json) =>
      BookingDataFinal(
        id: _parseToInt(json["id"]),
        bookingDate: json["booking_date"],
        vehicleType: json["vehicle_type"],
        description: json["description"],
        userId: _parseToInt(json["user_id"]),
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_date": bookingDate,
        "vehicle_type": vehicleType,
        "description": description,
        "user_id": userId,
        "updated_at": updatedAt,
        "created_at": createdAt,
      };

  // Helper method to safely parse int from dynamic
  static int? _parseToInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }
}

// Booking List Response Model
BookingListResponseFinal bookingListResponseFinalFromJson(String str) =>
    BookingListResponseFinal.fromJson(json.decode(str));

String bookingListResponseFinalToJson(BookingListResponseFinal data) =>
    json.encode(data.toJson());

class BookingListResponseFinal {
  String? message;
  List<BookingDataFinal>? data;

  BookingListResponseFinal({this.message, this.data});

  factory BookingListResponseFinal.fromJson(Map<String, dynamic> json) =>
      BookingListResponseFinal(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<BookingDataFinal>.from(
                json["data"].map((x) => BookingDataFinal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

// Service Response Model
ServiceResponseFinal serviceResponseFinalFromJson(String str) =>
    ServiceResponseFinal.fromJson(json.decode(str));

String serviceResponseFinalToJson(ServiceResponseFinal data) =>
    json.encode(data.toJson());

class ServiceResponseFinal {
  String? message;
  dynamic data; // Can be single ServiceDataFinal or List<ServiceDataFinal>

  ServiceResponseFinal({this.message, this.data});

  factory ServiceResponseFinal.fromJson(Map<String, dynamic> json) =>
      ServiceResponseFinal(
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
      };
}

// Service List Response Model
ServiceListResponseFinal serviceListResponseFinalFromJson(String str) =>
    ServiceListResponseFinal.fromJson(json.decode(str));

String serviceListResponseFinalToJson(ServiceListResponseFinal data) =>
    json.encode(data.toJson());

class ServiceListResponseFinal {
  String? message;
  List<ServiceDataFinal>? data;

  ServiceListResponseFinal({this.message, this.data});

  factory ServiceListResponseFinal.fromJson(Map<String, dynamic> json) =>
      ServiceListResponseFinal(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ServiceDataFinal>.from(
                json["data"].map((x) => ServiceDataFinal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ServiceDataFinal {
  int? id;
  int? userId;
  int? bookingId; // FIELD BARU untuk tracking booking
  String? vehicleType;
  String? complaint;
  String? status;
  String? createdAt;
  String? updatedAt;

  ServiceDataFinal({
    this.id,
    this.userId,
    this.bookingId,
    this.vehicleType,
    this.complaint,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceDataFinal.fromJson(Map<String, dynamic> json) =>
      ServiceDataFinal(
        id: _parseToInt(json["id"]),
        userId: _parseToInt(json["user_id"]),
        bookingId: _parseToInt(json["booking_id"]), // PARSING AMAN
        vehicleType: json["vehicle_type"],
        complaint: json["complaint"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "booking_id": bookingId,
        "vehicle_type": vehicleType,
        "complaint": complaint,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  Map<String, Object?> toMap() => {
        "id": id,
        "user_id": userId,
        "booking_id": bookingId,
        "vehicle_type": vehicleType,
        "complaint": complaint,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  factory ServiceDataFinal.fromMap(Map<String, dynamic> map) =>
      ServiceDataFinal(
        id: _parseToInt(map["id"]),
        userId: _parseToInt(map["user_id"]),
        bookingId: _parseToInt(map["booking_id"]),
        vehicleType: map["vehicle_type"],
        complaint: map["complaint"],
        status: map["status"],
        createdAt: map["created_at"],
        updatedAt: map["updated_at"],
      );

  // HELPER METHOD UNTUK PARSING AMAN - INI YANG PENTING!
  static int? _parseToInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }
}

// Service Status Response Model
ServiceStatusResponseFinal serviceStatusResponseFinalFromJson(String str) =>
    ServiceStatusResponseFinal.fromJson(json.decode(str));

String serviceStatusResponseFinalToJson(ServiceStatusResponseFinal data) =>
    json.encode(data.toJson());

class ServiceStatusResponseFinal {
  String? message;
  ServiceStatusDataFinal? data;

  ServiceStatusResponseFinal({this.message, this.data});

  factory ServiceStatusResponseFinal.fromJson(Map<String, dynamic> json) =>
      ServiceStatusResponseFinal(
        message: json["message"],
        data: json["data"] == null
            ? null
            : ServiceStatusDataFinal.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class ServiceStatusDataFinal {
  String? status;

  ServiceStatusDataFinal({this.status});

  factory ServiceStatusDataFinal.fromJson(Map<String, dynamic> json) =>
      ServiceStatusDataFinal(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
