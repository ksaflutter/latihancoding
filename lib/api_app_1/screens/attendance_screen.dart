// import 'package:flutter/material.dart';
// import '../models/attendance.dart';
// import '../services/db_helper.dart';
// import '../services/shared_prefs_service.dart';
// import '../services/api_service.dart';
// import '../widgets/attendance_form.dart';
// import '../widgets/attendance_list_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_app_1/models/attendant.dart';
import 'package:flutter_application_1/api_app_1/services/api_service.dart';
import 'package:flutter_application_1/api_app_1/services/db_helper.dart';
import 'package:flutter_application_1/api_app_1/services/shared_prefs_service.dart';
import 'package:flutter_application_1/api_app_1/widgets/attendance_form.dart';
import 'package:flutter_application_1/api_app_1/widgets/attendance_list_item.dart';

class AttendanceScreenApi1 extends StatefulWidget {
  const AttendanceScreenApi1({super.key});

  @override
  State<AttendanceScreenApi1> createState() => _AttendanceScreenApi1State();
}

class _AttendanceScreenApi1State extends State<AttendanceScreenApi1> {
  List<Attendance> attendanceList = [];
  bool _isLoading = true;
  bool _showForm = false;
  Attendance? _editingAttendance;
  int? _userId;

  @override
  void initState() {
    super.initState();
    _loadAttendance();
  }

  Future<void> _loadAttendance() async {
    _userId = await SharedPrefsServiceApi1.getUserId();
    if (_userId != null) {
      final list = await DBHelperApi1.instance.getAttendanceByUserId(_userId!);
      setState(() {
        attendanceList = list;
        _isLoading = false;
      });
    }
  }

  Future<void> _saveAttendance(Attendance attendance) async {
    if (_editingAttendance != null) {
      // Update existing attendance
      await DBHelperApi1.instance.updateAttendance(attendance);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Attendance updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Create new attendance
      await DBHelperApi1.instance.createAttendance(attendance);

      // Send to API (optional)
      final apiSuccess = await ApiService1.sendAttendanceToAPI(attendance);
      if (apiSuccess) {
        print('Attendance sent to API successfully');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Attendance marked successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }

    setState(() {
      _showForm = false;
      _editingAttendance = null;
    });

    _loadAttendance();
  }

  Future<void> _deleteAttendance(int id) async {
    await DBHelperApi1.instance.deleteAttendance(id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Attendance deleted'),
        backgroundColor: Colors.orange,
      ),
    );

    _loadAttendance();
  }

  void _editAttendance(Attendance attendance) {
    setState(() {
      _editingAttendance = attendance;
      _showForm = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: _showForm
          ? AttendanceFormApi1(
              userId: _userId!,
              attendance: _editingAttendance,
              onSave: _saveAttendance,
              onCancel: () {
                setState(() {
                  _showForm = false;
                  _editingAttendance = null;
                });
              },
            )
          : attendanceList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 100,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No attendance records yet',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _showForm = true;
                          });
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Mark Attendance'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: attendanceList.length,
                  itemBuilder: (context, index) {
                    return AttendanceListItemApi1(
                      attendance: attendanceList[index],
                      onEdit: () => _editAttendance(attendanceList[index]),
                      onDelete: () =>
                          _deleteAttendance(attendanceList[index].id!),
                    );
                  },
                ),
      floatingActionButton: !_showForm && attendanceList.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _showForm = true;
                });
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
