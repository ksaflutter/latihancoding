// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../services/db_helper.dart';
// import '../services/shared_prefs_service.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_app_1/services/db_helper.dart';
import 'package:flutter_application_1/api_app_1/services/shared_prefs_service.dart';

class ReportScreenApi1 extends StatefulWidget {
  const ReportScreenApi1({super.key});

  @override
  State<ReportScreenApi1> createState() => _ReportScreenApi1State();
}

class _ReportScreenApi1State extends State<ReportScreenApi1> {
  Map<String, int> _summary = {
    'Present': 0,
    'Absent': 0,
    'Late': 0,
  };
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  Future<void> _loadSummary() async {
    final userId = await SharedPrefsServiceApi1.getUserId();
    if (userId != null) {
      final summary = await DBHelperApi1.instance.getAttendanceSummary(userId);
      setState(() {
        _summary = summary;
        _isLoading = false;
      });
    }
  }

  int get _totalAttendance =>
      _summary['Present']! + _summary['Absent']! + _summary['Late']!;

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attendance Report',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryRow(
                        'Total Attendance', _totalAttendance, Colors.blue),
                    const Divider(),
                    _buildSummaryRow(
                        'Present', _summary['Present']!, Colors.green),
                    _buildSummaryRow('Absent', _summary['Absent']!, Colors.red),
                    _buildSummaryRow('Late', _summary['Late']!, Colors.orange),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Attendance Chart',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_totalAttendance > 0)
                      SizedBox(
                        height: 300,
                        child: PieChart(
                          PieChartData(
                            sections: _getPieChartSections(),
                            centerSpaceRadius: 40,
                            sectionsSpace: 2,
                          ),
                        ),
                      )
                    else
                      const Center(
                        child: Text(
                          'No data to display',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Statistics',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_totalAttendance > 0) ...[
                      Text(
                        'Attendance Rate: ${((_summary['Present']! / _totalAttendance) * 100).toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Absence Rate: ${((_summary['Absent']! / _totalAttendance) * 100).toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Late Rate: ${((_summary['Late']! / _totalAttendance) * 100).toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ] else
                      const Text(
                        'No statistics available',
                        style: TextStyle(color: Colors.grey),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _getPieChartSections() {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: _summary['Present']!.toDouble(),
        title: 'Present\n${_summary['Present']}',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: _summary['Absent']!.toDouble(),
        title: 'Absent\n${_summary['Absent']}',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: _summary['Late']!.toDouble(),
        title: 'Late\n${_summary['Late']}',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}
