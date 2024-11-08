// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:timeago/timeago.dart' as timeago;
//
// import '../services/profile forms/franchise/franchise explore.dart';
//
//
// class FranchiseExploreScreen extends StatefulWidget {
//   const FranchiseExploreScreen({super.key});
//
//   @override
//   State<FranchiseExploreScreen> createState() => _FranchiseExploreScreenState();
// }
//
// class _FranchiseExploreScreenState extends State<FranchiseExploreScreen> {
//
//   late Future<List<FranchiseExplr>?> _franchiseFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _franchiseFuture = FranchiseExplore.fetchFranchiseData();
//   }
//
//   String formatDateTime(String dateTimeStr) {
//     DateTime dateTime = DateTime.parse(dateTimeStr);
//     return timeago.format(dateTime, allowFromNow: true);
//   }
//
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
//           'Franchises',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
//         ),
//       ),
//       body: FutureBuilder<List<FranchiseExplr>?>(
//         future: _franchiseFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No businesses found.'));
//           }
//
//           final franchises = snapshot.data!;
//           return ListView(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(10.0.w),
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: franchises.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 2 / 3,
//                     mainAxisSpacing: 8.0.h,
//                     crossAxisSpacing: 8.0.w,
//                   ),
//                   itemBuilder: (context, index) {
//                     final franchise = franchises[index];
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
//                                     franchise.imageUrl,
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
//                                 franchise.brandName,
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
//                                     franchise.city,
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
//                                     formatDateTime(franchise.postedTime),
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
import 'package:project_emergio/services/recent%20activities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../Widgets/shimmer explore widget.dart';
import '../services/profile forms/franchise/franchise explore.dart';
import 'detail page/franchise detail page.dart';

class FranchiseExplorePage extends StatefulWidget {
  final String searchQuery;

  const FranchiseExplorePage({super.key, required this.searchQuery});

  @override
  State<FranchiseExplorePage> createState() => _FranchiseExplorePageState();
}

class _FranchiseExplorePageState extends State<FranchiseExplorePage> {
  late Future<List<FranchiseExplr>> _franchisesFuture;
  List<FranchiseExplr> _allFranchises = [];
  List<FranchiseExplr> _filteredFranchises = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _franchisesFuture = _fetchFranchises();
    _searchController.text = widget.searchQuery;
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<FranchiseExplr>> _fetchFranchises() async {
    final franchises = await FranchiseExplore.fetchFranchiseData() ?? [];
    _allFranchises = franchises;
    _filterFranchises(widget.searchQuery);
    return franchises;
  }

  void _filterFranchises(String query) {
    setState(() {
      _filteredFranchises = _allFranchises
          .where((franchise) =>
              franchise.brandName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onSearchTextChanged() {
    _filterFranchises(_searchController.text);
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
          'Franchises',
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
                hintText: 'Search franchises...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.black38),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<FranchiseExplr>>(
              future: _franchisesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ExploreShimmerWidget(width: 150, height: 150);
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (_filteredFranchises.isEmpty) {
                  return Center(child: Text('No franchises found.'));
                }

                return Padding(
                  padding: EdgeInsets.all(10.0.w),
                  child: GridView.builder(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: _filteredFranchises.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 8.0.h,
                      crossAxisSpacing: 8.0.w,
                    ),
                    itemBuilder: (context, index) {
                      final franchise = _filteredFranchises[index];
                      var franchiseData = _filteredFranchises![index];
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          side: BorderSide(color: Colors.black12),
                        ),
                        child: InkWell(
                          onTap: () async {
                            await RecentActivities.recentActivities(
                                productId: franchiseData.id
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FranchiseDetailPage(
                                  id: franchiseData.id,
                                  imageUrl: franchiseData.imageUrl,
                                  brandName: franchiseData.brandName,
                                  city: franchiseData.city,
                                  postedTime: franchiseData.postedTime,
                                  state: franchiseData.state,
                                  industry: franchiseData.industry,
                                  description: franchiseData.description,
                                  url: franchiseData.url,
                                  initialInvestment:
                                      franchiseData.initialInvestment,
                                  projectedRoi: franchiseData.projectedRoi,
                                  iamOffering: franchiseData.iamOffering,
                                  currentNumberOfOutlets:
                                      franchiseData.currentNumberOfOutlets,
                                  franchiseTerms: franchiseData.franchiseTerms,
                                  locationsAvailable:
                                      franchiseData.locationsAvailable,
                                  kindOfSupport: franchiseData.kindOfSupport,
                                  allProducts: franchiseData.allProducts,
                                  brandStartOperation:
                                      franchiseData.brandStartOperation,
                                  spaceRequiredMin:
                                      franchiseData.spaceRequiredMin,
                                  spaceRequiredMax:
                                      franchiseData.spaceRequiredMax,
                                  totalInvestmentFrom:
                                      franchiseData.totalInvestmentFrom,
                                  totalInvestmentTo:
                                      franchiseData.totalInvestmentTo,
                                  brandFee: franchiseData.brandFee,
                                  avgNoOfStaff: franchiseData.avgNoOfStaff,
                                  avgMonthlySales:
                                      franchiseData.avgMonthlySales,
                                  avgEBITDA: franchiseData.avgEBITDA,
                                  showEditOption: false,
                                  image2: franchiseData.image2,
                                  image3: franchiseData.image3,
                                  image4: franchiseData.image4,
                                ),
                              ),
                            );

                            await RecentActivities.recentActivities(
                               productId: franchiseData.id
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: SizedBox(
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.r)),
                                    child: Image.network(
                                      franchise.imageUrl,
                                      height: 140.h,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 6.0.w, bottom: 3.w),
                                child: Text(
                                  franchise.brandName,
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
                                      franchise.locationsAvailable!,
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
                                      formatDateTime(franchise.postedTime),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
