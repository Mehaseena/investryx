// import 'package:flutter/material.dart';
// import 'package:project_emergio/Views/Featured%20listing%20page.dart';
// import 'package:project_emergio/Views/featured%20experts%20screen.dart';
// import 'package:project_emergio/Views/recommended%20ads%20page.dart';
// import 'package:project_emergio/Widgets/AppBar_widget.dart';
// import 'package:project_emergio/Widgets/Searchbar_widget.dart';
// import 'package:project_emergio/Widgets/aboutus_widget.dart';
// import 'package:project_emergio/Widgets/banner%20slider%20widget.dart';
// import 'package:project_emergio/Widgets/businessvaluecalculator_widget.dart';
// import 'package:project_emergio/Widgets/drawer.dart';
// import 'package:project_emergio/Widgets/featured%20experts_widget.dart';
// import 'package:project_emergio/Widgets/graph%20widget.dart';
// import 'package:project_emergio/Widgets/home%20businessforsale_widget.dart';
// import 'package:project_emergio/Widgets/home%20investor%20widget.dart';
// import 'package:project_emergio/Widgets/itemCard_widget.dart';
// import 'package:project_emergio/Widgets/recent%20activities_widget.dart';
// import 'package:project_emergio/Widgets/recommended%20widget.dart';
// import '../../Widgets/catogory_widget.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../Widgets/home franchise_widget.dart';
// import '../../services/onesignal Id service.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   final ValueNotifier<String> selectedFilterNotifier =
//   ValueNotifier<String>('Business');
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeOneSignal();
//   }
//
//   Future<void> _initializeOneSignal() async {
//     try {
//       final result = await OnesignalService.onesignalId();
//       if (result != null && result) {
//         print('OneSignal ID sent successfully');
//       } else {
//         print('Failed to send OneSignal ID');
//       }
//     } catch (e) {
//       print('Error initializing OneSignal: $e');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         key: _scaffoldKey,
//         backgroundColor: Colors.white,
//         endDrawer: CustomDrawerWidget(),
//         appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 250.h,
//                 child: Stack(
//                   children: [
//                     Image.asset(
//                       'assets/home.png',
//                       fit: BoxFit.cover,
//                     ),
//                     Positioned(
//                       top: 45.h,
//                       left: 15.w,
//                       child: Column(
//                         children: [
//                           Text(
//                             'Building Bridges to Success',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 24.sp,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.all(6.0.w),
//                             child: Text(
//                               'Pellentesque egestas elementum posuere faucibus sem velit',
//                               style: TextStyle(
//                                 fontSize: 12.sp,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       top: 185.h,
//                       left: 28.w,
//                       child: SearchbarWidget(
//                         selectedFilterNotifier: selectedFilterNotifier,
//                       ),
//                     ),
//                     Positioned(
//                       top: 158.h,
//                       left: 36.w,
//                       child: FilterWidget(
//                         selectedFilterNotifier: selectedFilterNotifier,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 10.w, top: 8.h),
//                     child: Text('Recommended For You',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 20.sp)),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(right: 10.w, top: 8.h),
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => RecommendedAdsScreen()));
//                       },
//                       child: Text(
//                         'View More',
//                         style: TextStyle(
//                             fontSize: 12.sp, fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                   height: 280.h,
//                   child: RecommendedAdsPage()),
//               HomeBusinessForSaleWidget(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 10.w, top: 8.h),
//                     child: Text('Featured Listing',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 20.sp)),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(right: 10.w, top: 8.h),
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => FeaturedListingScreen()));
//                       },
//                       child: Text(
//                         'View More',
//                         style: TextStyle(
//                             fontSize: 12.sp, fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//              FeaturedListingWidget(),
//               HomeFranchiseWidget(),
//               SizedBox(height: 2.h),
//               Container(
//                 height: 290,
//                 child: BannerSlider(),
//               ),
//               HomeInvestorWidget(),
//               SizedBox(height: 5.h),
//               BusinessValueCalculatorWidget(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 10.w, top: 8.h),
//                     child: Text('Featured Experts',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 20.sp)),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(right: 10.w, top: 8.h),
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => FeaturedExpertsScreen()));
//                       },
//                       child: Text(
//                         'View More',
//                         style: TextStyle(
//                             fontSize: 12.sp, fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15.h),
//              FeaturedExpertsWidget(),
//               SizedBox(height: 10.h),
//               Padding(
//                 padding: EdgeInsets.only(left: 10.w, top: 8.h, bottom: 8.h),
//                 child: Text('Business Analysis',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 20.sp)),
//               ),
//
//               SizedBox(
//                   height: 400.h,
//                   child: InvestmentChart()),
//               SizedBox(height: 20.h),
//               Padding(
//                 padding: EdgeInsets.only(
//                     left: 10.w, top: 8.h, bottom: 8.h, right: 10.w),
//                 child: Text(
//                   'Check out our latest transactions and activities',
//                   style:
//                       TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               RecentActivitiesWidget(),
//               SizedBox(height: 40.h),
//               AboutUsWidget(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
