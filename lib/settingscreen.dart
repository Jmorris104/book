import 'package:flutter/material.dart';

void main() => runApp(SettingsApp());

class SettingsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          // Profile Management Section
          ListTile(
            leading: Icon(Icons.person, color: Colors.blue),
            title: Text('Profile Management'),
            subtitle: Text('Update your profile details'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToProfileScreen(context),
          ),
          Divider(),

          // Notification Settings Section
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.blue),
            title: Text('Notification Settings'),
            subtitle: Text('Manage push notifications'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => navigateToNotificationSettings(context),
          ),
          Divider(),

          // Log Out Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () => showLogoutConfirmation(context),
              icon: Icon(Icons.logout),
              label: Text('Log Out', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToProfileScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }

  void navigateToNotificationSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationSettingsScreen()),
    );
  }

  void showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Log Out'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Perform log out actions here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logged out successfully')),
              );
            },
            child: Text('Log Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Management'),
      ),
      body: Center(
        child: Text(
          'Profile management screen (e.g., name, email, etc.)',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool emailNotifications = true;
  bool pushNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Email Notifications'),
            subtitle: Text('Receive updates via email'),
            value: emailNotifications,
            onChanged: (value) {
              setState(() {
                emailNotifications = value;
              });
            },
          ),
          Divider(),
          SwitchListTile(
            title: Text('Push Notifications'),
            subtitle: Text('Receive updates via push notifications'),
            value: pushNotifications,
            onChanged: (value) {
              setState(() {
                pushNotifications = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
