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
import '../Profiles/advisor/advisor_profile_add_screen.dart';

class AdvisorHomeScreen extends StatelessWidget {
  const AdvisorHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.find<NavigationController>();

    return PopScope(
        onPopInvoked: (_) async {
          controller.resetToNormal();
          Get.offAll(() => const CustomBottomNavBar(

          ));
          // return false;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomProfileHomeAppBar(
              title: 'Advisor',
              onProfileTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAdvisorProfileScreen()));
              },
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  BannerSlider(),
                  const CustomBusiness(
                    title: 'Advisor',
                    backgroundColor: Color(0xffAABBD0),
                    description:
                    'Lorem ipsum dolor sit amet consectetur. Tellus iaculis orci semper pellentesque enim quam ut. Pellentesque ',
                  ),
                  FeatureExpertList(
                    isType: true,
                  ),
                  RecommendedAdsPage(
                    profile: "advisor",
                  ),
                  FeatureExpertList(
                    isAdvisor: true,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavBar(),
            ),
        );
    }
}
