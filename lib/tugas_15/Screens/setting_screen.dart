import 'package:flutter/material.dart';
import 'package:flutter_application_1/tugas_15/preference/shared_preference.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final darkMode = await PreferenceHandler.getDarkMode();
    final notifications = await PreferenceHandler.getNotifications();
    setState(() {
      _darkMode = darkMode;
      _notifications = notifications;
    });
  }

  Future<void> _toggleDarkMode(bool value) async {
    setState(() {
      _darkMode = value;
    });
    await PreferenceHandler.setDarkMode(value);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(value ? 'Dark mode enabled' : 'Dark mode disabled'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _toggleNotifications(bool value) async {
    setState(() {
      _notifications = value;
    });
    await PreferenceHandler.setNotifications(value);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(value ? 'Notifications enabled' : 'Notifications disabled'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Preferences',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Enable dark theme'),
                  secondary: Icon(
                    _darkMode ? Icons.dark_mode : Icons.light_mode,
                    color: _darkMode ? Colors.amber : Colors.blue,
                  ),
                  value: _darkMode,
                  onChanged: _toggleDarkMode,
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('Notifications'),
                  subtitle: const Text('Receive app notifications'),
                  secondary: Icon(
                    _notifications
                        ? Icons.notifications_active
                        : Icons.notifications_off,
                    color: _notifications ? Colors.blue : Colors.grey,
                  ),
                  value: _notifications,
                  onChanged: _toggleNotifications,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'About',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('App Version'),
                  subtitle: const Text('1.0.0'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.code),
                  title: const Text('Developer'),
                  subtitle: const Text('PPKDJP Student'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('License'),
                  subtitle: const Text('NUGI License'),
                  textColor: const Color.fromARGB(255, 4, 50, 142),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Support',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Help & FAQ'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Help section coming soon!'),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: const Text('Contact Us'),
                  subtitle: const Text('support@studentapp.com'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Email: support@studentapp.com'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
