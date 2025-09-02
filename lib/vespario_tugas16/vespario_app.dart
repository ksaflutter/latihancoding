import 'package:flutter/material.dart';
import 'package:flutter_application_1/vespario_tugas16/theme/app_theme.dart';
import 'package:flutter_application_1/vespario_tugas16/views/auth/login_screen.dart';
import 'package:flutter_application_1/vespario_tugas16/views/auth/register_screen.dart';
import 'package:flutter_application_1/vespario_tugas16/views/home/home_screen.dart';
import 'package:flutter_application_1/vespario_tugas16/views/profile/profile_screen.dart';
import 'package:flutter_application_1/vespario_tugas16/views/service/booking_form_screen.dart';
import 'package:flutter_application_1/vespario_tugas16/views/service/service_history_screen.dart';
import 'package:flutter_application_1/vespario_tugas16/views/service/service_list_screen.dart';
import 'package:flutter_application_1/vespario_tugas16/views/service/service_report_screen.dart';
import 'package:flutter_application_1/vespario_tugas16/views/splash/splash_screen.dart';

class VesparioApp extends StatelessWidget {
  const VesparioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Vespario App - Book. Fix. Ride.",
      debugShowCheckedModeBanner: false,
      theme: AppThemeFinal.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreenFinal(),
        '/login': (context) => const LoginScreenFinal(),
        '/register': (context) => const RegisterScreenFinal(),
        '/home': (context) => const HomeScreenFinal(),
        '/booking': (context) => const BookingFormScreenFinal(),
        '/service': (context) => const ServiceListScreenFinal(),
        '/history': (context) => const ServiceHistoryScreenFinal(),
        '/report': (context) => const ServiceReportScreenFinal(),
        '/profile': (context) => const ProfileScreenFinal(),
      },
    );
  }
}
