// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:timeago/timeago.dart' as timeago;
// import '../services/latest transactions and activites.dart';
//
// class RecentActivitiesWidget extends StatefulWidget {
//   const RecentActivitiesWidget({Key? key}) : super(key: key);
//
//   @override
//   State<RecentActivitiesWidget> createState() => _RecentActivitiesWidgetState();
// }
//
// class _RecentActivitiesWidgetState extends State<RecentActivitiesWidget> {
//   List<LatestActivites> activities = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchRecentActivities();
//   }
//
//   Future<void> _fetchRecentActivities() async {
//     try {
//       List<LatestActivites>? fetchedActivities = await LatestTransactions.fetchLatestTransactions();
//       if (fetchedActivities != null) {
//         setState(() {
//           activities = fetchedActivities;
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print('Error fetching activities: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   String formatDateTime(String dateTimeStr) {
//     DateTime dateTime = DateTime.parse(dateTimeStr);
//     return timeago.format(dateTime, allowFromNow: true);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }
//
//     if (activities.isEmpty) {
//       return Center(child: Text('No activities found.'));
//     }
//
//     return Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: 2,
//             itemBuilder: (context, index) {
//               final activity = activities[index];
//               return Padding(
//                 padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//                 child: Container(
//                   height: 160.h,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12.r),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 4,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(16.w),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 120.h,
//                           width: 115.w,
//                           child: Stack(
//                             children:[
//                               Positioned(
//                                 top : 28,
//                                 child: Container(
//                                   height: 91.h,
//                                   width: 115.w,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(color: Color(0xffFFCC00),width: 1.5),
//                                       borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15))
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 8,
//                                 child: ClipRRect(
//                                 borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15),topLeft: Radius.circular(15)),
//                                 child: Image.network(
//                                   activity.imageUrl,
//                                   width: 100.w,
//                                   height: 110.w,
//                                   fit: BoxFit.cover,
//                                 ),
//                                                             ),
//                               ),
//                                                  ] ),
//                         ),
//                         SizedBox(width: 16.w),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 activity.username,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16.sp,
//                                 ),
//                               ),
//                               SizedBox(height: 4.h),
//                               Text(
//                                 activity.title,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 14.sp,
//                                 ),
//                               ),
//                               SizedBox(height: 4.h),
//                               Text(
//                                 activity.description,
//                                 style: TextStyle(fontSize: 12.sp),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               SizedBox(height: 8.h),
//                               Text(
//                                 'INR {activity.minAmount} L - INR {activity.maxAmount} L',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 12.sp,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   void addActivity(LatestActivites newActivity) {
//     setState(() {
//       activities.add(newActivity);
//     });
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../services/latest transactions and activites.dart';

class RecentActivitiesWidget extends StatefulWidget {
  const RecentActivitiesWidget({Key? key}) : super(key: key);

  @override
  State<RecentActivitiesWidget> createState() => _RecentActivitiesWidgetState();
}

class _RecentActivitiesWidgetState extends State<RecentActivitiesWidget> {
  List<LatestActivites> activities = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRecentActivities();
  }

  Future<void> _fetchRecentActivities() async {
    try {
      List<LatestActivites>? fetchedActivities = await LatestTransactions.fetchLatestTransactions();
      if (fetchedActivities != null) {
        setState(() {
          activities = fetchedActivities;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching activities: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    return timeago.format(dateTime, allowFromNow: true);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (activities.isEmpty) {
      return Center(child: Text('No activities found.'));
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: activities.length > 2 ? 2 : activities.length, // Show max 2 items or less if fewer available
            itemBuilder: (context, index) {
              final activity = activities[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                child: Container(
                  height: 160.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 120.h,
                          width: 115.w,
                          child: Stack(
                              children:[
                                Positioned(
                                  top : 28,
                                  child: Container(
                                    height: 91.h,
                                    width: 115.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Color(0xffFFCC00),width: 1.5),
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15))
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15),topLeft: Radius.circular(15)),
                                    child: Image.network(
                                      activity.imageUrl,
                                      width: 100.w,
                                      height: 110.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activity.username,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                activity.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                activity.description,
                                style: TextStyle(fontSize: 12.sp),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'INR {activity.minAmount} L - INR {activity.maxAmount} L',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void addActivity(LatestActivites newActivity) {
    setState(() {
      activities.add(newActivity);
    });
  }
}