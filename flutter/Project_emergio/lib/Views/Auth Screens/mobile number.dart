// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:project_emergio/Views/Auth%20Screens/reg_otp%20verification.dart';
// import 'package:project_emergio/Views/Auth%20Screens/register.dart';
//
// import '../../Widgets/custom textfeild.dart';
// import '../../services/auth screens/registerOtp.dart';
//
// class MobileNumberScreen extends StatefulWidget {
//   final String? name;
//   final String? email;
//   final String? image;
//
//   const MobileNumberScreen({super.key, this.name, this.email, this.image});
//
//   @override
//   State<MobileNumberScreen> createState() => _MobileNumberScreenState();
// }
//
// class _MobileNumberScreenState extends State<MobileNumberScreen> {
//   final TextEditingController phonecntrl = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pushReplacement(
//                 context, MaterialPageRoute(builder: (context) => SignUpScreen()));
//           },
//           icon: Icon(
//             Icons.arrow_back_outlined,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               SizedBox(height: 140.h),
//               Center(
//                 child: Image.asset(
//                   'assets/logo.jpg',
//                   height: 25.h,
//                   width: 100.w,
//                 ),
//               ),
//               SizedBox(height: 100.h),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Please input your mobile number',
//                   style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(height: 50.h),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 18.w),
//                 child: CustomTextFormField(
//                   controller: phonecntrl,
//                   decoration: InputDecoration(
//                       hintText: 'Number', border: OutlineInputBorder()),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your phone number';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(height: 150.h),
//               SizedBox(
//                 height: 45.h,
//                 width: 220.w,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xff37498B),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.r),
//                     ),
//                   ),
//                   onPressed: () async {
//                     final phonePattern = RegExp(r'^[0-9]{10}$');
//                     if (!phonePattern.hasMatch(phonecntrl.text)) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           duration: Duration(milliseconds: 800),
//                           content: Text('Invalid Phone Number'),
//                         ),
//                       );
//                       return;
//                     } else {
//                      print(phonecntrl.text);
//                       print('Name: ${widget.name}');
//                       print('Email: ${widget.email}');
//                       print('Image: ${widget.image}');
//                      final String phoneNumber = phonecntrl.text;
//                      final response =
//                          await RegisterOtp.registerOtp(phone: phoneNumber, email: widget.email!);
//                      if (response == true) {
//                        Navigator.pushReplacement(
//                          context,
//                          MaterialPageRoute(
//                            builder: (context) => Reg_OTPVerificationScreen(
//                              phone: phoneNumber,
//                              image: widget.image,
//                              name: widget.name!,
//                              email: widget.email!,
//                              password: "",
//                              otp: '',
//                            ),
//                          ),
//                        );
//                      }
//                      else{
//                        ScaffoldMessenger.of(context).showSnackBar(
//                          SnackBar(
//                            duration: Duration(milliseconds: 800),
//                            content: Text('User with same phone number or email already exists'),
//                          ),
//                        );
//                      }
//                     }
//                   },
//                   child: Text('Submit',
//                       style: TextStyle(color: Colors.white, fontSize: 13.sp)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_emergio/Views/Auth%20Screens/reg_otp%20verification.dart';
import 'package:project_emergio/Views/Auth%20Screens/register.dart';
import '../../services/auth screens/registerOtp.dart';

class MobileNumberScreen extends StatefulWidget {
  final String? name;
  final String? email;
  final String? image;

  const MobileNumberScreen({super.key, this.name, this.email, this.image});

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Color(0xff37498B),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40.h),
                Text(
                  'Verify Your Number',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff37498B),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                Text(
                  'We\'ll send you a one-time verification code',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),
                _buildPhoneTextField(),
                SizedBox(height: 24.h),
                _buildSubmitButton(),
                Spacer(),
                _buildPrivacyNote(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneTextField() {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      style: TextStyle(fontSize: 16.sp),
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintText: 'Enter your phone number',
        prefixIcon: Icon(Icons.phone, color: Color(0xff37498B), size: 20.r),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Color(0xff37498B)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        final phonePattern = RegExp(r'^[0-9]{10}$');
        if (!phonePattern.hasMatch(value)) {
          return 'Enter a valid 10-digit phone number';
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff37498B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 14.h),
      ),
      onPressed: _handleSubmit,
      child: Text(
        'Send Verification Code',
        style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPrivacyNote() {
    return Text(
      'By continuing, you agree to our Terms of Service and Privacy Policy',
      style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
      textAlign: TextAlign.center,
    );
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final String phoneNumber = phoneController.text;
      final response = await RegisterOtp.registerOtp(phone: phoneNumber, email: widget.email!);

      if (response == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Reg_OTPVerificationScreen(
              phone: phoneNumber,
              image: widget.image,
              name: widget.name!,
              email: widget.email!,
              password: "",
              otp: '',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 800),
            content: Text('User with same phone number or email already exists'),
          ),
        );
      }
    }
  }
}