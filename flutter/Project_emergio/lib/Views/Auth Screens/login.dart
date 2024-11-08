// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:project_emergio/Views/Auth%20Screens/ForgotPassword/forgot%20password.dart';
// import 'package:project_emergio/Views/Auth%20Screens/Questionnare/reg_successfull.dart';
// import 'package:project_emergio/Views/Auth%20Screens/register.dart';
// import 'package:project_emergio/Views/Home/home.dart';
// import 'package:project_emergio/services/social.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../Widgets/custom textfeild.dart';
// import '../../services/auth screens/signIn.dart';
//
// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});
//
//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }
//
// class _SignInPageState extends State<SignInPage> {
//   final phoneNumberController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _obscureText = true;
//
//   Future<void> saveCredentials(
//       String phoneNumber,
//       String password,
//       ) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('phoneNumber', phoneNumber);
//     await prefs.setString('password', password);
//   }
//
//   String? _validatePhoneNumber(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Phone number is required';
//     } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//       return 'Enter a valid 10-digit phone number';
//     }
//     return null;
//   }
//
//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Password is required';
//     } else if (value.length < 6) {
//       return 'Password must be at least 6 characters long';
//     }
//     // Optional: Add more checks here (e.g., include at least one digit, etc.)
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               SizedBox(height: 110.h),
//               Center(
//                 child: SizedBox(
//                   height: 25.h,
//                   width: 100.w,
//                   child: Image.asset('assets/logo.jpg'),
//                 ),
//               ),
//               SizedBox(height: 100.h),
//               Padding(
//                 padding: EdgeInsets.only(left: 25.w, bottom: 8.h),
//                 child: Text('Phone Number', style: TextStyle(fontSize: 15.sp)),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 child: CustomTextFormField(
//                   controller: phoneNumberController,
//                   decoration: InputDecoration(border: OutlineInputBorder()),
//                   validator: _validatePhoneNumber,
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Padding(
//                 padding: EdgeInsets.only(left: 25.w, bottom: 8.h),
//                 child: Text('Password', style: TextStyle(fontSize: 15.sp)),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 child: CustomTextFormField(
//                   controller: passwordController,
//                   obscureText: _obscureText,
//                   decoration: InputDecoration(
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscureText ? Icons.visibility_off : Icons.visibility,
//                         color: Colors.black54,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscureText = !_obscureText;
//                         });
//                       },
//                     ),
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: _validatePassword,
//                 ),
//               ),
//               SizedBox(height: 10.h),
//               Padding(
//                 padding: EdgeInsets.only(left: 230.w),
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => Forgot_passwordScreen()),
//                     );
//                   },
//                   child: Text(
//                     'Forgot Password?',
//                     style: TextStyle(
//                       fontSize: 13.sp,
//                       color: Color(0xff37498B),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 40.h),
//               Center(
//                 child: SizedBox(
//                   height: 45.h,
//                   width: 220.w,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xff37498B),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.r),
//                       ),
//                     ),
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         final phoneNumber = phoneNumberController.text.trim();
//                         final password = passwordController.text.trim();
//
//                         final response = await signIn(phoneNumber, password);
//
//                         if (response == true) {
//                           await saveCredentials(phoneNumber, password);
//                           print('Phone Number: $phoneNumber');
//                           print('Password: $password');
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => HomeScreen()),
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               duration: Duration(milliseconds: 800),
//                               content: Text(
//                                   'Invalid Credentials: Incorrect Username and Password'),
//                             ),
//                           );
//                         }
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             duration: Duration(milliseconds: 800),
//                             content: Text('All Fields Required*'),
//                           ),
//                         );
//                       }
//                     },
//                     child: Text('Submit',
//                         style: TextStyle(color: Colors.white, fontSize: 14.sp)),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 70.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       signInWithGoogle(context);
//                     },
//                     child: CircleAvatar(
//                       backgroundColor: Colors.grey[300],
//                       child: Icon(
//                         FontAwesomeIcons.google,
//                         color: Color(0xffEA4335),
//                         size: 15.h,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 40.w),
//                   CircleAvatar(
//                     backgroundColor: Colors.grey[300],
//                     child: Icon(
//                       Icons.facebook_outlined,
//                       color: Color(0xff1877F2),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 70.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Don’t have an account?',
//                     style: TextStyle(fontSize: 13.sp),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => SignUpScreen()),
//                       );
//                     },
//                     child: Text(
//                       'Sign Up',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 14.sp),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<User?> signInWithGoogle(BuildContext context) async {
//     try {
//       debugPrint("Sign-in process started");
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) {
//         debugPrint('Sign-in aborted by user');
//         return null;
//       }
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       final UserCredential userCredential =
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       final User? user = userCredential.user;
//       print('user details : $user');
//
//       if (user != null) {
//         String? email = user.email;
//
//         // Log the user details
//         debugPrint('Email: $email');
//
//         final response = await Social.google(email: user.email.toString());
//         if (response == true) {
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (context) => HomeScreen()));
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               duration: Duration(milliseconds: 800),
//               content: Text('User not registered'),
//             ),
//           );
//         }
//       }
//
//       return user;
//     } catch (e) {
//       debugPrint("Error occurred during sign-in: $e");
//       return null;
//     }
//   }
// }
//


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_emergio/Views/Auth%20Screens/ForgotPassword/forgot%20password.dart';
import 'package:project_emergio/Views/Auth%20Screens/register.dart';
import 'package:project_emergio/Views/Home/home.dart';
import 'package:project_emergio/services/social.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/bottom navbar_widget.dart';
import '../../Widgets/custom textfeild.dart';
import '../../services/auth screens/signIn.dart';
import 'Questionnare/reg_successfull.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // SizedBox(height: 20.h),
                    _buildHeaderSection(),
                    SizedBox(height: 35.h),
                    _buildTextField(
                      label: 'Phone Number',
                      controller: phoneNumberController,
                      validator: _validatePhoneNumber,
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icon(Icons.phone, color:Colors.grey[500], size: 18.r),
                    ),
                    SizedBox(height: 14.h),
                    _buildTextField(
                      label: 'Password',
                      controller: passwordController,
                      validator: _validatePassword,
                      obscureText: _obscureText,
                      prefixIcon: Icon(Icons.lock, color:Colors.grey[500], size: 18.r),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                          size: 18.r,
                        ),
                        onPressed: () => setState(() => _obscureText = !_obscureText),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Forgot_passwordScreen()),
                        ),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFFCC00),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.r),
                        ),
                      ),
                      onPressed: _handleSignIn,
                      child: Text(
                        'Sign In',
                        style: TextStyle(fontSize: 15.sp, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    _buildGoogleSignInSection(),
                    SizedBox(height: 50.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpScreen()),
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: Color(0xffFFCC00),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      children: [
        // Text.rich(
        //   TextSpan(
        //     children: [
        //       TextSpan(
        //         text: 'Inve',
        //         style: TextStyle(fontSize: 40.h, fontWeight: FontWeight.bold, color: Colors.black),
        //       ),
        //       TextSpan(
        //         text: 'Stry',
        //         style: TextStyle(fontSize: 40.h, fontWeight: FontWeight.bold, color: Color(0xffFFCC00)),
        //       ),
        //       TextSpan(
        //         text: 'x',
        //         style: TextStyle(fontSize: 40.h, fontWeight: FontWeight.bold, color: Colors.black),
        //       ),
        //     ],
        //   ),
        // ),
        SizedBox(height: 30.h),
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xffFFCC00),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Sign in to continue',
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscureText = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
        SizedBox(height: 6.h),
        CustomTextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.r),
              borderSide: BorderSide(color: Color(0xffFFCC00)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.r),
              borderSide: BorderSide(color: Color(0xffFFCC00)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.r),
              borderSide: BorderSide(color: Color(0xff37498B)),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          ),
          validator: validator,
          keyboardType: keyboardType,
        ),
      ],
    );
  }

  Widget _buildGoogleSignInSection() {
    return Column(
      children: [
        Text(
          'Or sign in with',
          style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
        ),
        SizedBox(height: 25.h),
        InkWell(
          onTap: () => signInWithGoogle(context),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffFFCC00)),
              borderRadius: BorderRadius.circular(7.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.google, color: Color(0xffEA4335), size: 20.r),
                SizedBox(width: 10.w),
                Text(
                  'Sign in with Google',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500,color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      final phoneNumber = phoneNumberController.text.trim();
      final password = passwordController.text.trim();

      final response = await signIn(phoneNumber, password);

      if (response == true) {
        await saveCredentials(phoneNumber, password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CustomBottomNavBar()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid Credentials: Incorrect Username and Password'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> saveCredentials(String phoneNumber, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phoneNumber);
    await prefs.setString('password', password);
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      // Sign out before signing in to force account selection
      await GoogleSignIn().signOut();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final response = await Social.google(email: user.email.toString());
        if (response == true) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomBottomNavBar()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User not registered'), duration: Duration(seconds: 2)),
          );
        }
      }

      return user;
    } catch (e) {
      print("Error during Google sign-in: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in with Google'), duration: Duration(seconds: 2)),
      );
      return null;
    }
  }
}