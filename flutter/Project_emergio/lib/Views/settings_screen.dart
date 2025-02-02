import 'package:flutter/material.dart';
import 'package:project_emergio/Views/FAQ%20page.dart';
import 'package:project_emergio/Views/contact%20us%20page.dart';
import 'package:project_emergio/Views/manage%20profile%20screen.dart';
import 'package:project_emergio/Views/pricing%20screen.dart';
import 'package:project_emergio/Views/tutorial%20page.dart';

import 'Auth Screens/ForgotPassword/change password.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Settings'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        actions: const [Icon(Icons.notifications)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Account Section
              const ListTile(
                leading: Icon(Icons.person, color: Colors.black),
                title: Text(
                  'Account',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              _buildSettingsOption(
                'Manage Profile',
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManageProfileScreen()));
                },
              ),
              _buildSettingsOption(
                'Change Password',
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen(phoneNumber: '',)));
                },
              ),
              // _buildSettingsOption(
              //   'Feedback',
              //       () {
              //     // Navigate to Feedback screen
              //   },
              // ),
              const SizedBox(height: 16),

              // Notifications Section
              const ListTile(
                leading: Icon(Icons.notifications, color: Colors.black),
                title: Text(
                  'Notifications',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SwitchListTile(
                title: const Text('Notifications'),
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
                activeColor: const Color(0xffFFCC00),
              ),
              const SizedBox(height: 16),

              // Others Section
              const ListTile(
                leading: Icon(Icons.more_horiz, color: Colors.black),
                title: Text(
                  'Others',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              _buildSettingsOption(
                'Pricings',
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PricingPage()));
                },
              ),
              _buildSettingsOption(
                'Contact Us',
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  ContactUsPage()));
                },
              ),
              _buildSettingsOption(
                'Tutorial',
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TutorialsScreen()));
                },
              ),
              _buildSettingsOption(
                'Suggestions',
                    () {
                  // Navigate to Feedback screen
                },
              ),
              _buildSettingsOption(
                'FAQ',
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FaqScreen()));
                },
              ),
              const SizedBox(height: 16),


            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build settings option
  Widget _buildSettingsOption(String title, VoidCallback onPressed) {
    return ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onPressed,
        );
    }
}
