import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user profile and personal info.dart';
import 'package:project_emergio/Views/Auth%20Screens/login.dart'; // Ensure this import is correct

class ProfileController extends GetxController {
  var profileImageUrl = Rxn<String>();
  var firstName = ''.obs;
  var phoneNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    UserProfileAndImage? profile = await UserProfile.fetchUserProfileData();
    if (profile != null) {
      firstName.value = profile.profile.firstName;
      profileImageUrl.value = profile.image?.image; // URL from profile data
      phoneNumber.value = profile.profile.username;
    }
  }

  void updateProfileImage(String newImageUrl) {
    profileImageUrl.value = newImageUrl;
  }

  Future<void> showLogoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Lottie.asset(
                  'assets/logout_confirmation.json',
                  height: 40.h,
                  width: 60.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 30.h),
              Text('Confirm Logout',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
              SizedBox(height: 10.h),
              Text('Are you sure you want to log out?'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await logout(); // Call the logout method
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> logout() async {
    // Create an instance of FlutterSecureStorage
    final FlutterSecureStorage storage = FlutterSecureStorage();

    // Remove the token from Flutter Secure Storage
    await storage.delete(key: 'token');

    // Sign out from Google
    await GoogleSignIn().signOut();

    // Navigate to SignInPage
    Get.offAll(() => SignInPage());
  }
}
