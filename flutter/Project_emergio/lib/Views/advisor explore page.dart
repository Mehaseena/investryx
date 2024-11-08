// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
// import 'package:project_emergio/Views/detail%20page/advisor%20detail%20page.dart';
//
// import '../services/profile forms/advisor/advisor explore.dart';
// import 'detail page/demo.dart';
//
// class AdvisorExploreScreen extends StatefulWidget {
//   @override
//   _AdvisorExploreScreenState createState() => _AdvisorExploreScreenState();
// }
//
// class _AdvisorExploreScreenState extends State<AdvisorExploreScreen> {
//   late Future<List<AdvisorExplr>?> _advisorsFuture;
//   List<AdvisorExplr> _advisors = [];
//   List<AdvisorExplr> _filteredAdvisors = [];
//   late TextEditingController _searchController;
//
//   @override
//   void initState() {
//     super.initState();
//     _searchController = TextEditingController();
//     _searchController.addListener(() {
//       _filterAdvisors();
//     });
//     _advisorsFuture = _fetchAdvisors();
//   }
//
//   Future<List<AdvisorExplr>?> _fetchAdvisors() async {
//     try {
//       final advisors = await AdvisorExplorePage.fetchAdvisorExplore();
//       setState(() {
//         _advisors = advisors ?? [];
//         _filteredAdvisors = _advisors; // Initialize filtered list
//       });
//       return _advisors;
//     } catch (e) {
//       // Handle the error, possibly show an error message
//       return null;
//     }
//   }
//
//   void _filterAdvisors() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       _filteredAdvisors = _advisors.where((advisor) {
//         final nameLower = advisor.name.toLowerCase();
//         final locationLower = advisor.location.toLowerCase();
//         return nameLower.contains(query) || locationLower.contains(query);
//       }).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Advisor Explore'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 10.0.w, right: 10.w, top: 6.w, bottom: 6.w),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search advisors...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.r),
//                   borderSide: BorderSide(color: Colors.black38),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: FutureBuilder<List<AdvisorExplr>?>(
//               future: _advisorsFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: Lottie.asset(
//                       'assets/loading.json',
//                       height: 80.h,
//                       width: 120.w,
//                       fit: BoxFit.cover,
//                     ),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No advisors available', style: TextStyle(fontSize: 18.sp)));
//                 } else {
//                   // Update the filtered list if needed
//                   if (_advisors.isEmpty) {
//                     _advisors = snapshot.data!;
//                     _filterAdvisors(); // Initialize filtered list based on fetched data
//                   }
//
//                   return GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 2 / 3,
//                       mainAxisSpacing: 4.0,
//                       crossAxisSpacing: 4.0,
//                     ),
//                     padding: EdgeInsets.all(8.0.w),
//                     itemCount: _filteredAdvisors.length,
//                     itemBuilder: (context, index) {
//                       final advisor = _filteredAdvisors[index];
//                       return  GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => AdvisorProfileDetailPage(advisor: advisor),
//                             ),
//                           );
//                         },
//
//                         child: Card(
//                           color: Colors.white,
//                           elevation: 2,
//                           child: Container(
//                             width: w * .5,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                               border: Border.all(color: Colors.black12),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Stack(
//                                   children: [
//                                     Container(
//                                       height: 88.h,
//                                       decoration: BoxDecoration(
//                                         color: Color(0xff3D3F54),
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(10),
//                                           topRight: Radius.circular(10),
//                                         ),
//                                       ),
//                                     ),
//                                     Align(
//                                       alignment: Alignment.center,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(top: 20.h),
//                                         child: Container(
//                                           width: 105.h + 4, // Adjust for border width
//                                           height: 105.h + 4, // Adjust for border width
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             border: Border.all(
//                                               color: Color(0xff3D3F54), // Border color
//                                               width: 3, // Border width
//                                             ),
//                                           ),
//                                           child: ClipOval(
//                                             child: Container(
//                                               width: 110.h,
//                                               height: 110.h,
//                                               decoration: BoxDecoration(
//                                                 image: DecorationImage(
//                                                   image: NetworkImage(advisor.imageUrl),
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 9),
//                                   child: Center(
//                                     child: Text(
//                                       advisor.name,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold, fontSize: h * .018),
//                                     ),
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Text(
//                                     advisor.designation ?? 'null',
//                                     style: TextStyle(fontSize: h * .015),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 8.0, top: 4),
//                                   child: Text(
//                                     'Description : ${advisor.description ?? 'NULL'}',
//                                     softWrap: true,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       fontSize: h * .015,
//                                     ),
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 Container(
//                                   height: 30.h,
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.only(
//                                           bottomLeft: Radius.circular(10.r),
//                                           bottomRight: Radius.circular(10.r),
//                                         ),
//                                       ),
//                                       backgroundColor: Color(0xff005fcf),
//                                     ),
//                                     onPressed: () {
//                                       // Add your onPressed logic here
//                                     },
//                                     child: Center(
//                                       child: Text(
//                                         'View Details',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12.sp,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
// }
//


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:project_emergio/Views/detail%20page/advisor%20detail%20page.dart';

import '../Widgets/shimmer explore widget.dart';
import '../models/all profile model.dart';
import '../services/profile forms/advisor/advisor explore.dart';
import 'detail page/demo.dart';

class AdvisorExploreScreen extends StatefulWidget {
  final String searchQuery;

  const AdvisorExploreScreen({super.key, required this.searchQuery});

  @override
  _AdvisorExploreScreenState createState() => _AdvisorExploreScreenState();
}

class _AdvisorExploreScreenState extends State<AdvisorExploreScreen> {
  late Future<List<AdvisorExplr>?> _advisorsFuture;
  List<AdvisorExplr> _advisors = [];
  List<AdvisorExplr> _filteredAdvisors = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchQuery);
    _advisorsFuture = _fetchAdvisors();
  }

  Future<List<AdvisorExplr>?> _fetchAdvisors() async {
    try {
      final advisors = await AdvisorExplorePage.fetchAdvisorExplore();
      setState(() {
        _advisors = advisors ?? [];
        _filterAdvisors(); // Apply initial filter based on searchQuery
      });
      return _advisors;
    } catch (e) {
      // Handle the error, possibly show an error message
      return null;
    }
  }

  void _filterAdvisors() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredAdvisors = _advisors.where((advisor) {
        final nameLower = advisor.name.toLowerCase();
        final locationLower = advisor.location.toLowerCase();
        return nameLower.contains(query) || locationLower.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Advisor Explore'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.0.w, right: 10.w, top: 6.w, bottom: 6.w),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search advisors...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.black38),
                ),
              ),
              onChanged: (value) {
                _filterAdvisors();
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<AdvisorExplr>?>(
              future: _advisorsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ExploreShimmerWidget(width: 150, height: 150);
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No advisors available', style: TextStyle(fontSize: 18.sp)));
                } else {
                  // Check if there are no search results
                  if (_filteredAdvisors.isEmpty) {
                    return Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    );
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                    padding: EdgeInsets.all(8.0.w),
                    itemCount: _filteredAdvisors.length,
                    itemBuilder: (context, index) {
                      final advisor = _filteredAdvisors[index];
                      return  GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdvisorDetailPage(
                                advisor: advisor,
                              ),
                            ),
                          );
                        },

                        child: Card(
                          color: Colors.white,
                          elevation: 2,
                          child: Container(
                            width: w * .5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 88.h,
                                      decoration: BoxDecoration(
                                        color: Color(0xff3D3F54),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 20.h),
                                        child: Container(
                                          width: 105.h + 4, // Adjust for border width
                                          height: 105.h + 4, // Adjust for border width
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Color(0xff3D3F54), // Border color
                                              width: 3, // Border width
                                            ),
                                          ),
                                          child: ClipOval(
                                            child: Container(
                                              width: 110.h,
                                              height: 110.h,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(advisor.imageUrl),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 9),
                                  child: Center(
                                    child: Text(
                                      advisor.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: h * .018),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    advisor.designation ?? 'null',
                                    style: TextStyle(fontSize: h * .015),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 4),
                                  child: Text(
                                    'Description : ${advisor.description ?? 'NULL'}',
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: h * .015,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 30.h,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.r),
                                          bottomRight: Radius.circular(10.r),
                                        ),
                                      ),
                                      backgroundColor: Color(0xff005fcf),
                                    ),
                                    onPressed: () {
                                      // Add your onPressed logic here
                                    },
                                    child: Center(
                                      child: Text(
                                        'View Details',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
    }
}
