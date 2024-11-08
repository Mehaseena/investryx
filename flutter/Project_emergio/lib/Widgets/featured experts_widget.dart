// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:project_emergio/Views/chat%20screen.dart';
// import 'package:project_emergio/Views/expert%20profile%20screen.dart';
//
// class FeaturedExpertsWidget extends StatefulWidget {
//   const FeaturedExpertsWidget({super.key});
//
//   @override
//   State<FeaturedExpertsWidget> createState() => _FeaturedExpertsWidgetState();
// }
//
// class _FeaturedExpertsWidgetState extends State<FeaturedExpertsWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return SizedBox(
//       height: h * .335,
//       child: ListView.builder(
//         padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
//         scrollDirection:
//             Axis.horizontal, // Set the scroll direction to horizontal
//         itemCount: 10, // Number of items in the list
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Card(
//               color: Colors.white,
//               elevation: 2,
//               child: Container(
//                 width: w * .5, // Set the width for each item
//                 decoration: BoxDecoration(
//                   border: BorderDirectional(
//                       top: BorderSide(
//                     color: Colors.black26,
//                   )),
//                   borderRadius: const BorderRadius.all(Radius.circular(10)),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(top: h * 0.02),
//                       child: const CircleAvatar(
//                         backgroundColor: Colors.black12,
//                         radius: 40,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         'Expert Name',
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                     const Text(
//                       'Business Broker',
//                       style: TextStyle(),
//                     ),
//                     const SizedBox(height: 10),
//                     const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.star,
//                           color: Color(0xffFFD233),
//                         ),
//                         Icon(
//                           Icons.star,
//                           color: Color(0xffFFD233),
//                         ),
//                         Icon(
//                           Icons.star,
//                           color: Color(0xffFFD233),
//                         ),
//                         Icon(
//                           Icons.star,
//                           color: Color(0xffFFD233),
//                         ),
//                         Icon(
//                           Icons.star_border,
//                           color: Color(0xffFFD233),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 27.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         // Container(
//                         //   height: 35.h,
//                         //   width: 90.w,
//                         //   decoration: BoxDecoration(
//                         //       shape: BoxShape.rectangle,
//                         //       borderRadius: BorderRadius.all(Radius.circular(5)),
//                         //      // color: Colors.redAccent
//                         //   ),
//                         //   child:
//                         // TextButton(
//                         //     onPressed: () {
//                         //       Navigator.push(
//                         //         context,
//                         //         MaterialPageRoute(
//                         //           builder: (context) =>
//                         //               const FeaturedExpertsProfile(),
//                         //         ),
//                         //       );
//                         //     },
//                         //     child: Text('Profile')),),
//                         SizedBox(
//                           height: h * 0.04,
//                           width: 93.5.w,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.only(
//                                   bottomLeft: Radius.circular(10),
//                                 ),
//                                 side: BorderSide(
//                                   color: Colors.black12,
//                                   width: 1,
//                                 ),
//                               ),
//                             ),
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                   const FeaturedExpertsProfile(),
//                                 ),
//                               );
//                             },
//                             child: const Text(
//                               'Profile',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                         // Container(
//                         //   height: 35.h,
//                         //   width: 90.w,
//                         //   decoration: BoxDecoration(
//                         //     shape: BoxShape.rectangle,
//                         //     borderRadius: BorderRadius.all(Radius.circular(5)),
//                         //     //color: Colors.redAccent
//                         //   ),
//                         //   child: TextButton(
//                         //       onPressed: () {
//                         //         Navigator.push(
//                         //           context,
//                         //           MaterialPageRoute(
//                         //             builder: (context) => ChatScreen(),
//                         //           ),
//                         //         );
//                         //       },
//                         //       child: Text('Chat')),
//                         // ),
//                         SizedBox(
//                           height: h * 0.04,
//                           width: 94.w,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                              shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.only(
//                                   bottomRight: Radius.circular(10),
//                                 ),
//                                 side: BorderSide(
//                                   color: Colors.black12,
//                                   width: 1,
//                                 ),
//                              ),
//                             ),
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>  ChatScreen(),
//                                 ),
//                               );
//                             },
//                             child: const Text(
//                               'Chat',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:project_emergio/Views/chat%20screen.dart';
import 'package:project_emergio/Views/detail%20page/advisor%20detail%20page.dart';
import 'package:project_emergio/Views/expert%20profile%20screen.dart';
import 'package:project_emergio/Views/inbox_list%20page.dart';
import 'package:shimmer/shimmer.dart';

import '../Views/detail page/demo.dart';
import '../models/all profile model.dart';
import '../services/featured.dart';

class FeaturedExpertsWidget extends StatefulWidget {
  const FeaturedExpertsWidget({super.key});

  @override
  State<FeaturedExpertsWidget> createState() => _FeaturedExpertsWidgetState();
}

class _FeaturedExpertsWidgetState extends State<FeaturedExpertsWidget> {
  List<AdvisorExplr>? featuredItems;
  bool _isLoading = true;
  bool _hasError = false;
  bool _noData = false;

  @override
  void initState() {
    super.initState();
    _loadFeaturedListings();
  }

  Future<void> _loadFeaturedListings() async {
    try {
      final items = await Featured.fetchFeaturedAdvisorData();
      setState(() {
        featuredItems = items;
        _isLoading = false;
        _hasError = false;
        _noData = items!.isEmpty;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _noData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: h * .335,
      child: _isLoading
          ? _buildShimmer(w, h)
          : _hasError
          ? _buildErrorMessage(h)
          : _noData
          ? _buildNoDataMessage(h)
          : _buildFeaturedList(w, h),
    );
  }

  Widget _buildErrorMessage(double h) {
    return SizedBox(
      height: h * .355,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 40, color: Colors.red),
            SizedBox(height: 12),
            Text(
              "Oops! Something went wrong.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text(
              "Please try again later.",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataMessage(double h) {
    return SizedBox(
      height: h * .355,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/nodata.json',
              height: 80.h,
              width: 90.w,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 12),
            Text(
              "No featured listings yet",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text(
              "Check back soon for exciting offers!",
              style: TextStyle(fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildShimmer(double w, double h) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: w * .5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 140.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black26),
                    ),
                  ),
                ),
                Container(
                  height: 20.h,
                  width: w * .5 - 16,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: h * 0.018,
                      ),
                      SizedBox(width: 5),
                      Container(
                        height: 20.h,
                        width: 60,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.time,
                        color: Colors.white,
                        size: h * 0.018,
                      ),
                      SizedBox(width: 5),
                      Container(
                        height: 20.h,
                        width: 60,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeaturedList(double w, double h) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: featuredItems?.length ?? 0,
      itemBuilder: (context, index) {
        var item = featuredItems![index];
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: w * 0.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: h * 0.02),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(item.imageUrl),
                    backgroundColor: Colors.black12,
                    radius: 60,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Text(
                  item.designation!,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 10),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Icon(Icons.star, color: Color(0xffFFD233)),
                //     Icon(Icons.star, color: Color(0xffFFD233)),
                //     Icon(Icons.star, color: Color(0xffFFD233)),
                //     Icon(Icons.star, color: Color(0xffFFD233)),
                //     Icon(Icons.star_border, color: Color(0xffFFD233)),
                //   ],
                // ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                            ),
                            side: BorderSide(color: Colors.black12, width: 1),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                     AdvisorDetailPage(
                                    advisor: item,
                                     )));
                        },
                        child: const Text(
                          'Profile',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                            ),
                            side: BorderSide(color: Colors.black12, width: 1),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ChatScreen(roomId: '', name: '', imageurl: '',)));
                        },
                        child: const Text(
                          'Chat',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


