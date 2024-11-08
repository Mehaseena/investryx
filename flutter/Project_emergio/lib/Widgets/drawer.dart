// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
// import 'package:project_emergio/Views/Auth%20Screens/Questionnare/reg_successfull.dart';
// import 'package:project_emergio/Views/Auth%20Screens/login.dart';
// import 'package:project_emergio/Views/Investment%20explore%20page.dart';
// import 'package:project_emergio/Views/Profiles/Business%20addPage.dart';
// import 'package:project_emergio/Views/Profiles/Franchise%20Form.dart';
// import 'package:project_emergio/Views/Profiles/Investor%20form.dart';
// import 'package:project_emergio/Views/Suggestion%20page.dart';
// import 'package:project_emergio/Views/advisor%20explore%20page.dart';
// import 'package:project_emergio/Views/business%20explore%20page.dart';
// import 'package:project_emergio/Views/contact%20us%20page.dart';
// import 'package:project_emergio/Views/franchise%20explore%20page.dart';
// import 'package:project_emergio/Views/pricing%20screen.dart';
// import 'package:project_emergio/Views/tutorial%20page.dart';
// import 'package:project_emergio/services/profile%20forms/advisor/advisor%20explore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../Views/FAQ page.dart';
// import '../Views/Profiles/Advisor form.dart';
// import '../Views/inbox_list page.dart';
// import '../Views/notification page.dart';
// import '../services/chatUserCheck.dart';
// import '../services/inbox service.dart';
//
// class CustomDrawerWidget extends StatefulWidget {
//   const CustomDrawerWidget({super.key});
//
//   @override
//   State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
// }
//
// class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       width: 280,
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           //padding: EdgeInsets.zero,
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             InkWell(
//               onTap: (){
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => CustomBottomNavBar()));
//               },
//               child: ListTile(
//                 leading: Icon(Icons.home),
//                 title: Text('Home'),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => NotificationScreen()));
//               },
//               child: ListTile(
//                 leading: Icon(Icons.notifications),
//                 title: Text('Notifications'),
//               ),
//             ),
//             InkWell(
//               onTap: ()  {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => InboxListScreen(),
//                     ),
//                   );
//               },
//
//               child: ListTile(
//                 leading: Icon(Icons.inbox),
//                 title: Text('Inbox'),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => PricingPage()));
//               },
//               child: ListTile(
//                 leading: Icon(Icons.attach_money),
//                 title: Text('Pricings'),
//               ),
//             ),
//             Divider(),
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => BusinessExplorePage(searchQuery: '')));
//               },
//               child: ListTile(
//                 leading: Icon(Icons.business),
//                 title: Text('Business For Sale'),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => InvestorExplorePage(searchQuery: '')));
//               },
//               child: ListTile(
//                 leading: Icon(Icons.people),
//                 title: Text('Investors'),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => FranchiseExplorePage(searchQuery: '')));
//               },
//               child: ListTile(
//                 leading: Icon(Icons.storefront),
//                 title: Text('Franchises'),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>AdvisorExploreScreen(searchQuery: '',)));
//               },
//               child: ListTile(
//                 leading: Icon(Icons.person),
//                 title: Text('Advisors'),
//               ),
//             ),
//             Divider(),
//             InkWell(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => TutorialPage()));
//               },
//               child: ListTile(
//                 leading: Icon(Icons.live_help),
//                 title: Text('Tutorial'),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => ContactUsPage()));
//               },
//               child: ListTile(
//                 leading: Icon(Icons.contact_mail),
//                 title: Text('Contact Us'),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => FAQScreen()));
//               },
//               child: ListTile(
//                 leading: Icon(Icons.help),
//                 title: Text('FAQ'),
//               ),
//             ),
//         InkWell(
//           onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => SuggestionScreen()));
//           },
//             child: ListTile(
//               leading: Icon(Icons.info),
//               title: Text('Suggestions'),
//             )),
//             Divider(),
//             InkWell(
//               onTap: () {
//                 showLogoutDialog(context);
//               },
//               child: ListTile(
//                 leading: Icon(
//                   Icons.logout,
//                   color: Colors.red,
//                 ),
//                 title: Text(
//                   'Logout',
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> showLogoutDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: Lottie.asset(
//                   'assets/logout_confirmation.json',
//                   height: 40.h,
//                   width: 60.w,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               SizedBox(height: 30.h),
//               Text('Confirm Logout',
//                   style:
//                       TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
//               SizedBox(height: 10.h),
//               Text('Are you sure you want to log out?'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Logout', style: TextStyle(color: Colors.red)),
//               onPressed: () async {
//                 Navigator.of(context).pop(); // Close the dialog
//                 await _logout(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _logout(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('phoneNumber');
//     await prefs.remove('password');
//     await prefs.remove('userId');
//
//
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => SignInPage()),
//     );
//   }
// }
