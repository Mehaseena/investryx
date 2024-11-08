import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_emergio/Views/profile%20page.dart';
import 'package:project_emergio/services/contact%20us.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  String? successMessage;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: firstNameController,
            decoration: InputDecoration(labelText: 'First Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              final namePattern = RegExp(r'^[a-zA-Z\s]{1,20}$');
              if (!namePattern.hasMatch(value)) {
                return 'First name must be alphabetic and up to 20 characters only';
              }
              return null;
            },
          ),
          TextFormField(
            controller: lastNameController,
            decoration: InputDecoration(labelText: 'Last Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              final namePattern = RegExp(r'^[a-zA-Z\s]{1,20}$');
              if (!namePattern.hasMatch(value)) {
                return 'Last name must be alphabetic and up to 20 characters only';
              }
              return null;
            },
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailPattern.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(labelText: 'Phone Number'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              final phonePattern = RegExp(r'^\d{10}$');
              if (!phonePattern.hasMatch(value)) {
                return 'Phone number must be 10 digits';
              }
              return null;
            },
          ),
          TextFormField(
            controller: messageController,
            decoration: InputDecoration(labelText: 'Write your message..'),
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your message';
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          SizedBox(
            height: h * 0.055,
            width: w * 0.9,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Color(0xff003C82),
              ),
              onPressed: isLoading
                  ? null
                  : () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  bool? response = await ContactUs.contactUs(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      message: messageController.text);
                  setState(() {
                    isLoading = false;
                  });
                  if (response == true) {
                    Get.snackbar(
                      'Success',
                      'Message sent successfully',
                      backgroundColor: Colors.black54,
                      duration: Duration(seconds: 2),
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      borderRadius: 8,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(milliseconds: 800),
                        content: Text('Failed to send'),
                      ),
                    );
                  }
                }
              },
              child: isLoading
                  ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                  : Text(
                'Send Message',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16),
          if (successMessage != null)
            Text(
              successMessage!,
              style: TextStyle(color: Colors.green),
            ),
        ],
      ),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Back'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Any question or remarks?\nJust write us a message!',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Contact Information',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Say something to start a live chat!',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  ContactInfoRow(
                    icon: Icons.phone,
                    text: '+91 7594088814',
                    onTap: () => _launchUrl('tel:+917594088814'),
                  ),
                  ContactInfoRow(
                    icon: Icons.email,
                    text: 'hr@emergiotech.com',
                    onTap: () => _launchUrl('mailto:hr@emergiotech.com'),
                  ),
                  ContactInfoRow(
                    icon: Icons.location_on,
                    text: '9th Floor, Noel Focus,\nSeaport - Airport Rd, CSEZ,\nChattenkurussi, Kochi,\nKerala 682037',
                    onTap: () => _launchUrl('https://maps.app.goo.gl/e9pjbWkpavLuJ48e6'),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialIcon(
                        FontAwesomeIcons.facebook,
                        onTap: () => _launchUrl('https://www.facebook.com/emergiogames/'),
                      ),
                      SocialIcon(
                        FontAwesomeIcons.instagram,
                        onTap: () => _launchUrl('https://www.instagram.com/emergio.games/'),
                      ),
                      SocialIcon(
                        FontAwesomeIcons.google,
                        onTap: () => _launchUrl('https://www.emergiogames.com/'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            ContactForm(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  ContactInfoRow({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            SizedBox(width: 16),
            Text(text, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  SocialIcon(this.icon, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}