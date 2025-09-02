import 'package:flutter/material.dart';
import 'package:flutter_application_1/vespario_tugas16/extension/navigation.dart';
import 'package:flutter_application_1/vespario_tugas16/services/api/service_api.dart';
import 'package:flutter_application_1/vespario_tugas16/theme/app_colors.dart';

class BookingFormScreenFinal extends StatefulWidget {
  const BookingFormScreenFinal({super.key});

  @override
  State<BookingFormScreenFinal> createState() => _BookingFormScreenFinalState();
}

class _BookingFormScreenFinalState extends State<BookingFormScreenFinal> {
  final TextEditingController bookingDateController = TextEditingController();
  final TextEditingController vehicleTypeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  final List<String> vehicleTypes = [
    "Motor Matic",
    "Motor Bebek",
    "Motor Sport",
    "Vespa Classic",
    "Vespa Modern",
  ];

  String? selectedVehicleType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Service"),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColorsFinal.lightMint,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColorsFinal.mintGreen.withOpacity(0.3)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: AppColorsFinal.mintGreen,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Booking Service Vespa",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColorsFinal.darkGray,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Isi form di bawah untuk membuat booking service Vespa anda",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColorsFinal.mediumGray,
                    ),
                  ),
                ],
              ),
            ),

            height(24),

            // Booking Date Field
            buildTitle("Tanggal Booking"),
            height(8),
            buildDateField(),

            height(16),

            // Vehicle Type Field
            buildTitle("Jenis Kendaraan"),
            height(8),
            buildVehicleDropdown(),

            height(16),

            // Description Field
            buildTitle("Deskripsi Service"),
            height(8),
            buildTextField(
              controller: descriptionController,
              hintText: "Contoh: Ganti oli, servis ringan, perbaikan rem, dll",
              maxLines: 4,
            ),

            height(32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : submitBooking,
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: AppColorsFinal.white,
                      )
                    : const Text("Buat Booking"),
              ),
            ),

            height(16),

            // Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColorsFinal.infoBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: AppColorsFinal.infoBlue.withOpacity(0.3)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: AppColorsFinal.infoBlue,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Informasi",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColorsFinal.darkGray,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "• Booking akan dikonfirmasi dalam 24 jam\n• Pastikan kendaraan dalam kondisi bisa dikendarai\n• Bawa surat-surat kendaraan saat datang",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColorsFinal.mediumGray,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColorsFinal.darkGray,
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColorsFinal.mediumGray.withOpacity(0.7)),
      ),
    );
  }

  Widget buildDateField() {
    return TextField(
      controller: bookingDateController,
      readOnly: true,
      decoration: InputDecoration(
        hintText: "Pilih tanggal booking",
        hintStyle: TextStyle(color: AppColorsFinal.mediumGray.withOpacity(0.7)),
        suffixIcon:
            const Icon(Icons.calendar_today, color: AppColorsFinal.mintGreen),
      ),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now().add(const Duration(days: 1)),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 30)),
        );
        if (picked != null) {
          bookingDateController.text =
              "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        }
      },
    );
  }

  Widget buildVehicleDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedVehicleType,
      decoration: InputDecoration(
        hintText: "Pilih jenis kendaraan",
        hintStyle: TextStyle(color: AppColorsFinal.mediumGray.withOpacity(0.7)),
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
          vehicleTypeController.text = newValue ?? "";
        });
      },
    );
  }

  SizedBox height(double height) => SizedBox(height: height);

  Future<void> submitBooking() async {
    final bookingDate = bookingDateController.text.trim();
    final vehicleType = vehicleTypeController.text.trim();
    final description = descriptionController.text.trim();

    if (bookingDate.isEmpty || vehicleType.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua field harus diisi"),
          backgroundColor: AppColorsFinal.redAccent,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await ServiceApiFinal.bookingService(
        bookingDate: bookingDate,
        vehicleType: vehicleType,
        description: description,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message ?? "Booking berhasil dibuat"),
            backgroundColor: AppColorsFinal.successGreen,
          ),
        );

        // Clear form
        bookingDateController.clear();
        vehicleTypeController.clear();
        descriptionController.clear();
        setState(() {
          selectedVehicleType = null;
        });

        context.pop();
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
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    bookingDateController.dispose();
    vehicleTypeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
