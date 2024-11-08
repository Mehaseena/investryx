// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:timeago/timeago.dart' as timeago;
// import '../services/profile forms/business/business explore.dart';
//
// class BusinessExplorePage extends StatefulWidget {
//   const BusinessExplorePage({super.key});
//
//   @override
//   State<BusinessExplorePage> createState() => _BusinessExplorePageState();
// }
//
// class _BusinessExplorePageState extends State<BusinessExplorePage> {
//   late Future<List<BusinessExplr>?> _businessesFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _businessesFuture = BusinessExplore.fetchBusinessExplore();
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
//           'Business for Sales',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
//         ),
//       ),
//       body: FutureBuilder<List<BusinessExplr>?>(
//         future: _businessesFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No businesses found.'));
//           }
//
//           final businesses = snapshot.data!;
//           return ListView(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(10.0.w),
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: businesses.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 2 / 3,
//                     mainAxisSpacing: 8.0.h,
//                     crossAxisSpacing: 8.0.w,
//                   ),
//                   itemBuilder: (context, index) {
//                     final business = businesses[index];
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:project_emergio/Widgets/shimmer%20explore%20widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../services/profile forms/business/business explore.dart';
import '../services/recent activities.dart';
import 'detail page/business deatil page.dart';

class BusinessExplorePage extends StatefulWidget {
  final String searchQuery;

  const BusinessExplorePage({super.key, required this.searchQuery});

  @override
  State<BusinessExplorePage> createState() => _BusinessExplorePageState();
}

class _BusinessExplorePageState extends State<BusinessExplorePage> {
  late Future<List<BusinessExplr>> _businessesFuture;
  List<BusinessExplr> _allBusinesses = [];
  List<BusinessExplr> _filteredBusinesses = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _businessesFuture = _fetchBusinesses();
    _searchController.text = widget.searchQuery;
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<BusinessExplr>> _fetchBusinesses() async {
    final businesses = await BusinessExplore.fetchBusinessExplore() ?? [];
    _allBusinesses = businesses;
    _filterBusinesses(widget.searchQuery);
    return businesses;
  }

  void _filterBusinesses(String query) {
    setState(() {
      _filteredBusinesses = _allBusinesses
          .where((business) =>
              business.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onSearchTextChanged() {
    _filterBusinesses(_searchController.text);
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
          'Business for Sales',
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
                hintText: 'Search businesses...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.black38),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<BusinessExplr>>(
              future: _businessesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ExploreShimmerWidget(width: 150, height: 150);
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (_filteredBusinesses.isEmpty) {
                  return Center(child: Text('No businesses found.'));
                }

                return ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0.w),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _filteredBusinesses.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 3,
                          mainAxisSpacing: 8.0.h,
                          crossAxisSpacing: 8.0.w,
                        ),
                        itemBuilder: (context, index) {
                          final business = _filteredBusinesses[index];
                      //    final businessUserId = business.user.toString();
                       //   print(businessUserId);
                          return GestureDetector(
                              onTap: () async {
                                await RecentActivities.recentActivities(
                                     productId: business.id
                                );
                                Navigator.push(
                                  context,

                                  MaterialPageRoute(
                                    builder: (context) => BusinessDetailPage(
                                      imageUrl: business.imageUrl,
                                      image2: business.image2,
                                      image3: business.image3,
                                      image4: business.image4,
                                      name: business.name,
                                      industry: business.industry,
                                      establish_yr: business.establish_yr,
                                      description: business.description,
                                      address_1: business.address_1,
                                      address_2: business.address_2,
                                      pin: business.pin,
                                      city: business.city,
                                      state: business.state,
                                      employees: business.employees,
                                      entity: business.entity,
                                      avg_monthly: business.avg_monthly,
                                      latest_yearly: business.latest_yearly,
                                      ebitda: business.ebitda,
                                      rate: business.rate,
                                      type_sale: business.type_sale,
                                      url: business.url,
                                      features: business.features,
                                      facility: business.facility,
                                      income_source: business.income_source,
                                      reason: business.reason,
                                      postedTime: business.postedTime,
                                      topSelling: business.topSelling,
                                      id: business.id,
                                   //   userId: businessUserId,
                                      showEditOption: false,
                                    ),
                                  ),
                                );

                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  side: BorderSide(color: Colors.black12),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    await RecentActivities.recentActivities(
                                  productId: business.id
                                    );
                                   // final businessUserId = business.user.toString();
                                   // print(businessUserId);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BusinessDetailPage(
                                          imageUrl: business.imageUrl,
                                              image2: business.image2,
                                              image3: business.image3,
                                              image4: business.image4,
                                          name: business.name,
                                          industry: business.industry,
                                          establish_yr: business.establish_yr,
                                          description: business.description,
                                          address_1: business.address_1,
                                          address_2: business.address_2,
                                          pin: business.pin,
                                          city: business.city,
                                          state: business.state,
                                          employees: business.employees,
                                          entity: business.entity,
                                          avg_monthly: business.avg_monthly,
                                          latest_yearly: business.latest_yearly,
                                          ebitda: business.ebitda,
                                          rate: business.rate,
                                          type_sale: business.type_sale,
                                          url: business.url,
                                          features: business.features,
                                          facility: business.facility,
                                          income_source: business.income_source,
                                          reason: business.reason,
                                          postedTime: business.postedTime,
                                          topSelling: business.topSelling,
                                              id: business.id,
                                              showEditOption: false,
                                            //  userId: businessUserId,

                                            ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: SizedBox(
                                          // width: 180,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.r)),
                                            child: Image.network(
                                              business.imageUrl,
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
                                          business.name,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.0.w),
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on,
                                                color: Colors.red, size: 14.sp),
                                            SizedBox(width: 4.w),
                                            Text(
                                              business.city,
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
                                                color: Colors.green,
                                                size: 14.sp),
                                            SizedBox(width: 4.w),
                                            Text(
                                              formatDateTime(
                                                  business.postedTime),
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
                                                bottomRight:
                                                    Radius.circular(10),
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
                              ));
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
