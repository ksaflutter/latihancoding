class Attendance {
  final int? id;
  final int userId;
  final String date;
  final String time;
  final String status;

  Attendance({
    this.id,
    required this.userId,
    required this.date,
    required this.time,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'time': time,
      'status': status,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'],
      userId: map['userId'],
      date: map['date'],
      time: map['time'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date,
      'time': time,
      'status': status,
    };
  }
}
