import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_emergio/Views/featured%20experts%20screen.dart';
import 'package:project_emergio/Views/top_business.dart';
import 'package:project_emergio/Widgets/custom_profile_appbar_widget.dart';
import 'package:project_emergio/Widgets/recent_posts_widget.dart';
import 'package:project_emergio/Widgets/recommended%20widget.dart';
import '../../Widgets/banner slider widget.dart';
import '../../Widgets/bottom navbar_widget.dart';
import '../../Widgets/home businessforsale_widget.dart';
import '../Profiles/Business/Business_profile_add_screen.dart';


class BusinessHomeScreen extends StatelessWidget {
  const BusinessHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.find<NavigationController>();

    void handleNavigation(int index) {
      if (index != 2) {  // If not clicking business icon
        controller.resetToNormal();
        Get.offAll(() => CustomBottomNavBar(initialIndex: index));
      }
    }

    return WillPopScope(
        onWillPop: () async {
          controller.resetToNormal();
          Get.offAll(() => const CustomBottomNavBar());
          return false;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomProfileHomeAppBar(
              title: "Business",
              onProfileTap: (){
                Get.to(AddBusinessProfileScreen());
              },),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  BannerSlider(),
                  CustomBusiness(),
                  LatestActivitiesList(profile: "business",),
                  RecommendedAdsPage(profile: "business",),
                  TopBusinessWidget(profile: "business",),
                  FeatureExpertList(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavBar(),
            ),
        );
    }
}
