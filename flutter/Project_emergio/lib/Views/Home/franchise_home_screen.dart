import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_emergio/Views/featured%20experts%20screen.dart';
import 'package:project_emergio/Views/top_business.dart';
import 'package:project_emergio/Widgets/custom_profile_appbar_widget.dart';
import 'package:project_emergio/Widgets/featured%20experts_widget.dart';
import 'package:project_emergio/Widgets/recent_posts_widget.dart';
import 'package:project_emergio/Widgets/recommended%20widget.dart';
import 'package:get/get.dart';
import '../../Widgets/banner slider widget.dart';
import '../../Widgets/bottom navbar_widget.dart';
import '../../Widgets/home businessforsale_widget.dart';


class FranchiseHomeScreen extends StatelessWidget {
  const FranchiseHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.find<NavigationController>();

    return WillPopScope(
        onWillPop: () async {
          controller.resetToNormal();
          Get.offAll(() => const CustomBottomNavBar());
          return false;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomProfileHomeAppBar(title: "Franchise",),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  BannerSlider(),
                  CustomBusiness(),
                  LatestActivitiesList(profile: "franchise"),
                  RecommendedAdsPage(profile: "franchise",),
                  TopBusinessWidget(profile: "franchise",),
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
