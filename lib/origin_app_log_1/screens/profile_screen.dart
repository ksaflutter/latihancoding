import 'package:flutter/material.dart';
import 'package:flutter_application_1/origin_app_log_1/helpers/auth_prefs.dart';

class ProfileScreenSatu extends StatefulWidget {
  const ProfileScreenSatu({super.key});

  @override
  State<ProfileScreenSatu> createState() => _ProfileScreenSatuState();
}

class _ProfileScreenSatuState extends State<ProfileScreenSatu> {
  String _userName = 'Loading...';
  String _userEmail = 'Loading...';
  DateTime? _loginTime;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    String? name = await AuthPrefsSatu.getUserName();
    String? email = await AuthPrefsSatu.getUserEmail();
    DateTime? loginTime = await AuthPrefsSatu.getLoginTime();

    setState(() {
      _userName = name ?? 'User';
      _userEmail = email ?? 'user@example.com';
      _loginTime = loginTime;
    });
  }

  String _formatLoginTime() {
    if (_loginTime == null) return 'Unknown';

    DateTime now = DateTime.now();
    Duration difference = now.difference(_loginTime!);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue[700],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue[700],
              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              _userName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'User Profile Information',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildProfileItem(Icons.person, 'Name', _userName),
                    Divider(),
                    _buildProfileItem(Icons.email, 'Email', _userEmail),
                    Divider(),
                    _buildProfileItem(
                        Icons.access_time, 'Last Login', _formatLoginTime()),
                    Divider(),
                    _buildProfileItem(
                        Icons.verified_user, 'Account Status', 'Active'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Edit profile feature coming soon!'),
                    backgroundColor: Colors.blue[700],
                  ),
                );
              },
              icon: Icon(Icons.edit),
              label: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () async {
                await AuthPrefsSatu.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: Icon(Icons.logout, color: Colors.red),
              label: Text('Logout', style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                side: BorderSide(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[700], size: 24),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
