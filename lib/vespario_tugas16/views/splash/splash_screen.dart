import 'package:flutter/material.dart';
import 'package:flutter_application_1/vespario_tugas16/extension/navigation.dart';
import 'package:flutter_application_1/vespario_tugas16/preference/shared_preference.dart';
import 'package:flutter_application_1/vespario_tugas16/theme/app_colors.dart';
import 'package:flutter_application_1/vespario_tugas16/views/auth/login_screen.dart';
import 'package:flutter_application_1/vespario_tugas16/views/home/home_screen.dart';

class SplashScreenFinal extends StatefulWidget {
  const SplashScreenFinal({super.key});

  @override
  State<SplashScreenFinal> createState() => _SplashScreenFinalState();
}

class _SplashScreenFinalState extends State<SplashScreenFinal> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    // Simulate loading time
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    bool isLoggedIn = await SharedPreferenceFinal.isLoggedIn();

    if (isLoggedIn) {
      context.pushAndRemoveAll(const HomeScreenFinal());
    } else {
      context.pushAndRemoveAll(const LoginScreenFinal());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColorsFinal.primaryGradient,
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Vespa Icon
              Icon(
                Icons.motorcycle,
                size: 120,
                color: AppColorsFinal.white,
              ),
              SizedBox(height: 24),

              // App Name
              Text(
                "Vespario",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColorsFinal.white,
                  letterSpacing: 2,
                ),
              ),

              SizedBox(height: 12),

              // Slogan
              Text(
                "Book. Fix. Ride.",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColorsFinal.white,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.2,
                ),
              ),

              SizedBox(height: 40),

              // Loading Indicator
              CircularProgressIndicator(
                color: AppColorsFinal.white,
                strokeWidth: 3,
              ),

              SizedBox(height: 20),

              Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColorsFinal.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
