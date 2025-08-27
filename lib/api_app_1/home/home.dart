import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_app_1/screens/attendance_screen.dart';
import 'package:flutter_application_1/api_app_1/screens/login_screen.dart';
import 'package:flutter_application_1/api_app_1/screens/profile_screen.dart';
import 'package:flutter_application_1/api_app_1/screens/report_screen.dart';
import 'package:flutter_application_1/api_app_1/screens/settings_screen.dart';
import 'package:flutter_application_1/api_app_1/services/db_helper.dart';
import 'package:flutter_application_1/api_app_1/services/shared_prefs_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelperApi1.instance.database; // Initialize database
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreenApi1(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreenApi1 extends StatefulWidget {
  const SplashScreenApi1({super.key});

  @override
  State<SplashScreenApi1> createState() => _SplashScreenApi1State();
}

class _SplashScreenApi1State extends State<SplashScreenApi1> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await SharedPrefsServiceApi1.isLoggedIn();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isLoggedIn ? const HomeScreenApi1() : const LoginScreenApi1(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.access_time, size: 80, color: Colors.blue),
            SizedBox(height: 20),
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Loading Attendance App...', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class HomeScreenApi1 extends StatefulWidget {
  const HomeScreenApi1({super.key});

  @override
  State<HomeScreenApi1> createState() => _HomeScreenApi1State();
}

class _HomeScreenApi1State extends State<HomeScreenApi1> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const AttendanceScreenApi1(),
    const ReportScreenApi1(),
    const ProfileScreenApi1(),
  ];

  final List<String> _titles = [
    'Attendance',
    'Report',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time, size: 60, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Attendance App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreenApi1()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: 'Attendance App',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(Icons.access_time),
                  children: const [
                    Text(
                        'A simple attendance management app built with Flutter.'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
