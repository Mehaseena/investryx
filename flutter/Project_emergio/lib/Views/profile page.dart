

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_emergio/Views/settings_screen.dart';
import '../controller/Profile controller.dart';
import '../Views/personal information screen.dart';
import '../Views/recent activities page.dart';
import '../Views/manage profile screen.dart';
import '../Views/contact us page.dart';
import '../Views/Auth Screens/ForgotPassword/change password.dart';


class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Obx(() {
        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              // Background image container
              Obx(() => Stack(
                children: [
                  Container(
                  height: 310.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: controller.profileImageUrl.value != null
                          ? NetworkImage(controller.profileImageUrl.value!)
                          : const AssetImage('assets/profile_picture.jpg') as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                  Container(
                    color: Colors.black45,
                  )
              ])),
              // White container with rounded corners
              Padding(
                padding: EdgeInsets.only(top: 190.h),
                child: Container(
                  height: 632.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(38.r),
                      topRight: Radius.circular(38.r),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(top: 45.h),
                      child: Column(
                        children: [
                          Text(
                            controller.firstName.value.isEmpty
                                ? 'Loading...'
                                : controller.firstName.value,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            controller.phoneNumber.value,
                            style: TextStyle(
                              fontSize: 13.5.sp,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 18.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildRoleContainer('Business',
                                    const Color(0xff6B89B7), Icons.business),
                                _buildRoleContainer('Franchise',
                                    const Color(0xffF3D55E), Icons.store),
                                _buildRoleContainer('Investor',
                                    const Color(0xffBDD0E7), Icons.monetization_on),
                                _buildRoleContainer('Advisor',
                                    const Color(0xffD9D9D9), Icons.person),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          // List tiles remain same...
                          _buildListTile(
                            'Personal Information',
                            Icons.person,
                            onTap: () {
                              Get.to(
                                    () => PersonalInformationScreen(
                                  onUpdate: (newImage) {
                                    if (newImage != null) {
                                      String newImageUrl =
                                      controller.profileImageUrl.value!;
                                      controller.updateProfileImage(newImageUrl);
                                    }
                                  },
                                ),
                              )?.then((_) => controller.fetchUserProfile());
                            },
                          ),
                          _buildListTile(
                            'Recent Activities',
                            Icons.history,
                            onTap: () => Get.to(() => RecentActivitiesScreen()),
                          ),
                          _buildListTile(
                            'Manage Profiles',
                            Icons.edit,
                            onTap: () => Get.to(() => ManageProfileScreen()),
                          ),
                          _buildListTile(
                            'Settings',
                            Icons.settings,
                            onTap: () => Get.to(() => SettingsScreen()),
                          ),
                          // _buildListTile(
                          //   'Change Password',
                          //   Icons.lock,
                          //   onTap: () => Get.to(() => ChangePasswordScreen(
                          //       phoneNumber: controller.phoneNumber.value)),
                          // ),
                          _buildListTile(
                            'Log Out',
                            Icons.exit_to_app,
                            isLogout: true,
                            onTap: () => controller.showLogoutDialog(context),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Profile Image
              Positioned(
                top: 115.h,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 58.r,
                      backgroundImage: controller.profileImageUrl.value == null
                          ? const AssetImage('assets/profile_picture.jpg') as ImageProvider
                          : NetworkImage(controller.profileImageUrl.value!),
                    ),
                  ],
                ),
              ),
              // Back Button
              Positioned(
                top: 38.h,
                left: 15.w,
                child: CircleAvatar(
                  radius: 19.r,
                  backgroundColor: Colors.grey,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, size: 19.sp),
                    onPressed: () => Get.back(),
                  ),
                ),
              ),
              // Notification Button
              Positioned(
                top: 38.h,
                right: 15.w,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: 23.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildRoleContainer(String title, Color color, IconData icon) {
    return Container(
      height: 80.h,
      width: 80.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 26.sp,
            color: Colors.white,
          ),
          SizedBox(height: 7.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.5.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon,
      {bool isLogout = false, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 3.h),
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : Colors.black,
        size: 23.sp,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black,
          fontSize: 15.sp,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 15.sp),
      onTap: onTap,
    );
  }
}