import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:project_emergio/Views/Auth%20Screens/location%20access%20page.dart';
import 'package:project_emergio/Views/Auth%20Screens/register.dart';
import 'package:project_emergio/Views/On-board%20Screens/splash.dart';
import 'package:project_emergio/Widgets/razorpay%20widget.dart';

import 'Views/Home/home_screen.dart';
import 'Views/profile page.dart';
import 'Widgets/location widget.dart';
import 'demo.dart';
import 'demo2.dart';

// Navigator key for navigation when a notification is clicked
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDnmhOunkR9ubo-I011H9wj9FNMnmQWi-I",
      appId: "1:921940068975:android:1cc22aefdf1a645469db9a",
      messagingSenderId: "921940068975",
      projectId: "emergio-2abb8",
    ),
  );

  // Initialize OneSignal for push notifications
  // await initOneSignal();

  runApp(const MyApp());
}

// Future<void> initOneSignal() async {
//   // Set log level for debugging purposes
//   OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//
//   // Initialize OneSignal with your app ID
//   OneSignal.initialize("697da393-f253-47db-b4fd-c6ca19cbd132");
//
//   // Request push notification permissions
//   await OneSignal.Notifications.requestPermission(true);
//
//   // Add tags to segment users (optional)
//   OneSignal.User.addTags({"segment": "Notifications"});
//
//   // Handle notification clicks
//   OneSignal.Notifications.addClickListener((event) {
//     final data = event.notification.additionalData;
//     int? leadId = data?['lead_id'];
//
//     // if (leadId != null) {
//     //   // Navigate to the specific screen when a notification is clicked
//     //   navigatorKey.currentState?.push(
//     //     MaterialPageRoute(
//     //       builder: (context) => LeadDetailScreen(
//     //         leadId: leadId,
//     //       ),
//     //     ),
//     //   );
//     // }
//
//     // Log additional data for debugging
//     log("DATA =====> $leadId");
//
//     // Get push subscription ID
//     final id = OneSignal.User.pushSubscription.id;
//     log("############### $id");
//   });
// }

// Future<void> initOneSignal() async {
//   // Set log level for debugging purposes
//   OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//
//   // Initialize OneSignal with your app ID
//   OneSignal.initialize("697da393-f253-47db-b4fd-c6ca19cbd132");
//
//   // Request push notification permissions
//   await OneSignal.Notifications.requestPermission(true);
//
//   // Add tags to segment users (optional)
//   OneSignal.User.addTags({"segment": "Notifications"});
//
//   // Get push subscription ID after initialization
//   String? oneSignalId = await OneSignal.User.getOnesignalId();
//   // log("OneSignal Push Subscription ID: $oneSignalId");
//
//   // Pass the OneSignal ID to your backend
//   await sendOneSignalIdToBackend(oneSignalId);
//
//   // Handle notification clicks
//   OneSignal.Notifications.addClickListener((event) {
//     final data = event.notification.additionalData;
//     int? leadId = data?['lead_id'];
//
//     // Handle lead navigation
//     // if (leadId != null) {
//     //   navigatorKey.currentState?.push(
//     //     MaterialPageRoute(
//     //       builder: (context) => LeadDetailScreen(
//     //         leadId: leadId,
//     //       ),
//     //     ),
//     //   );
//     // }
//
//     // Log additional data for debugging
//     log("Notification data: $data");
//   });
// }

Future<void> sendOneSignalIdToBackend(String? oneSignalId) async {
  if (oneSignalId != null) {
      print("the api to send onesignal to backend is working with ${oneSignalId}");
    try {
      final response = await http.post(
        Uri.parse('https://your-backend-url.com/api/onesignal-id'),
        headers: {
          'Content-Type': 'application/json',
          'token': 'your-auth-token',  // Add token if needed
        },
        body: jsonEncode({
          'oneSignalId': oneSignalId,
          'userId': 'yourUserId', // If you need to pass user ID
        }),
      );

      if (response.statusCode == 200) {
        log("OneSignal ID successfully sent to backend");
      } else {
        log("Failed to send OneSignal ID to backend: ${response.statusCode}");
      }
    } catch (error) {
      log("Error sending OneSignal ID: $error");
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          navigatorKey: navigatorKey,
            home: LocationAccessScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
