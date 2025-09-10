import 'package:flutter/material.dart';
import 'package:flutter_application_1/vespario_tugas16/models/service_model.dart';
import 'package:flutter_application_1/vespario_tugas16/services/api/service_api.dart';
import 'package:flutter_application_1/vespario_tugas16/theme/app_colors.dart';

class BookingListScreenFinal extends StatefulWidget {
  const BookingListScreenFinal({super.key});

  @override
  State<BookingListScreenFinal> createState() => _BookingListScreenFinalState();
}

class _BookingListScreenFinalState extends State<BookingListScreenFinal> {
  List<BookingDataFinal> bookings = [];
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    loadBookings();
  }

  Future<void> loadBookings() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      print("🔍 Loading bookings...");
      final response = await ServiceApiFinal.getAllBookings();
      print("📊 Booking response: ${response.message}");
      print("📊 Booking data count: ${response.data?.length ?? 0}");

      if (mounted) {
        setState(() {
          bookings = response.data ?? [];
          isLoading = false;
        });
      }
    } catch (e) {
      print("❌ Booking error: $e");
      if (mounted) {
        setState(() {
          isLoading = false;
          hasError = true;
          errorMessage = e.toString().replaceAll("Exception: ", "");
        });
      }
    }
  }

  Future<void> editBooking(BookingDataFinal booking) async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => EditBookingDialogFinal(booking: booking),
    );

    if (result != null) {
      try {
        await ServiceApiFinal.updateBooking(
          bookingId: booking.id!,
          bookingDate: result['bookingDate']!,
          vehicleType: result['vehicleType']!,
          description: result['description']!,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Booking berhasil diupdate"),
              backgroundColor: AppColorsFinal.successGreen,
            ),
          );
          loadBookings(); // Reload data
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

  Future<void> deleteBooking(BookingDataFinal booking) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Booking"),
          content:
              Text("Yakin ingin menghapus booking ${booking.vehicleType}?"),
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
        await ServiceApiFinal.deleteBooking(booking.id!);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Booking berhasil dihapus"),
              backgroundColor: AppColorsFinal.successGreen,
            ),
          );
          loadBookings(); // Reload data
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

  Future<void> convertToService(BookingDataFinal booking) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Konversi ke Service"),
          content: Text(
              "Konversi booking ${booking.vehicleType} menjadi service record?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorsFinal.mintGreen),
              child: const Text("Konversi"),
            ),
          ],
        );
      },
    );

    if (result == true) {
      try {
        await ServiceApiFinal.convertBookingToService(booking.id!);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Booking berhasil dikonversi ke service"),
              backgroundColor: AppColorsFinal.successGreen,
            ),
          );
          loadBookings(); // Reload data
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
      appBar: AppBar(
        title: const Text("Daftar Booking"),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: AppColorsFinal.white),
        ),
        backgroundColor: AppColorsFinal.orange,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColorsFinal.orange, AppColorsFinal.darkOrange],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        color: AppColorsFinal.white, size: 24),
                    SizedBox(width: 8),
                    Text(
                      "Kelola Booking",
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
                  "Kelola appointment booking Anda",
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
              onRefresh: loadBookings,
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
        child: CircularProgressIndicator(color: AppColorsFinal.orange),
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
              onPressed: loadBookings,
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorsFinal.orange),
              child: const Text("Coba Lagi"),
            ),
          ],
        ),
      );
    }

    if (bookings.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today_outlined,
                size: 64, color: AppColorsFinal.mediumGray),
            SizedBox(height: 16),
            Text(
              "Belum ada booking",
              style: TextStyle(
                fontSize: 18,
                color: AppColorsFinal.mediumGray,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Buat booking baru untuk melihat daftar",
              style: TextStyle(color: AppColorsFinal.mediumGray),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return _buildBookingCard(booking);
      },
    );
  }

  Widget _buildBookingCard(BookingDataFinal booking) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColorsFinal.orange.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.motorcycle,
                    color: AppColorsFinal.orange,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.vehicleType ?? "-",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColorsFinal.darkGray,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        booking.description ?? "-",
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColorsFinal.mediumGray,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColorsFinal.infoBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "ID: ${booking.id}",
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColorsFinal.infoBlue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(Icons.calendar_today,
                    size: 16, color: AppColorsFinal.mediumGray),
                const SizedBox(width: 4),
                Text(
                  _formatDate(booking.bookingDate),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColorsFinal.mediumGray,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.access_time,
                    size: 16, color: AppColorsFinal.mediumGray),
                const SizedBox(width: 4),
                Text(
                  _formatDate(booking.createdAt),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColorsFinal.mediumGray,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => convertToService(booking),
                    icon: const Icon(Icons.build, size: 16),
                    label: const Text("Konversi"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColorsFinal.mintGreen,
                      side: const BorderSide(color: AppColorsFinal.mintGreen),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => editBooking(booking),
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text("Edit"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColorsFinal.infoBlue,
                      side: const BorderSide(color: AppColorsFinal.infoBlue),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => deleteBooking(booking),
                    icon: const Icon(Icons.delete, size: 16),
                    label: const Text("Hapus"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColorsFinal.redAccent,
                      side: const BorderSide(color: AppColorsFinal.redAccent),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

// Dialog untuk edit booking
class EditBookingDialogFinal extends StatefulWidget {
  final BookingDataFinal booking;

  const EditBookingDialogFinal({super.key, required this.booking});

  @override
  State<EditBookingDialogFinal> createState() => _EditBookingDialogFinalState();
}

class _EditBookingDialogFinalState extends State<EditBookingDialogFinal> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedVehicleType;

  final List<String> vehicleTypes = [
    "Motor Matic",
    "Motor Bebek",
    "Motor Sport",
    "Vespa Classic",
    "Vespa Modern",
  ];

  @override
  void initState() {
    super.initState();
    dateController.text = widget.booking.bookingDate ?? "";
    descriptionController.text = widget.booking.description ?? "";
    selectedVehicleType = widget.booking.vehicleType;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Booking"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Tanggal Booking",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(const Duration(days: 1)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                );
                if (picked != null) {
                  dateController.text =
                      "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                }
              },
            ),
            const SizedBox(height: 16),
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
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Deskripsi",
                hintText: "Deskripsi service yang dibutuhkan",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Batal"),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedVehicleType != null &&
                dateController.text.trim().isNotEmpty &&
                descriptionController.text.trim().isNotEmpty) {
              Navigator.of(context).pop({
                'bookingDate': dateController.text.trim(),
                'vehicleType': selectedVehicleType!,
                'description': descriptionController.text.trim(),
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
          child: const Text("Update"),
        ),
      ],
    );
  }

  @override
  void dispose() {
    dateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
