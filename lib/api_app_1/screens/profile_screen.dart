// import 'package:flutter/material.dart';
// import '../models/user.dart';
// import '../services/db_helper.dart';
// import '../services/shared_prefs_service.dart';
// import 'login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_app_1/models/user.dart';
import 'package:flutter_application_1/api_app_1/screens/login_screen.dart';
import 'package:flutter_application_1/api_app_1/services/db_helper.dart';
import 'package:flutter_application_1/api_app_1/services/shared_prefs_service.dart';

class ProfileScreenApi1 extends StatefulWidget {
  const ProfileScreenApi1({super.key});

  @override
  State<ProfileScreenApi1> createState() => _ProfileScreenApi1State();
}

class _ProfileScreenApi1State extends State<ProfileScreenApi1> {
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final userId = await SharedPrefsServiceApi1.getUserId();
    if (userId != null) {
      final user = await DBHelperApi1.instance.getUserById(userId);
      setState(() {
        _user = user;
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    await SharedPrefsServiceApi1.logout();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreenApi1()),
        (route) => false,
      );
    }
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'Student':
        return Colors.blue;
      case 'Employee':
        return Colors.green;
      case 'Teacher':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getRoleIcon(String role) {
    switch (role) {
      case 'Student':
        return Icons.school;
      case 'Employee':
        return Icons.work;
      case 'Teacher':
        return Icons.person;
      default:
        return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_user == null) {
      return const Center(child: Text('User not found'));
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: _getRoleColor(_user!.role),
                child: Icon(
                  _getRoleIcon(_user!.role),
                  size: 70,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                _user!.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _getRoleColor(_user!.role).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _user!.role,
                  style: TextStyle(
                    fontSize: 16,
                    color: _getRoleColor(_user!.role),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.email, color: Colors.blue),
                  title: const Text('Email'),
                  subtitle: Text(_user!.email),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.blue),
                  title: const Text('Full Name'),
                  subtitle: Text(_user!.name),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  leading: Icon(_getRoleIcon(_user!.role),
                      color: _getRoleColor(_user!.role)),
                  title: const Text('Role'),
                  subtitle: Text(_user!.role),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Logout'),
                          content:
                              const Text('Are you sure you want to logout?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _logout();
                              },
                              child: const Text(
                                'Logout',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
