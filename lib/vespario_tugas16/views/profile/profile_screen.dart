import 'package:flutter/material.dart';
import 'package:flutter_application_1/vespario_tugas16/extension/navigation.dart';
import 'package:flutter_application_1/vespario_tugas16/preference/shared_preference.dart';
import 'package:flutter_application_1/vespario_tugas16/theme/app_colors.dart';
import 'package:flutter_application_1/vespario_tugas16/views/auth/login_screen.dart';

class ProfileScreenFinal extends StatefulWidget {
  const ProfileScreenFinal({super.key});

  @override
  State<ProfileScreenFinal> createState() => _ProfileScreenFinalState();
}

class _ProfileScreenFinalState extends State<ProfileScreenFinal> {
  String userName = "";
  String userEmail = "";
  int userId = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      final name = await SharedPreferenceFinal.getUserName();
      final email = await SharedPreferenceFinal.getUserEmail();
      final id = await SharedPreferenceFinal.getUserId();

      if (mounted) {
        setState(() {
          userName = name ?? "User";
          userEmail = email ?? "user@example.com";
          userId = id ?? 0;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> logout() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Konfirmasi Logout"),
          content: const Text("Apakah Anda yakin ingin keluar dari aplikasi?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColorsFinal.redAccent,
              ),
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );

    if (result == true) {
      try {
        await SharedPreferenceFinal.clearAll();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Logout berhasil"),
              backgroundColor: AppColorsFinal.successGreen,
            ),
          );
          context.pushAndRemoveAll(const LoginScreenFinal());
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error logout: ${e.toString()}"),
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
        title: const Text("Profil"),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColorsFinal.mintGreen,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: AppColorsFinal.primaryGradient,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        // Profile Avatar
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: AppColorsFinal.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: AppColorsFinal.mintGreen,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // User Info
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColorsFinal.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userEmail,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColorsFinal.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColorsFinal.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "ID: $userId",
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColorsFinal.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Profile Menu Items
                  const Text(
                    "Pengaturan Akun",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColorsFinal.darkGray,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Menu Items
                  _buildMenuItem(
                    icon: Icons.person_outline,
                    title: "Edit Profil",
                    subtitle: "Ubah nama dan informasi profil",
                    onTap: () => _showEditProfileDialog(),
                  ),
                  _buildMenuItem(
                    icon: Icons.security,
                    title: "Keamanan",
                    subtitle: "Ubah password dan keamanan akun",
                    onTap: () => _showSecurityDialog(),
                  ),
                  _buildMenuItem(
                    icon: Icons.notifications_outlined,
                    title: "Notifikasi",
                    subtitle: "Pengaturan notifikasi aplikasi",
                    onTap: () => _showNotificationSettings(),
                  ),
                  _buildMenuItem(
                    icon: Icons.help_outline,
                    title: "Bantuan",
                    subtitle: "FAQ dan pusat bantuan",
                    onTap: () => _showHelpDialog(),
                  ),
                  _buildMenuItem(
                    icon: Icons.info_outline,
                    title: "Tentang",
                    subtitle: "Informasi aplikasi Vespario",
                    onTap: () => _showAboutDialog(),
                  ),

                  const SizedBox(height: 32),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: logout,
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorsFinal.redAccent,
                        foregroundColor: AppColorsFinal.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // App Version
                  const Center(
                    child: Text(
                      "Vespario v1.0.0\nBook. Fix. Ride.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColorsFinal.mediumGray,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColorsFinal.mintGreen.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColorsFinal.mintGreen,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColorsFinal.darkGray,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: AppColorsFinal.mediumGray,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColorsFinal.mediumGray,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profil"),
          content: const Text(
            "Fitur edit profil akan segera tersedia.\nSaat ini profil dikelola melalui server.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showSecurityDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Keamanan"),
          content: const Text(
            "Fitur keamanan akan segera tersedia.\nUntuk mengubah password, silakan hubungi admin.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showNotificationSettings() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pengaturan Notifikasi"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text("Push Notifications"),
                trailing: Switch(value: true, onChanged: null),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text("Email Notifications"),
                trailing: Switch(value: false, onChanged: null),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Bantuan"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Frequently Asked Questions:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text("• Bagaimana cara booking service?"),
              Text("• Berapa lama waktu service?"),
              Text("• Apa saja jenis service yang tersedia?"),
              SizedBox(height: 16),
              Text(
                "Untuk bantuan lebih lanjut:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Email: support@vespario.com"),
              Text("Telepon: +62 812-3456-7890"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tentang Vespario"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.motorcycle, color: AppColorsFinal.mintGreen),
                  SizedBox(width: 8),
                  Text(
                    "Vespario",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColorsFinal.mintGreen,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text("Versi: 1.0.0"),
              SizedBox(height: 8),
              Text("Book. Fix. Ride."),
              SizedBox(height: 16),
              Text(
                "Vespario adalah aplikasi untuk memudahkan booking dan pengelolaan service Vespa. Dengan Vespario, Anda dapat:",
              ),
              SizedBox(height: 8),
              Text("• Booking service dengan mudah"),
              Text("• Melacak status service"),
              Text("• Melihat riwayat service"),
              Text("• Mendapatkan laporan analitik"),
              SizedBox(height: 16),
              Text(
                "Dikembangkan dengan ❤️ untuk penggemar Vespa",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: AppColorsFinal.mediumGray,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
