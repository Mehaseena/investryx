// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:project_emergio/services/profile%20forms/advisor/advisor%20get.dart';
// import 'package:project_emergio/services/profile%20forms/business/business%20get.dart';
// import 'package:project_emergio/services/profile%20forms/investor/investor%20get.dart';
// import 'package:project_emergio/services/user%20profile%20and%20personal%20info.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../services/profile forms/franchise/franchise get.dart';
// import 'Auth Screens/login.dart';
// import 'package:lottie/lottie.dart';
//
// class ManageProfilesScreen extends StatelessWidget {
//   final List<String> profiles = [
//     'Business Profile',
//     'Franchise Profile',
//     'Investor Profile',
//     'Advisor Profile',
//   ];
//   static final storage = FlutterSecureStorage(); // Initialize secure storage
//
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Manage Profiles',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: ListView.separated(
//               itemCount: profiles.length,
//               separatorBuilder: (context, index) => Divider(height: 1),
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(profiles[index]),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete_outline, color: Colors.red),
//                     onPressed: () {
//                       _showDeleteConfirmationDialog(context, profiles[index]);
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           Center(
//             child: Padding(
//               padding: EdgeInsets.only(bottom: h * 0.28),
//               child: TextButton.icon(
//                 icon: Icon(Icons.delete, color: Colors.red),
//                 label:
//                 Text('Delete Account', style: TextStyle(color: Colors.red)),
//                 onPressed: () {
//                   _showDeleteConfirmationDialog(context, 'your account');
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showDeleteConfirmationDialog(
//       BuildContext context, String itemName) async {
//     final token = await storage.read(key: 'token');
//
//     if (token == null) {
//       Get.snackbar('Error', 'Failed to get token');
//       return;
//     }
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: Lottie.asset(
//                   'assets/delete_confirmation.json',
//                   height: 60.h,
//                   width: 70.w,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Confirm Deletion',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
//               ),
//               SizedBox(height: 20),
//               Text(
//                   'Are you sure you want to delete $itemName? This action cannot be undone.'),
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
//               child: Text('Delete', style: TextStyle(color: Colors.red)),
//               onPressed: () async {
//                 try {
//                   if(itemName == 'Investor Profile'){
//                     await InvestorFetchPage.deleteInvestorProfile();
//                     Get.snackbar(
//                       'Success', 'Investor Profile deleted successfully',
//                       backgroundColor:
//                       Colors.black54,
//                       // Customize background color
//                       colorText: Colors.white,
//                       // Customize text color
//                       snackPosition: SnackPosition.BOTTOM,
//                       borderRadius: 8,
//                       margin: EdgeInsets.all(10),
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 10),
//                     );
//                     Navigator.pop(context);
//                   }
//                   else if(itemName == 'Franchise Profile')
//                     {
//                       await FranchiseFetchPage.deleteFranchiseProfile();
//                       Get.snackbar(
//                         'Success', 'Franchise Profile deleted successfully',
//                         backgroundColor:
//                         Colors.black54,
//                         // Customize background color
//                         colorText: Colors.white,
//                         // Customize text color
//                         snackPosition: SnackPosition.BOTTOM,
//                         borderRadius: 8,
//                         margin: EdgeInsets.all(10),
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 10),
//                       );
//                       Navigator.pop(context);
//
//
//                     }
//                   else if(itemName == 'Business Profile')
//                     {
//                       await BusinessGet.deleteBusinessProfile(token);
//                       Get.snackbar(
//                         'Success', 'Business Profile deleted successfully',
//                         backgroundColor:
//                         Colors.black54,
//                         // Customize background color
//                         colorText: Colors.white,
//                         // Customize text color
//                         snackPosition: SnackPosition.BOTTOM,
//                         borderRadius: 8,
//                         margin: EdgeInsets.all(10),
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 10),
//                       );
//                       Navigator.pop(context);
//
//                     }else if(itemName == 'Advisor Profile')
//                     {
//                       await AdvisorFetchPage.deleteAdvisorProfile(token);
//                       Get.snackbar(
//                         'Success', 'Advisor Profile deleted successfully',
//                         backgroundColor:
//                         Colors.black54,
//                         // Customize background color
//                         colorText: Colors.white,
//                         // Customize text color
//                         snackPosition: SnackPosition.BOTTOM,
//                         borderRadius: 8,
//                         margin: EdgeInsets.all(10),
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 10),
//                       );
//                       Navigator.pop(context);
//
//                     }
//                   else
//                   {
//                     await UserProfile.deleteUserProfile();
//                     // Clear shared preferences
//                     await storage.deleteAll();
//
//                     Get.snackbar(
//                       'Success', 'Profile deleted successfully',
//                       backgroundColor:
//                       Colors.black54,
//                       // Customize background color
//                       colorText: Colors.white,
//                       // Customize text color
//                       snackPosition: SnackPosition.BOTTOM,
//                       borderRadius: 8,
//                       margin: EdgeInsets.all(10),
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 10),
//                     );
//                     // Navigate to SignInPage
//                     Get.offAll(() => SignInPage());
//                   }
//
//
//                 } catch (e) {
//                   Get.snackbar(
//                     'Error', 'Failed to delete profile: $e',
//                     backgroundColor:
//                     Colors.black54, // Customize background color
//                     colorText: Colors.white, // Customize text color
//                     snackPosition: SnackPosition.BOTTOM,
//                     borderRadius: 8,
//                     margin: EdgeInsets.all(10),
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   );
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import '../services/profile forms/advisor/advisor get.dart';
import '../services/profile forms/business/business get.dart';
import '../services/profile forms/franchise/franchise get.dart';
import '../services/profile forms/investor/investor get.dart';
import '../services/user profile and personal info.dart';
import 'Auth Screens/login.dart';

