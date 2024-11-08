import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import flutter_secure_storage
import 'dart:async';
import '../../Widgets/bottom navbar_widget.dart';
import '../Auth Screens/Questionnare/reg_successfull.dart';
import '../On-board Screens/on-board1.dart';
import 'onboarding_flow.dart'; // Adjust the import path if necessary


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Create an instance of FlutterSecureStorage
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    // Retrieve the token from secure storage
    String? token = await _storage.read(key: 'token');

    if (token != null && token.isNotEmpty) {
      // Token exists, navigate to HomeScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => CustomBottomNavBar(), // Replace with your actual home screen widget
        ),
      );
    } else {
      // No token found, navigate to OnBoardingScreen1
      navigateToOnBoardingScreen();
    }
  }

  void navigateToOnBoardingScreen() {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => OnboardingFlow(), // Adjust the import path if necessary
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
            height: 160,
            width: 200,
            child: Image.asset('assets/newlogo.png')),
      ),
    );
  }
}
