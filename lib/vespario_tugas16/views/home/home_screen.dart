import 'package:flutter/material.dart';
import 'package:flutter_application_1/vespario_tugas16/extension/navigation.dart';
import 'package:flutter_application_1/vespario_tugas16/preference/shared_preference.dart';
import 'package:flutter_application_1/vespario_tugas16/theme/app_colors.dart';
import 'package:flutter_application_1/vespario_tugas16/views/service/booking_form_screen.dart';
import 'package:flutter_application_1/vespario_tugas16/views/service/booking_list_screen.dart';
import 'package:flutter_application_1/vespario_tugas16/views/service/service_history_screen.dart';
import 'package:flutter_application_1/vespario_tugas16/views/service/service_list_screen.dart';
import 'package:flutter_application_1/vespario_tugas16/views/service/service_report_screen.dart';
import 'package:flutter_application_1/vespario_tugas16/widgets/drawer_vespario.dart';

class HomeScreenFinal extends StatefulWidget {
  const HomeScreenFinal({super.key});

  @override
  State<HomeScreenFinal> createState() => _HomeScreenFinalState();
}

class _HomeScreenFinalState extends State<HomeScreenFinal> {
  int _selectedIndex = 0;
  String userName = "";

  // UPDATED: ServiceReportScreenFinal dengan showAppBar: false untuk bottom nav
  final List<Widget> _pages = [
    const HomeContentFinal(),
    const ServiceListScreenFinal(),
    const ServiceHistoryScreenFinal(),
    const ServiceReportScreenFinal(
        showAppBar: false), // NO APPBAR untuk bottom nav
  ];

  final List<String> _titles = [
    "Vespario",
    "Service Saya",
    "Riwayat",
    "Laporan",
  ];

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    final name = await SharedPreferenceFinal.getUserName();
    setState(() {
      userName = name ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // KONDISIONAL APPBAR - Hanya tampil jika bukan di laporan tab
      appBar: _selectedIndex != 3
          ? AppBar(
              title: Text(_titles[_selectedIndex]),
              centerTitle: true,
            )
          : null, // Tidak ada AppBar di laporan tab

      drawer: const DrawerVesparioFinal(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColorsFinal.mintGreen,
        unselectedItemColor: AppColorsFinal.mediumGray,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: "Service",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Riwayat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Laporan",
          ),
        ],
      ),
    );
  }
}

class HomeContentFinal extends StatefulWidget {
  const HomeContentFinal({super.key});

  @override
  State<HomeContentFinal> createState() => _HomeContentFinalState();
}

class _HomeContentFinalState extends State<HomeContentFinal> {
  String userName = "";

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    final name = await SharedPreferenceFinal.getUserName();
    setState(() {
      userName = name ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColorsFinal.mintGreen, AppColorsFinal.darkMint],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.motorcycle,
                      color: AppColorsFinal.white,
                      size: 30,
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Selamat Datang di Vespario",
                      style: TextStyle(
                        color: AppColorsFinal.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  userName,
                  style: const TextStyle(
                    color: AppColorsFinal.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Book. Fix. Ride. - Solusi lengkap untuk servis Vespa anda",
                  style: TextStyle(
                    color: AppColorsFinal.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    context.push(const BookingFormScreenFinal());
                  },
                  icon: const Icon(Icons.add, color: AppColorsFinal.mintGreen),
                  label: const Text(
                    "Booking Service Sekarang",
                    style: TextStyle(color: AppColorsFinal.mintGreen),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColorsFinal.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Quick Menu Title
          const Text(
            "Menu Cepat",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColorsFinal.darkGray,
            ),
          ),

          const SizedBox(height: 16),

          // Quick Menu Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0,
            children: [
              _buildMenuCard(
                icon: Icons.calendar_today,
                title: "Booking",
                subtitle: "Buat janji servis",
                color: AppColorsFinal.mintGreen,
                onTap: () {
                  context.push(const BookingFormScreenFinal());
                },
              ),
              _buildMenuCard(
                icon: Icons.list_alt,
                title: "Daftar Booking",
                subtitle: "Lihat appointment",
                color: AppColorsFinal.orange,
                onTap: () {
                  context.push(const BookingListScreenFinal());
                },
              ),
              _buildMenuCard(
                icon: Icons.build,
                title: "Kelola Service",
                subtitle: "Manage servis",
                color: AppColorsFinal.infoBlue,
                onTap: () {
                  context.push(const ServiceListScreenFinal());
                },
              ),
              _buildMenuCard(
                icon: Icons.history,
                title: "Riwayat",
                subtitle: "Lihat riwayat",
                color: AppColorsFinal.successGreen,
                onTap: () {
                  context.push(const ServiceHistoryScreenFinal());
                },
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Services Info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColorsFinal.lightMint,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: AppColorsFinal.mintGreen.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Layanan Vespario",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColorsFinal.darkGray,
                  ),
                ),
                const SizedBox(height: 12),
                _buildServiceInfo(
                    Icons.check_circle, "Service rutin dan berkala"),
                _buildServiceInfo(
                    Icons.check_circle, "Perbaikan mesin dan body"),
                _buildServiceInfo(Icons.check_circle, "Penggantian spare part"),
                _buildServiceInfo(Icons.check_circle, "Konsultasi gratis"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColorsFinal.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 24,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
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

  Widget _buildServiceInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColorsFinal.mintGreen,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: AppColorsFinal.darkGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
