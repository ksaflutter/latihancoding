import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_app_1/screens/settings_screen.dart';
import 'package:flutter_application_1/api_app_all_1/screens/api_characters_screen.dart';
import 'package:flutter_application_1/api_app_all_1/screens/biodata_form_screen.dart';
import 'package:flutter_application_1/api_app_all_1/screens/biodata_list_screen.dart';
import 'package:flutter_application_1/api_app_all_1/screens/login_screen.dart';
import 'package:flutter_application_1/api_app_all_1/screens/profile_screen.dart';
import 'package:flutter_application_1/api_app_all_1/services/shared_prefs_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Biodata Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreenAll1(),
    );
  }
}

class SplashScreenAll1 extends StatefulWidget {
  const SplashScreenAll1({super.key});

  @override
  State<SplashScreenAll1> createState() => _SplashScreenAll1State();
}

class _SplashScreenAll1State extends State<SplashScreenAll1> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final isLoggedIn = await SharedPrefsServiceAll1.getLoginStatus();

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isLoggedIn ? const HomeScreenAll1() : const LoginScreenAll1(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'Student Biodata',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenAll1 extends StatefulWidget {
  const HomeScreenAll1({super.key});

  @override
  State<HomeScreenAll1> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenAll1> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const BiodataFormScreenAll1(),
    const BiodataListScreenAll1(),
  ];

  final List<String> _titles = [
    'Biodata Form',
    'Biodata List',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 80,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Student Management',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreenAll1(),
                  ),
                );
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
                    builder: (context) => const SettingsScreenApi1(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.api),
              title: const Text('API Characters'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ApiCharactersScreenAll1(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Form',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
        ],
      ),
    );
  }
}
