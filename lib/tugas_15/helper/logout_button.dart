import 'package:flutter/material.dart';
import 'package:flutter_application_1/tugas_15/Screens/login_screen.dart';
import 'package:flutter_application_1/tugas_15/api/auth_api.dart';
import 'package:flutter_application_1/tugas_15/extention/navigation.dart';
import 'package:flutter_application_1/tugas_15/preference/shared_preference.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        // Show confirmation dialog
        bool? confirm = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color.fromARGB(255, 228, 97, 97),
            title: const Text("Konfirmasi"),
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            content: const Text("Apakah Anda yakin ingin keluar?"),
            contentTextStyle: const TextStyle(color: Colors.white),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  "Batal",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Keluar"),
              ),
            ],
          ),
        );
        if (confirm == true) {
          try {
            // Call logout API
            await AuthAPI.logout();
          } catch (e) {
            print("Logout error: $e");
          } finally {
            // Clear local storage
            PreferenceHandler.clearAll();
            // Navigate to login
            context.pushAndRemoveAll(const LoginScreen());
          }
        }
      },
      icon: const Icon(Icons.logout),
      label: const Text("Keluar"),
      backgroundColor: const Color.fromARGB(255, 219, 141, 136),
    );
  }
}
