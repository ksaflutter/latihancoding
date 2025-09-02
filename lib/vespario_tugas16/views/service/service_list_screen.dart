import 'package:flutter/material.dart';
import 'package:flutter_application_1/vespario_tugas16/models/service_model.dart';
import 'package:flutter_application_1/vespario_tugas16/services/api/service_api.dart';
import 'package:flutter_application_1/vespario_tugas16/theme/app_colors.dart';

class ServiceListScreenFinal extends StatefulWidget {
  const ServiceListScreenFinal({super.key});

  @override
  State<ServiceListScreenFinal> createState() => _ServiceListScreenFinalState();
}

class _ServiceListScreenFinalState extends State<ServiceListScreenFinal> {
  List<ServiceDataFinal> services = [];
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    loadServices();
  }

  Future<void> loadServices() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final response = await ServiceApiFinal.getAllServices();
      if (mounted) {
        setState(() {
          services = response.data ?? [];
          isLoading = false;
        });
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

  Future<void> createService() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => const CreateServiceDialogFinal(),
    );

    if (result != null &&
        result.containsKey('vehicleType') &&
        result.containsKey('complaint')) {
      try {
        await ServiceApiFinal.createService(
          vehicleType: result['vehicleType']!,
          complaint: result['complaint']!,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Service berhasil dibuat"),
              backgroundColor: AppColorsFinal.successGreen,
            ),
          );
          loadServices(); // Reload data
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString().replaceAll("Exception: ", "")),
              backgroundColor: AppColorsFinal.redAccent,
            ),
          );
        }
      }
    }
  }

  Future<void> updateServiceStatus(ServiceDataFinal service) async {
    final List<String> statusOptions = ["Menunggu", "Diproses", "Selesai"];

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: statusOptions.map((status) {
              return ListTile(
                title: Text(status),
                leading: Radio<String>(
                  value: status,
                  groupValue: service.status,
                  onChanged: (value) {
                    Navigator.of(context).pop(value);
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );

    if (result != null && result != service.status) {
      try {
        await ServiceApiFinal.updateServiceStatus(
          serviceId: service.id!,
          status: result,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Status berhasil diupdate"),
              backgroundColor: AppColorsFinal.successGreen,
            ),
          );
          loadServices(); // Reload data
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString().replaceAll("Exception: ", "")),
              backgroundColor: AppColorsFinal.redAccent,
            ),
          );
        }
      }
    }
  }

  Future<void> deleteService(ServiceDataFinal service) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Service"),
          content:
              Text("Yakin ingin menghapus service ${service.vehicleType}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorsFinal.redAccent),
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );

    if (result == true) {
      try {
        await ServiceApiFinal.deleteService(service.id!);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Service berhasil dihapus"),
              backgroundColor: AppColorsFinal.successGreen,
            ),
          );
          loadServices(); // Reload data
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString().replaceAll("Exception: ", "")),
              backgroundColor: AppColorsFinal.redAccent,
            ),
          );
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
              gradient: AppColorsFinal.primaryGradient,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.build, color: AppColorsFinal.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      "Kelola Service",
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
                  "Buat dan kelola service Vespa anda",
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
              onRefresh: loadServices,
              child: _buildContent(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createService,
        backgroundColor: AppColorsFinal.mintGreen,
        child: const Icon(Icons.add, color: AppColorsFinal.white),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColorsFinal.mintGreen),
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
              onPressed: loadServices,
              child: const Text("Coba Lagi"),
            ),
          ],
        ),
      );
    }

    if (services.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.build_outlined,
                size: 64, color: AppColorsFinal.mediumGray),
            SizedBox(height: 16),
            Text(
              "Belum ada service",
              style: TextStyle(
                fontSize: 18,
                color: AppColorsFinal.mediumGray,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Tekan tombol + untuk menambah service",
              style: TextStyle(color: AppColorsFinal.mediumGray),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _buildServiceCard(service);
      },
    );
  }

  Widget _buildServiceCard(ServiceDataFinal service) {
    Color statusColor = _getStatusColor(service.status ?? "");

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.vehicleType ?? "-",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColorsFinal.darkGray,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service.complaint ?? "-",
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColorsFinal.mediumGray,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    service.status ?? "Unknown",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.access_time,
                    size: 16, color: AppColorsFinal.mediumGray),
                const SizedBox(width: 4),
                Text(
                  _formatDate(service.createdAt),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColorsFinal.mediumGray,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => updateServiceStatus(service),
                  child: const Text("Update Status"),
                ),
                TextButton(
                  onPressed: () => deleteService(service),
                  style: TextButton.styleFrom(
                      foregroundColor: AppColorsFinal.redAccent),
                  child: const Text("Hapus"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'menunggu':
        return AppColorsFinal.warningYellow;
      case 'dikerjakan':
        return AppColorsFinal.infoBlue;
      case 'selesai':
        return AppColorsFinal.successGreen;
      default:
        return AppColorsFinal.mediumGray;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return "-";
    try {
      final date = DateTime.parse(dateString);
      return "${date.day}/${date.month}/${date.year}";
    } catch (e) {
      return dateString;
    }
  }
}

// Dialog untuk membuat service baru
class CreateServiceDialogFinal extends StatefulWidget {
  const CreateServiceDialogFinal({super.key});

  @override
  State<CreateServiceDialogFinal> createState() =>
      _CreateServiceDialogFinalState();
}

class _CreateServiceDialogFinalState extends State<CreateServiceDialogFinal> {
  final TextEditingController complaintController = TextEditingController();
  String? selectedVehicleType;

  final List<String> vehicleTypes = [
    "Motor Matic",
    "Motor Bebek",
    "Motor Sport",
    "Vespa Classic",
    "Vespa Modern",
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Buat Service Baru"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: selectedVehicleType,
            decoration: const InputDecoration(
              labelText: "Jenis Kendaraan",
              border: OutlineInputBorder(),
            ),
            items: vehicleTypes.map((String type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(type),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedVehicleType = newValue;
              });
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: complaintController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Keluhan/Permintaan",
              hintText: "Contoh: Mesin berisik, ganti oli, servis berkala",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Batal"),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedVehicleType != null &&
                complaintController.text.trim().isNotEmpty) {
              Navigator.of(context).pop({
                'vehicleType': selectedVehicleType!,
                'complaint': complaintController.text.trim(),
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Semua field harus diisi"),
                  backgroundColor: AppColorsFinal.redAccent,
                ),
              );
            }
          },
          child: const Text("Buat"),
        ),
      ],
    );
  }

  @override
  void dispose() {
    complaintController.dispose();
    super.dispose();
  }
}
