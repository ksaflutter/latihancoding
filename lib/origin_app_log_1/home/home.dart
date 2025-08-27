import 'package:flutter/material.dart';
import 'package:flutter_application_1/origin_app_log_1/helpers/auth_prefs.dart';
import 'package:flutter_application_1/origin_app_log_1/helpers/db_helpers.dart';
import 'package:flutter_application_1/origin_app_log_1/screens/hal_utama_screen.dart';
import 'package:flutter_application_1/origin_app_log_1/screens/login_screen.dart';
import 'package:flutter_application_1/origin_app_log_1/screens/profile_screen.dart';
import 'package:flutter_application_1/origin_app_log_1/screens/register_screen.dart';
import 'package:flutter_application_1/origin_app_log_1/screens/settings_screen.dart';
import 'package:flutter_application_1/origin_app_log_1/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database - FIXED
  await DatabaseHelperSatu().instance.database;

  runApp(OriginLogSatu());
}

class OriginLogSatu extends StatelessWidget {
  const OriginLogSatu({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue[700],
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
      ).copyWith(
        secondary: Colors.blueAccent,
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.grey[50],
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        labelStyle: TextStyle(color: Colors.grey[600]),
        hintStyle: TextStyle(color: Colors.grey[400]),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 50),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue[700],
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
      ),
    );
    CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Real Auth App',
      theme: appTheme,
      home: AuthChecker(),
      routes: {
        '/welcome': (context) => WelcomeScreenSatu(),
        '/login': (context) => LoginScreenSatu(),
        '/register': (context) => RegisterScreenSatu(),
        '/hal_utama': (context) => HalUtamaScreenSatu(),
        '/profile': (context) => ProfileScreenSatu(),
        '/settings': (context) => SettingsScreenSatu(),
      },
    );
  }
}

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  _AuthCheckerState createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    // Check if user is already logged in and session is valid
    bool isLoggedIn = await AuthPrefsSatu.isLoggedIn();
    bool isSessionValid = await AuthPrefsSatu.isSessionValid();

    if (isLoggedIn && isSessionValid) {
      // User is logged in and session is valid, go to main screen
      Navigator.pushReplacementNamed(context, '/hal_utama');
    } else {
      if (isLoggedIn && !isSessionValid) {
        // Session expired, logout user
        await AuthPrefsSatu.logout();
      }
      // Show welcome screen
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
