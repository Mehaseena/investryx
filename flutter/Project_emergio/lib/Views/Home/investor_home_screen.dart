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


class InvestorHomeScreen extends StatelessWidget {
  const InvestorHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.find<NavigationController>();

    return PopScope(
        onPopInvoked: (_) async {
          controller.resetToNormal();
          Get.offAll(() => const CustomBottomNavBar());
          // return false;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomProfileHomeAppBar(
              title: 'Investment',
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  BannerSlider(),
                  CustomBusiness(
                    title: 'Investment',
                    backgroundColor: Color(0xffAABBD0),
                    description: 'Lorem ipsum dolor sit amet consectetur. Tellus iaculis orci semper pellentesque enim quam ut. Pellentesque ',
                  ),
                  LatestActivitiesList(profile: "investor"),
                  RecommendedAdsPage(profile: "investor",),
                  TopBusinessWidget(
                    profile: "investor",
                  ),
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
