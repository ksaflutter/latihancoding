class Biodata {
  final int? id;
  final String fullName;
  final DateTime dateOfBirth;
  final String gender;
  final String address;
  final String phone;
  final String studentClass;
  final String course;
  final DateTime registrationDate;
  final String registrationTime;
  final int userId;

  Biodata({
    this.id,
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.phone,
    required this.studentClass,
    required this.course,
    required this.registrationDate,
    required this.registrationTime,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'address': address,
      'phone': phone,
      'studentClass': studentClass,
      'course': course,
      'registrationDate': registrationDate.toIso8601String(),
      'registrationTime': registrationTime,
      'userId': userId,
    };
  }

  factory Biodata.fromMap(Map<String, dynamic> map) {
    return Biodata(
      id: map['id'],
      fullName: map['fullName'],
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
      gender: map['gender'],
      address: map['address'],
      phone: map['phone'],
      studentClass: map['studentClass'],
      course: map['course'],
      registrationDate: DateTime.parse(map['registrationDate']),
      registrationTime: map['registrationTime'],
      userId: map['userId'],
    );
  }
}
