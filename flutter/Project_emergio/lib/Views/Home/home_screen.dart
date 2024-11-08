import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_emergio/Views/Home/business_home.dart';
import 'package:project_emergio/Views/Home/franchise_home_screen.dart';
import 'package:project_emergio/Views/Home/investor_home_screen.dart';
import 'package:project_emergio/Views/inbox_list%20page.dart';
import 'package:project_emergio/Views/notification%20page.dart';
import 'package:project_emergio/Widgets/banner%20slider%20widget.dart';
import 'package:project_emergio/Widgets/graph%20widget.dart';
import 'package:project_emergio/Widgets/recommended%20widget.dart';
import '../../Widgets/businessvaluecalculator_widget.dart';
import '../../Widgets/recent activities_widget.dart';
import '../../Widgets/recent_posts_widget.dart';
import 'advisor_home_screen.dart';
import '../featured experts screen.dart';

class InveStryxHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>InboxListScreen()));
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.chat, color: Color(0xffFFCC00),),
        shape: CircleBorder(),
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildSearchBar(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLeftColumn(context),
                  _buildRightColumn(context),
                ],
              ),
              BannerSlider(),
              SizedBox(height: 16,),
              LatestActivitiesList(profile: ""),
              SizedBox(height: 14,),
              RecommendedAdsPage(profile: "home",),
              SizedBox(height: 14,),
              FeatureExpertList(isType: true,),
              SizedBox(height: 20,),
              BusinessValuationPromoCard(),
              SizedBox(height: 16,),
              SizedBox(
                  height: 400.h,
                  child: InvestmentChart()),
              SizedBox(
                  height: 380,
                  child: RecentActivitiesWidget()),
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );

  }

  PreferredSizeWidget _buildAppBar(context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Inve',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              TextSpan(
                text: 'Stry',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xffFFCC00)),
              ),
              TextSpan(
                text: 'x',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
        actions: [
          Icon(Icons.workspace_premium, color: Colors.amber),
          SizedBox(width: 16),
          InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
              child: Icon(Icons.notifications, color: Colors.black)),
          SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.search, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftColumn(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 10),
          child: _buildCard(
            height: 195.h,
            width: 173.w,
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BusinessHomeScreen(),
                ),
              );
            },
            color: Color(0xff6B89B7),
            text: 'Sell your Business\nfind Investors',
            imagePath: 'assets/business_vector.png',
            imageTop: 85,
            imageLeft: 60,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 10),
          child: _buildCard(
            height: 220.h,
            width: 173.w,
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FranchiseHomeScreen(),
                ),
              );
            },
            color: Color(0xffF3D55E),
            text: 'Franchise your Brand\nget distributors',
            imagePath: 'assets/franchise_vector.png',
            imageTop: 100,
            imageLeft: 50,
            imageHeight: 100,
          ),
        ),
      ],
    );
  }

  Widget _buildRightColumn(context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 10),
          child: _buildCard(
            height: 220.h,
            width: 173.w,
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InvestorHomeScreen(),
                ),
              );
            },
            color: Color(0xffBDD0E7),
            text: 'Buy a business invest\nin a business',
            imagePath: 'assets/investor_vector.png',
            imageTop: 100,
            imageLeft: 50,
            imageHeight: 100,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 10),
          child: _buildCard(
            height: 195.h,
            width: 173.w,
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdvisorHomeScreen(),
                ),
              );
            },
            color: Color(0xffC3C3C3),
            text: 'Register as an advisor\nor business broker',
            imagePath: 'assets/advisor_vector.png',
            imageTop: 85,
            imageLeft: 75,
            imageHeight: 90,
          ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required double height,
    required double width,
    required Color color,
    required String text,
    required String imagePath,
    required double imageTop,
    required double imageLeft,
    required VoidCallback  onTap,
    double? imageHeight,
  }) {
    return InkWell(
        onTap: onTap,
        child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.h),
                  ),
                ),
                Positioned(
                  top: imageTop,
                  left: imageLeft,
                  child: SizedBox(
                    height: imageHeight ?? 100,
                    child: Image.asset(imagePath),
                  ),
                ),
              ],
            ),
            ),
        );
    }
}
