import 'package:flutter/material.dart';
import 'package:flutter_application_1/vespario_tugas16/models/service_model.dart';
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
      // Note: API doesn't have specific endpoint for booking list
      // This is a conceptual implementation
      // You might need to modify service_api.dart to add getBookings method

      setState(() {
        // For now, we'll show empty state
        bookings = [];
        isLoading = false;
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Booking"),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          // Header Info
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
                      "Appointment Booking",
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
                  "Daftar booking appointment yang telah dibuat",
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

    // Show explanation since API doesn't provide booking list endpoint
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 64, color: AppColorsFinal.orange),
            SizedBox(height: 16),
            Text(
              "Informasi Booking",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColorsFinal.darkGray,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Setelah Anda melakukan booking appointment:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColorsFinal.darkGray,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "1. Booking akan dikonfirmasi oleh admin\n"
              "2. Admin akan membuat service record di 'Kelola Service'\n"
              "3. Status service akan diupdate dari Menunggu → Dikerjakan → Selesai\n"
              "4. Service yang selesai akan muncul di 'Riwayat'",
              style: TextStyle(
                fontSize: 14,
                color: AppColorsFinal.mediumGray,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: AppColorsFinal.lightMint,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb, color: AppColorsFinal.mintGreen),
                        SizedBox(width: 8),
                        Text(
                          "Tips",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColorsFinal.mintGreen,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Untuk melihat status service Anda, buka menu 'Service' atau 'Riwayat'",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColorsFinal.darkGray,
                      ),
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
}
