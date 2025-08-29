import 'package:flutter/material.dart';
import 'package:flutter_application_1/tugas_15/Screens/edit_profile_screen.dart';
import 'package:flutter_application_1/tugas_15/api/auth_api.dart';
import 'package:flutter_application_1/tugas_15/extention/navigation.dart';
import 'package:flutter_application_1/tugas_15/models/get_user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<GetUserModel>? _profileFuture;
  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    setState(() {
      _profileFuture = AuthAPI.getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              context.push(const EditProfileScreen()).then((_) {
                _loadProfile(); // Reload profile after editing
              });
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: FutureBuilder<GetUserModel>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error,
                    size: 60,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Error: ${snapshot.error}",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadProfile,
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data?.data == null) {
            return const Center(
              child: Text("No data available"),
            );
          }
          final user = snapshot.data!.data!;
          return RefreshIndicator(
            onRefresh: () async {
              _loadProfile();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blue,
                          width: 3,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      user.name ?? "No Name",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.email ?? "No Email",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildInfoCard(
                      icon: Icons.badge,
                      title: "User ID",
                      value: user.id?.toString() ?? "-",
                    ),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      icon: Icons.person,
                      title: "Name",
                      value: user.name ?? "-",
                    ),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      icon: Icons.email,
                      title: "Email",
                      value: user.email ?? "-",
                    ),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      icon: Icons.calendar_today,
                      title: "Created At",
                      value: _formatDate(user.createdAt),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      icon: Icons.update,
                      title: "Updated At",
                      value: _formatDate(user.updatedAt),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      icon: Icons.verified,
                      title: "Email Verified",
                      value: user.emailVerifiedAt != null ? "Yes" : "No",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return "-";
    try {
      final date = DateTime.parse(dateStr);
      return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
    } catch (e) {
      return dateStr;
    }
  }
}
