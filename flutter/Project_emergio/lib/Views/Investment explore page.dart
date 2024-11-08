// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:project_emergio/Views/Investment%20explore%20page.dart';
// import 'package:timeago/timeago.dart' as timeago;
//
// import '../services/profile forms/investor/investor explore.dart';
//
//
// class InvestorExplorePage extends StatefulWidget {
//   const InvestorExplorePage({super.key});
//
//   @override
//   State<InvestorExplorePage> createState() => _InvestorExplorePageState();
// }
//
// class _InvestorExplorePageState extends State<InvestorExplorePage> {
//   late Future<List<InvestorExplr>?> _investmentFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _investmentFuture = InvestorExplore.fetchInvestorData();
//   }
//
//   String formatDateTime(String dateTimeStr) {
//     DateTime dateTime = DateTime.parse(dateTimeStr);
//     return timeago.format(dateTime, allowFromNow: true);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, size: 24.sp),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           'Investment Opportunities',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
//         ),
//       ),
//       body: FutureBuilder<List<InvestorExplr>?>(
//         future: _investmentFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No Investment data found.'));
//           }
//
//           final Investments = snapshot.data!;
//           return ListView(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(10.0.w),
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: Investments.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 2 / 3,
//                     mainAxisSpacing: 8.0.h,
//                     crossAxisSpacing: 8.0.w,
//                   ),
//                   itemBuilder: (context, index) {
//                     final business = Investments[index];
//                     return Card(
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.r),
//                           side: BorderSide(color: Colors.black12)
//                       ),
//                       child: InkWell(
//                         onTap: () {
//                           // Add your navigation or action here
//                         },
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(6.0),
//                               child: SizedBox(
//                                 // width: 180,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.all(Radius.circular(8.r)),
//                                   child:  Image.network(
//                                     business.imageUrl,
//                                     height: 140.h,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(left: 6.0.w,bottom: 3.w),
//                               child: Text(
//                                 business.name,
//                                 style: TextStyle(
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 6.0.w),
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.location_on, color: Colors.red, size: 14.sp),
//                                   SizedBox(width: 4.w),
//                                   Text(
//                                     business.city,
//                                     style: TextStyle(fontSize: 12.sp),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 4.0.h),
//                               child: Row(
//                                 children: [
//                                   Icon(Icons.access_time, color: Colors.green, size: 14.sp),
//                                   SizedBox(width: 4.w),
//                                   Text(
//                                     formatDateTime(business.postedTime),
//                                     style: TextStyle(fontSize: 12.sp),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Spacer(),
//                             Container(
//                               height:29.h,
//                               child: ElevatedButton(
//                                 style:ElevatedButton.styleFrom(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
//                                   ),
//                                   backgroundColor: Color(0xff005fcf),
//                                 ),
//                                 onPressed: () {
//                                   // Add your onPressed logic here
//                                 },
//                                 child: Center(
//                                   child: Text(
//                                     'View Details',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 12.sp,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../Widgets/shimmer explore widget.dart';
import '../services/profile forms/investor/investor explore.dart';
import '../services/recent activities.dart';
import 'detail page/invester detail page.dart';

class InvestorExplorePage extends StatefulWidget {
  final String searchQuery;

  const InvestorExplorePage({super.key, required this.searchQuery});

  @override
  State<InvestorExplorePage> createState() => _InvestorExplorePageState();
}

class _InvestorExplorePageState extends State<InvestorExplorePage> {
  late Future<List<InvestorExplr>> _investmentsFuture;
  List<InvestorExplr> _allInvestments = [];
  List<InvestorExplr> _filteredInvestments = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _investmentsFuture = _fetchInvestments();
    _searchController.text = widget.searchQuery;
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<InvestorExplr>> _fetchInvestments() async {
    final investments = await InvestorExplore.fetchInvestorData() ?? [];
    _allInvestments = investments;
    _filterInvestments(widget.searchQuery);
    return investments;
  }

  void _filterInvestments(String query) {
    setState(() {
      _filteredInvestments = _allInvestments
          .where((investment) =>
              investment.companyName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onSearchTextChanged() {
    _filterInvestments(_searchController.text);
  }

  String formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    return timeago.format(dateTime, allowFromNow: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24.sp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Investment Opportunities',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0.w),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search investments...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.black38),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<InvestorExplr>>(
              future: _investmentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ExploreShimmerWidget(width: 150, height: 150);
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (_filteredInvestments.isEmpty) {
                  return Center(child: Text('No investments found.'));
                }

                return ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0.w),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _filteredInvestments.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 3,
                          mainAxisSpacing: 8.0.h,
                          crossAxisSpacing: 8.0.w,
                        ),
                        itemBuilder: (context, index) {
                          final   investment = _filteredInvestments[index];
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              side: BorderSide(color: Colors.black12),
                            ),
                            child: InkWell(
                              onTap: () async {
                                await RecentActivities.recentActivities(
                                    productId: investment.id
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InvestorDetailPage(
                                      imageUrl: investment.imageUrl,
                                      name: investment.name,
                                      city: investment.city,
                                      postedTime: investment.postedTime,
                                      state: investment.state,
                                      industry: investment.industry,
                                      description: investment.description,
                                      url: investment.url,
                                      rangeStarting: investment.rangeStarting,
                                      rangeEnding: investment.rangeEnding,
                                      evaluatingAspects: investment.evaluatingAspects,
                                      CompanyName: investment.companyName,
                                      locationInterested: investment.locationIntrested,
                                      id: investment.id,
                                      showEditOption: false,
                                      image2: investment.image2,
                                      image3: investment.image3,
                                      image4: investment.image4,
                                    ),
                                  ),
                                );                                await RecentActivities.recentActivities(
                                   productId: investment.id
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: SizedBox(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.r)),
                                        child: Image.network(
                                          investment.imageUrl,
                                          height: 140.h,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 6.0.w, bottom: 3.w),
                                    child: Text(
                                      investment.companyName!,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.0.w),
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on,
                                            color: Colors.red, size: 14.sp),
                                        SizedBox(width: 4.w),
                                        Text(
                                          investment.city,
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6.0.w, vertical: 4.0.h),
                                    child: Row(
                                      children: [
                                        Icon(Icons.access_time,
                                            color: Colors.green, size: 14.sp),
                                        SizedBox(width: 4.w),
                                        Text(
                                          formatDateTime(investment.postedTime),
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 29.h,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
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
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
