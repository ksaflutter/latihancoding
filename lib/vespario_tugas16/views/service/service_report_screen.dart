import 'package:flutter/material.dart';
import 'package:flutter_application_1/vespario_tugas16/models/service_model.dart';
import 'package:flutter_application_1/vespario_tugas16/services/api/service_api.dart';
import 'package:flutter_application_1/vespario_tugas16/theme/app_colors.dart';

class ServiceReportScreenFinal extends StatefulWidget {
  const ServiceReportScreenFinal({super.key});

  @override
  State<ServiceReportScreenFinal> createState() =>
      _ServiceReportScreenFinalState();
}

class _ServiceReportScreenFinalState extends State<ServiceReportScreenFinal> {
  List<ServiceDataFinal> allServices = [];
  List<ServiceDataFinal> historyServices = [];
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = "";

  // Statistics
  int totalServices = 0;
  int completedServices = 0;
  int pendingServices = 0;
  int inProgressServices = 0;
  Map<String, int> vehicleTypeStats = {};
  Map<String, int> monthlyStats = {};

  @override
  void initState() {
    super.initState();
    loadReportData();
  }

  Future<void> loadReportData() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      // Load both current services and history
      final servicesResponse = await ServiceApiFinal.getAllServices();
      final historyResponse = await ServiceApiFinal.getServiceHistory();

      if (mounted) {
        setState(() {
          allServices = servicesResponse.data ?? [];
          historyServices = historyResponse.data ?? [];
          isLoading = false;
        });
        calculateStatistics();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
          hasError = true;
          errorMessage = e.toString().replaceAll("Exception: ", "");
        });
      }
    }
  }

  void calculateStatistics() {
    // Combine all services for comprehensive statistics
    List<ServiceDataFinal> combinedServices = [
      ...allServices,
      ...historyServices
    ];

    totalServices = combinedServices.length;
    completedServices = combinedServices
        .where((s) => s.status?.toLowerCase() == 'selesai')
        .length;
    pendingServices = combinedServices
        .where((s) => s.status?.toLowerCase() == 'menunggu')
        .length;
    inProgressServices = combinedServices
        .where((s) => s.status?.toLowerCase() == 'dikerjakan')
        .length;

    // Vehicle type statistics
    vehicleTypeStats.clear();
    for (var service in combinedServices) {
      String vehicleType = service.vehicleType ?? "Unknown";
      vehicleTypeStats[vehicleType] = (vehicleTypeStats[vehicleType] ?? 0) + 1;
    }

    // Monthly statistics
    monthlyStats.clear();
    for (var service in combinedServices) {
      if (service.createdAt != null) {
        try {
          DateTime date = DateTime.parse(service.createdAt!);
          String monthKey =
              "${date.year}-${date.month.toString().padLeft(2, '0')}";
          monthlyStats[monthKey] = (monthlyStats[monthKey] ?? 0) + 1;
        } catch (e) {
          // Skip invalid dates
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColorsFinal.dangerRed, Color(0xFFC0392B)],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.analytics,
                        color: AppColorsFinal.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      "Laporan Service",
                      style: TextStyle(
                        color: AppColorsFinal.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "Analisa data dan statistik service Vespa",
                  style: TextStyle(
                    color: AppColorsFinal.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: RefreshIndicator(
              onRefresh: loadReportData,
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColorsFinal.dangerRed),
      );
    }

    if (hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: AppColorsFinal.redAccent),
            const SizedBox(height: 16),
            Text(
              "Error: $errorMessage",
              style: const TextStyle(color: AppColorsFinal.redAccent),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: loadReportData,
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorsFinal.dangerRed),
              child: const Text("Coba Lagi"),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Statistics Cards
          _buildSummaryCards(),

          const SizedBox(height: 24),

          // Status Distribution
          _buildStatusDistribution(),

          const SizedBox(height: 24),

          // Vehicle Type Statistics
          _buildVehicleTypeStats(),

          const SizedBox(height: 24),

          // Monthly Trend
          _buildMonthlyTrend(),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Ringkasan",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColorsFinal.darkGray,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.0,
          children: [
            _buildSummaryCard(
              "Total Service",
              totalServices.toString(),
              Icons.build,
              AppColorsFinal.infoBlue,
            ),
            _buildSummaryCard(
              "Selesai",
              completedServices.toString(),
              Icons.check_circle,
              AppColorsFinal.successGreen,
            ),
            _buildSummaryCard(
              "Dikerjakan",
              inProgressServices.toString(),
              Icons.pending,
              AppColorsFinal.warningYellow,
            ),
            _buildSummaryCard(
              "Menunggu",
              pendingServices.toString(),
              Icons.hourglass_empty,
              AppColorsFinal.dangerRed,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: AppColorsFinal.mediumGray,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusDistribution() {
    if (totalServices == 0) return const SizedBox.shrink();

    double completedPercentage = (completedServices / totalServices) * 100;
    double inProgressPercentage = (inProgressServices / totalServices) * 100;
    double pendingPercentage = (pendingServices / totalServices) * 100;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Distribusi Status",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColorsFinal.darkGray,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatusBar("Selesai", completedPercentage,
                AppColorsFinal.successGreen, completedServices),
            const SizedBox(height: 8),
            _buildStatusBar("Dikerjakan", inProgressPercentage,
                AppColorsFinal.warningYellow, inProgressServices),
            const SizedBox(height: 8),
            _buildStatusBar("Menunggu", pendingPercentage,
                AppColorsFinal.dangerRed, pendingServices),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBar(
      String label, double percentage, Color color, int count) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColorsFinal.darkGray,
              ),
            ),
            Text(
              "$count (${percentage.toStringAsFixed(1)}%)",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: AppColorsFinal.lightGray,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  Widget _buildVehicleTypeStats() {
    if (vehicleTypeStats.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Statistik Jenis Kendaraan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColorsFinal.darkGray,
              ),
            ),
            const SizedBox(height: 16),
            ...vehicleTypeStats.entries.map((entry) {
              double percentage = (entry.value / totalServices) * 100;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        entry.key,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: LinearProgressIndicator(
                        value: percentage / 100,
                        backgroundColor: AppColorsFinal.lightGray,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColorsFinal.mintGreen),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${entry.value}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColorsFinal.mintGreen,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyTrend() {
    if (monthlyStats.isEmpty) return const SizedBox.shrink();

    // Sort months
    List<MapEntry<String, int>> sortedMonths = monthlyStats.entries.toList();
    sortedMonths.sort((a, b) => a.key.compareTo(b.key));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tren Bulanan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColorsFinal.darkGray,
              ),
            ),
            const SizedBox(height: 16),
            ...sortedMonths.map((entry) {
              String monthName = _formatMonth(entry.key);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        monthName,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: LinearProgressIndicator(
                          value: entry.value /
                              (sortedMonths
                                  .map((e) => e.value)
                                  .reduce((a, b) => a > b ? a : b)),
                          backgroundColor: AppColorsFinal.lightGray,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColorsFinal.infoBlue),
                        ),
                      ),
                    ),
                    Text(
                      "${entry.value}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColorsFinal.infoBlue,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _formatMonth(String monthKey) {
    try {
      List<String> parts = monthKey.split('-');
      int year = int.parse(parts[0]);
      int month = int.parse(parts[1]);

      List<String> monthNames = [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'Mei',
        'Jun',
        'Jul',
        'Ags',
        'Sep',
        'Okt',
        'Nov',
        'Des'
      ];

      return "${monthNames[month]} $year";
    } catch (e) {
      return monthKey;
    }
  }
}
