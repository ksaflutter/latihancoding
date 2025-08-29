import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_app_all_1/widgets/custom_button.dart';

import '../models/user.dart';
import '../services/db_helper.dart';
import '../services/shared_prefs_service.dart';
import 'login_screen.dart';

class ProfileScreenAll1 extends StatefulWidget {
  const ProfileScreenAll1({super.key});

  @override
  State<ProfileScreenAll1> createState() => _ProfileScreenAll1State();
}

class _ProfileScreenAll1State extends State<ProfileScreenAll1> {
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userId = await SharedPrefsServiceAll1.getCustomerId();
      if (userId != null) {
        final user = await DBHelperAll1.instance.getUserById(userId);
        setState(() {
          _user = user;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading profile: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await SharedPrefsServiceAll1.logout();

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreenAll1()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _user == null
              ? const Center(
                  child: Text('User data not found'),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _user!.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _user!.email,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              _buildProfileItem(
                                icon: Icons.person_outline,
                                label: 'Full Name',
                                value: _user!.name,
                              ),
                              const Divider(),
                              _buildProfileItem(
                                icon: Icons.email_outlined,
                                label: 'Email',
                                value: _user!.email,
                              ),
                              const Divider(),
                              _buildProfileItem(
                                icon: Icons.calendar_today,
                                label: 'Member Since',
                                value:
                                    '${_user!.createdAt.day}/${_user!.createdAt.month}/${_user!.createdAt.year}',
                              ),
                              const Divider(),
                              _buildProfileItem(
                                icon: Icons.key,
                                label: 'User ID',
                                value: '#${_user!.id}',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        text: 'Logout',
                        onPressed: _logout,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
