import 'package:flutter/material.dart';
import 'package:flutter_application_1/origin_app_log_1/helpers/auth_prefs.dart';

class SettingsScreenSatu extends StatefulWidget {
  const SettingsScreenSatu({super.key});

  @override
  State<SettingsScreenSatu> createState() => _SettingsScreenSatuState();
}

class _SettingsScreenSatuState extends State<SettingsScreenSatu> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _locationEnabled = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blue[700],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(
                    Icons.settings,
                    size: 80,
                    color: Colors.blue[700],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Manage your app preferences',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                'GENERAL',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                  letterSpacing: 1,
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text('Enable Notifications'),
                    subtitle: Text('Receive push notifications'),
                    secondary:
                        Icon(Icons.notifications, color: Colors.blue[700]),
                    value: _notificationsEnabled,
                    activeColor: Colors.blue[700],
                    onChanged: (bool value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                  Divider(height: 1),
                  SwitchListTile(
                    title: Text('Dark Mode'),
                    subtitle: Text('Switch to dark theme'),
                    secondary: Icon(Icons.dark_mode, color: Colors.blue[700]),
                    value: _darkModeEnabled,
                    activeColor: Colors.blue[700],
                    onChanged: (bool value) {
                      setState(() {
                        _darkModeEnabled = value;
                      });
                    },
                  ),
                  Divider(height: 1),
                  SwitchListTile(
                    title: Text('Location Services'),
                    subtitle: Text('Allow access to your location'),
                    secondary: Icon(Icons.location_on, color: Colors.blue[700]),
                    value: _locationEnabled,
                    activeColor: Colors.blue[700],
                    onChanged: (bool value) {
                      setState(() {
                        _locationEnabled = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                'PREFERENCES',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                  letterSpacing: 1,
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Language'),
                    subtitle: Text(_selectedLanguage),
                    leading: Icon(Icons.language, color: Colors.blue[700]),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      _showLanguageDialog();
                    },
                  ),
                  Divider(height: 1),
                  ListTile(
                    title: Text('Privacy Policy'),
                    leading: Icon(Icons.privacy_tip, color: Colors.blue[700]),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Privacy Policy page coming soon!'),
                          backgroundColor: Colors.blue[700],
                        ),
                      );
                    },
                  ),
                  Divider(height: 1),
                  ListTile(
                    title: Text('Terms of Service'),
                    leading: Icon(Icons.description, color: Colors.blue[700]),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Terms of Service page coming soon!'),
                          backgroundColor: Colors.blue[700],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Cache cleared successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    icon: Icon(Icons.delete_outline),
                    label: Text('Clear Cache'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      side: BorderSide(color: Colors.orange),
                      foregroundColor: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Logout'),
                            content: Text('Are you sure you want to logout?'),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Logout'),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  await AuthPrefsSatu.logout();
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.logout, color: Colors.red),
                    label: Text('Logout', style: TextStyle(color: Colors.red)),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      side: BorderSide(color: Colors.red),
                      foregroundColor: Colors.red,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text('English'),
                value: 'English',
                groupValue: _selectedLanguage,
                activeColor: Colors.blue[700],
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: Text('Español'),
                value: 'Español',
                groupValue: _selectedLanguage,
                activeColor: Colors.blue[700],
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: Text('Français'),
                value: 'Français',
                groupValue: _selectedLanguage,
                activeColor: Colors.blue[700],
                onChanged: (String? value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
