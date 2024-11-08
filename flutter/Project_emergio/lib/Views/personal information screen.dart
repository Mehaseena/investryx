import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:shimmer/shimmer.dart';
import '../controller/Personal info controller.dart';

class PersonalInformationScreen extends StatelessWidget {
  final PersonalInfoController controller = Get.put(PersonalInfoController());

  PersonalInformationScreen({required this.onUpdate});

  final Function(File?) onUpdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildShimmerPlaceholder();
        }

        return Stack(
          children: [
            // Background Image
            Container(
              height: 250.h,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: controller.imageFile.value != null
                      ? FileImage(controller.imageFile.value!)
                      : controller.networkImageUrl.value != null &&
                      controller.networkImageUrl.value!.isNotEmpty
                      ? NetworkImage(controller.networkImageUrl.value!)
                      : const AssetImage('assets/profile_picture.jpg')
                  as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: Colors.black45,
            ),
            // Main Content
            SingleChildScrollView(
              child: Column(
                children: [
                  // Top Bar with Back Button and Title
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 40.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white38,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.black),
                            onPressed: () => Get.back(),
                          ),
                        ),
                        // Text(
                        //   'Profile',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 20.sp,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // CircleAvatar(
                        //   backgroundColor: Colors.white,
                        //   child: Stack(
                        //     children: [
                        //       Icon(Icons.notifications, color: Colors.black),
                        //       Positioned(
                        //         right: 0,
                        //         top: 0,
                        //         child: Container(
                        //           padding: EdgeInsets.all(2),
                        //           decoration: BoxDecoration(
                        //             color: Colors.yellow,
                        //             shape: BoxShape.circle,
                        //           ),
                        //           child: Text(
                        //             '2',
                        //             style: TextStyle(
                        //               fontSize: 10.sp,
                        //               color: Colors.black,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // White Container with Curved Top
                  Container(
                    margin: EdgeInsets.only(top: 100.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 50.h),
                            _buildInputField(
                              'Name',
                              controller.nameController.value,
                              _validateName,
                            ),
                            SizedBox(height: 20.h),
                            _buildInputField(
                              'Email',
                              controller.emailController.value,
                              _validateEmail,
                            ),
                            SizedBox(height: 20.h),
                            _buildInputField(
                              'Phone Number',
                              controller.phoneController.value,
                              _validatePhoneNumber,
                            ),
                            SizedBox(height: 20.h),
                            _buildInputField(
                              'Whatsapp Number',
                              controller.whatsappController.value,
                              _validatePhoneNumber,
                            ),
                            SizedBox(height: 40.h),
                            Center(
                              child: SizedBox(
                                width: 280.w,
                                height: 50.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.r),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      controller.updateUserProfile();
                                    }
                                  },
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Profile Picture
            Positioned(
              top: 180.h,
              left: 0,
              right: 0,
              child: Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: controller.imageFile.value != null
                          ? FileImage(controller.imageFile.value!)
                          : controller.networkImageUrl.value != null &&
                          controller.networkImageUrl.value!.isNotEmpty
                          ? NetworkImage(controller.networkImageUrl.value!)
                          : const AssetImage('assets/profile_picture.jpg')
                      as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: Colors.yellow,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt,
                              size: 18.sp, color: Colors.black),
                          onPressed: () async {
                            await controller.pickImage();
                            onUpdate(controller.imageFile.value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildInputField(
      String label,
      TextEditingController controller,
      String? Function(String?) validator,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: Colors.yellow),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildShimmerPlaceholder() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        SizedBox(height: 50.0),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
          ),
        ),
        SizedBox(height: 16.0),
        _buildShimmerTextField(),
        SizedBox(height: 16.0),
        _buildShimmerTextField(),
        SizedBox(height: 16.0),
        _buildShimmerTextField(),
        SizedBox(height: 16.0),
        _buildShimmerTextField(),
        SizedBox(height: 16.0),
        _buildShimmerTextField(),
        SizedBox(height: 16.0),
        _buildShimmerButton(),
      ],
    );
  }

  Widget _buildShimmerTextField() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildShimmerButton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          'Update',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (value.length > 50) {
      return 'Email cannot be longer than 50 characters';
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
      return 'Enter a valid email address with a proper domain';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }
    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
      return 'Enter a valid phone number (10-15 digits)';
    }
    return null;
  }
}