class ManageProfileScreen extends StatefulWidget {
  const ManageProfileScreen({super.key});

  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  static final storage = FlutterSecureStorage();

  final Map<String, Map<String, dynamic>> profiles = {
    'Business Profile': {
      'color': Color(0xff6B89B7),
      'icon': Icons.business,
      'deleteFunction': BusinessGet.deleteBusinessProfile,
    },
    'Investor Profile': {
      'color': Color(0xffBDD0E7),
      'icon': Icons.monetization_on,
      'deleteFunction': InvestorFetchPage.deleteInvestorProfile,
    },
    'Franchise Profile': {
      'color': Color(0xffF3D55E),
      'icon': Icons.store,
      'deleteFunction': FranchiseFetchPage.deleteFranchiseProfile,
    },
    'Advisor Profile': {
      'color': Color(0xffD9D9D9),
      'icon': Icons.person,
      'deleteFunction': AdvisorFetchPage.deleteAdvisorProfile,
    },
  };

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Manage Profile'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        actions: const [Icon(Icons.notifications)],
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          // First Row of Profiles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRoleContainer('Business Profile', w, h),
              _buildRoleContainer('Investor Profile', w, h),
            ],
          ),
          const SizedBox(height: 20),
          // Second Row of Profiles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRoleContainer('Franchise Profile', w, h),
              _buildRoleContainer('Advisor Profile', w, h),
            ],
          ),
          const SizedBox(height: 40),
          // Delete Account Button
          ElevatedButton(
            onPressed: () => _showDeleteConfirmationDialog(context, 'your account'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffFFCC00),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Delete Account',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleContainer(String title, double w, double h) {
    return Container(
      height: h * 0.15,
      width: w * 0.44,
      decoration: BoxDecoration(
        color: profiles[title]!['color'] as Color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  profiles[title]!['icon'] as IconData,
                  size: 45,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _showDeleteConfirmationDialog(context, title),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String itemName) async {
    final token = await storage.read(key: 'token');

    if (token == null) {
      Get.snackbar('Error', 'Failed to get token');
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Lottie.asset(
                  'assets/delete_confirmation.json',
                  height: 60.h,
                  width: 70.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Confirm Deletion',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
              SizedBox(height: 20),
              Text('Are you sure you want to delete $itemName? This action cannot be undone.'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                try {
                  if (itemName == 'your account') {
                    await UserProfile.deleteUserProfile();
                    await storage.deleteAll();
                    Get.snackbar(
                      'Success',
                      'Profile deleted successfully',
                      backgroundColor: Colors.black54,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      borderRadius: 8,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    );
                    Get.offAll(() => SignInPage());
                  } else {
                    // Call the appropriate delete function based on profile type
                    if (itemName == 'Business Profile' || itemName == 'Advisor Profile') {
                      await profiles[itemName]!['deleteFunction'](token);
                    } else {
                      await profiles[itemName]!['deleteFunction']();
                    }

                    Get.snackbar(
                      'Success',
                      '$itemName deleted successfully',
                      backgroundColor: Colors.black54,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      borderRadius: 8,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    );
                    Navigator.pop(context);
                  }
                } catch (e) {
                  Get.snackbar(
                    'Error',
                    'Failed to delete profile: $e',
                    backgroundColor: Colors.black54,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    borderRadius: 8,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}