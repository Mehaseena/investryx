import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Views/dashboard_screen.dart';
import 'bottom navbar_widget.dart';

class CustomProfileHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onProfileTap;
  final String profileImagePath;
  final VoidCallback? onBackPressed;

  const CustomProfileHomeAppBar({
    super.key,
    this.title = 'Business',
    this.onProfileTap,
    this.profileImagePath = "assets/profile.png",
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: onBackPressed ?? () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => CustomBottomNavBar(
                  // showBusinessIcon: false
              ),
            ),
                (route) => false,
          );
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        InkWell(
          onTap: onProfileTap ?? () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardScreen(),
              ),
            );
          },
          child: CircleAvatar(
            radius: 22.r,
            backgroundImage: AssetImage(profileImagePath),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}