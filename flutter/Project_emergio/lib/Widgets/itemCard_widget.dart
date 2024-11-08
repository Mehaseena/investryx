// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:project_emergio/services/featured.dart';
// import 'package:shimmer/shimmer.dart';
// import '../Views/detail page/business deatil page.dart';
// import '../Views/detail page/demo.dart';
// import 'package:timeago/timeago.dart' as timeago;
//
// import '../Views/detail page/franchise detail page.dart';
// import '../Views/detail page/invester detail page.dart';
//
// class FeaturedListingWidget extends StatefulWidget {
//   const FeaturedListingWidget({super.key});
//
//   @override
//   State<FeaturedListingWidget> createState() => _FeaturedListingWidgetState();
// }
//
// class _FeaturedListingWidgetState extends State<FeaturedListingWidget> {
//
//   List<FeaturedDetails>? FeaturedItems;
//   List<BusinessInvestorExplr>? _ftrAllItems; // Updated to List<ProductDetails>
//   List<FranchiseExplrFtr>? _ftrFranchiseItems;
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadFeaturedAds();
//   }
//
//   Future<void> _loadFeaturedAds() async {
//     String type;
//     final data = await Featured.fetchFeaturedData(type="");
//     setState(() {
//       FeaturedItems = data!['featured'];
//       _ftrAllItems = data!['featuredAll'];
//       _ftrFranchiseItems = data!['featuredFranchiseItems'];
//       _isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return SizedBox(
//       height: h * .355,
//       child: _isLoading
//           ? ListView.builder(
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         itemCount: 5, // Number of shimmer items to show
//         itemBuilder: (context, index) {
//           return Shimmer.fromColors(
//             baseColor: Colors.grey[300]!,
//             highlightColor: Colors.grey[100]!,
//             child: Container(
//               width: w * .5, // Set the width for each item
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                 border: Border.all(color: Colors.black12),
//               ),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 140.h,
//
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.black26)
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 20.h,
//                     width: w * .5 - 16,
//                     color: Colors.white,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0, top: 10),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.location_on,
//                           color: Colors.white,
//                           size: h * 0.018,
//                         ),
//                         SizedBox(width: 5),
//                         Container(
//                           height: 20.h,
//                           width: 60,
//                           color: Colors.white,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Icon(
//                           CupertinoIcons.time,
//                           color: Colors.white,
//                           size: h * 0.018,
//                         ),
//                         SizedBox(width: 5),
//                         Container(
//                           height: 20.h,
//                           width: 60,
//                           color: Colors.white,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       )
//           : ListView.builder(
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         itemCount: FeaturedItems?.length ?? 0,
//         itemBuilder: (context, index) {
//           var item = FeaturedItems![index];
//           return GestureDetector(
//             onTap: () {
//               if(item.type == 'business'){
//                 print(_ftrAllItems);
//                 Navigator.push(context,
//                   MaterialPageRoute(
//                     builder: (context) => BusinessDetailPage(
//                       imageUrl: _ftrAllItems![index].imageUrl,
//                       name: _ftrAllItems![index].name,
//                       industry: _ftrAllItems![index].industry,
//                       establish_yr: _ftrAllItems![index].establish_yr,
//                       description: _ftrAllItems![index].description,
//                       address_1: _ftrAllItems![index].address_1,
//                       address_2: _ftrAllItems![index].address_2,
//                       pin: _ftrAllItems![index].pin,
//                       city: _ftrAllItems![index].city,
//                       state: _ftrAllItems![index].state,
//                       employees: _ftrAllItems![index].employees,
//                       entity: _ftrAllItems![index].entity,
//                       avg_monthly: _ftrAllItems![index].avg_monthly,
//                       latest_yearly: _ftrAllItems![index].latest_yearly,
//                       ebitda: _ftrAllItems![index].ebitda,
//                       rate: _ftrAllItems![index].rate,
//                       type_sale: _ftrAllItems![index].type_sale,
//                       url: _ftrAllItems![index].url,
//                       features: _ftrAllItems![index].features,
//                       facility: _ftrAllItems![index].facility,
//                       income_source: _ftrAllItems![index].income_source,
//                       reason: _ftrAllItems![index].reason,
//                       postedTime: _ftrAllItems![index].postedTime,
//                       topSelling: _ftrAllItems![index].topSelling,
//                       id: _ftrAllItems![index].id,
//                       showEditOption: false,
//                     ),
//                   ),
//                 );
//               }
//               else if(item.type == 'investor'){
//                 print(_ftrAllItems);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => InvestorDetailPage(
//                       imageUrl: _ftrAllItems![index].imageUrl,
//                       name: _ftrAllItems![index].name,
//                       city: _ftrAllItems![index].city,
//                       postedTime: _ftrAllItems![index].postedTime,
//                       state: _ftrAllItems![index].state,
//                       industry: _ftrAllItems![index].industry,
//                       description: _ftrAllItems![index].description,
//                       url: _ftrAllItems![index].url,
//                       rangeStarting: _ftrAllItems![index].rangeStarting,
//                       rangeEnding: _ftrAllItems![index].rangeEnding,
//                       evaluatingAspects:
//                       _ftrAllItems![index].evaluatingAspects,
//                       CompanyName: _ftrAllItems![index].companyName,
//                       locationInterested: _ftrAllItems![index].locationIntrested,
//                       id: _ftrAllItems![index].id,
//                       showEditOption: false,
//                     ),
//                   ),
//                 );
//               }
//               else if(item.type == 'franchise') {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => FranchiseDetailPage(
//                       id: _ftrFranchiseItems![index].id,
//                       imageUrl: _ftrFranchiseItems![index].imageUrl,
//                       brandName: _ftrFranchiseItems![index].brandName,
//                       city: _ftrFranchiseItems![index].city,
//                       postedTime: _ftrFranchiseItems![index].postedTime,
//                       state: _ftrFranchiseItems![index].state,
//                       industry: _ftrFranchiseItems![index].industry,
//                       description: _ftrFranchiseItems![index].description,
//                       url: _ftrFranchiseItems![index].url,
//                       initialInvestment:
//                       _ftrFranchiseItems![index].initialInvestment,
//                       projectedRoi: _ftrFranchiseItems![index].projectedRoi,
//                       iamOffering: _ftrFranchiseItems![index].iamOffering,
//                       currentNumberOfOutlets:
//                       _ftrFranchiseItems![index].currentNumberOfOutlets,
//                       franchiseTerms: _ftrFranchiseItems![index].franchiseTerms,
//                       locationsAvailable:
//                       _ftrFranchiseItems![index].locationsAvailable,
//                       kindOfSupport: _ftrFranchiseItems![index].kindOfSupport,
//                       allProducts: _ftrFranchiseItems![index].allProducts,
//                       brandStartOperation:
//                       _ftrFranchiseItems![index].brandStartOperation,
//                       spaceRequiredMin:
//                       _ftrFranchiseItems![index].spaceRequiredMin,
//                       spaceRequiredMax:
//                       _ftrFranchiseItems![index].spaceRequiredMax,
//                       totalInvestmentFrom:
//                       _ftrFranchiseItems![index].totalInvestmentFrom,
//                       totalInvestmentTo:
//                       _ftrFranchiseItems![index].totalInvestmentTo,
//                       brandFee: _ftrFranchiseItems![index].brandFee,
//                       avgNoOfStaff: _ftrFranchiseItems![index].avgNoOfStaff,
//                       avgMonthlySales:
//                       _ftrFranchiseItems![index].avgMonthlySales,
//                       avgEBITDA: _ftrFranchiseItems![index].avgEBITDA,
//                       showEditOption: false,
//                     ),
//                   ),
//                 );
//
//               }
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: Card(
//                 color: Colors.white,
//                 elevation: 2,
//                 child: Container(
//                   width: w * .5, // Set the width for each item
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     border: Border.all(color: Colors.black12),
//                   ),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           height: h * 0.16,
//                           decoration: BoxDecoration(
//                             color: Colors.black12,
//                             image: DecorationImage(
//                               image: NetworkImage(item.imageUrl),
//                               fit: BoxFit.cover,
//                             ),
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                           ),
//                         ),
//                       ),
//                       Text(item.name,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: h * .017),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0, top: 10),
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               'assets/loc.png',
//                               height: h * 0.018,
//                             ),
//                             SizedBox(width: 5),
//                             Text(item.city,
//                               style: TextStyle(fontSize: h * .015),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             Icon(
//                               CupertinoIcons.time,
//                               color: Colors.green,
//                               size: h * 0.018,
//                             ),
//                             SizedBox(width: 5),
//                             Text(formatDateTime(item.postedTime),
//                               style: TextStyle(fontSize: h * .015),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                             EdgeInsets.only(right: w * 0.04, top: h * 0.005),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(''),
//                             Text(
//                               'View >',
//                               style: TextStyle(
//                                   fontSize: h * 0.014,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//   String formatDateTime(String dateTimeStr) {
//     DateTime dateTime = DateTime.parse(dateTimeStr);
//     return timeago.format(dateTime, allowFromNow: true);
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:project_emergio/services/featured.dart';
import 'package:shimmer/shimmer.dart';
import '../Views/detail page/business deatil page.dart';
import '../Views/detail page/demo.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../Views/detail page/franchise detail page.dart';
import '../Views/detail page/invester detail page.dart';
import '../models/all profile model.dart';
import '../services/recent activities.dart';

class FeaturedListingWidget extends StatefulWidget {
  const FeaturedListingWidget({super.key});

  @override
  State<FeaturedListingWidget> createState() => _FeaturedListingWidgetState();
}

class _FeaturedListingWidgetState extends State<FeaturedListingWidget> {
  List<FeaturedDetails>? FeaturedItems;
  List<BusinessInvestorExplr>? _ftrAllItems;
  List<FranchiseExplr>? _ftrFranchiseItems;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadFeaturedAds();
  }

  Future<void> _loadFeaturedAds() async {
    try {
      String type;
      final data = await Featured.fetchFeaturedData(type="");
      setState(() {
        FeaturedItems = data!['featured'];
        _ftrAllItems = data['featuredAll'];
        _ftrFranchiseItems = data['featuredFranchiseItems'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    if (_isLoading) {
      return _buildShimmerList(h, w);
    }

    if (_hasError) {
      return _buildErrorMessage(h);
    }

    if ((FeaturedItems?.isEmpty ?? true) &&
        (_ftrAllItems?.isEmpty ?? true) &&
        (_ftrFranchiseItems?.isEmpty ?? true)) {
      return _buildNoDataMessage(h);
    }

    return SizedBox(
      height: h * .355,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: FeaturedItems?.length ?? 0,
        itemBuilder: (context, index) {
          var item = FeaturedItems![index];
          return _buildFeaturedItem(context, item, index, h, w);
        },
      ),
    );
  }

  Widget _buildShimmerList(double h, double w) {
    return SizedBox(
      height: h * .355,
      child: ListView.builder(
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
                          border: Border.all(color: Colors.black26)
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
      ),
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
            // Icon(Icons.sentiment_dissatisfied_outlined, size: 43.h, color: Colors.black),
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

  Widget _buildFeaturedItem(BuildContext context, FeaturedDetails item, int index, double h, double w) {
    return GestureDetector(
      onTap: () async {
        await RecentActivities.recentActivities(
            productId: item.id
        );
        if(item.type == 'business'){
          print(_ftrAllItems);
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => BusinessDetailPage(
                imageUrl: _ftrAllItems![index].imageUrl,
                image2: _ftrAllItems![index].image2,
                image3: _ftrAllItems![index].image3,
                image4: _ftrAllItems![index].image4,
                name: _ftrAllItems![index].name,
                industry: _ftrAllItems![index].industry,
                establish_yr: _ftrAllItems![index].establish_yr,
                description: _ftrAllItems![index].description,
                address_1: _ftrAllItems![index].address_1,
                address_2: _ftrAllItems![index].address_2,
                pin: _ftrAllItems![index].pin,
                city: _ftrAllItems![index].city,
                state: _ftrAllItems![index].state,
                employees: _ftrAllItems![index].employees,
                entity: _ftrAllItems![index].entity,
                avg_monthly: _ftrAllItems![index].avg_monthly,
                latest_yearly: _ftrAllItems![index].latest_yearly,
                ebitda: _ftrAllItems![index].ebitda,
                rate: _ftrAllItems![index].rate,
                type_sale: _ftrAllItems![index].type_sale,
                url: _ftrAllItems![index].url,
                features: _ftrAllItems![index].features,
                facility: _ftrAllItems![index].facility,
                income_source: _ftrAllItems![index].income_source,
                reason: _ftrAllItems![index].reason,
                postedTime: _ftrAllItems![index].postedTime,
                topSelling: _ftrAllItems![index].topSelling,
                id: _ftrAllItems![index].id,
                showEditOption: false,
              ),
            ),
          );
        }
        else if(item.type == 'investor') {
          print(_ftrAllItems);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InvestorDetailPage(
                imageUrl: _ftrAllItems![index].imageUrl,
                name: _ftrAllItems![index].name,
                city: _ftrAllItems![index].city,
                postedTime: _ftrAllItems![index].postedTime,
                state: _ftrAllItems![index].state,
                industry: _ftrAllItems![index].industry,
                description: _ftrAllItems![index].description,
                url: _ftrAllItems![index].url,
                rangeStarting: _ftrAllItems![index].rangeStarting,
                rangeEnding: _ftrAllItems![index].rangeEnding,
                evaluatingAspects: _ftrAllItems![index].evaluatingAspects,
                CompanyName: _ftrAllItems![index].companyName,
                locationInterested: _ftrAllItems![index].locationIntrested,
                id: _ftrAllItems![index].id,
                showEditOption: false,
                image2: _ftrAllItems![index].image2 ?? '',
                image3: _ftrAllItems![index].image3 ?? '',
                image4: _ftrAllItems![index].image4,
              ),
            ),
          );
        }
        else if(item.type == 'franchise') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FranchiseDetailPage(
                id: _ftrFranchiseItems![index].id,
                imageUrl: _ftrFranchiseItems![index].imageUrl,
                image2: _ftrFranchiseItems![index].image2,
                image3: _ftrFranchiseItems![index].image3,
                image4: _ftrFranchiseItems![index].image4,
                brandName: _ftrFranchiseItems![index].brandName,
                city: _ftrFranchiseItems![index].city,
                postedTime: _ftrFranchiseItems![index].postedTime,
                state: _ftrFranchiseItems![index].state,
                industry: _ftrFranchiseItems![index].industry,
                description: _ftrFranchiseItems![index].description,
                url: _ftrFranchiseItems![index].url,
                initialInvestment:
                _ftrFranchiseItems![index].initialInvestment,
                projectedRoi: _ftrFranchiseItems![index].projectedRoi,
                iamOffering: _ftrFranchiseItems![index].iamOffering,
                currentNumberOfOutlets:
                _ftrFranchiseItems![index].currentNumberOfOutlets,
                franchiseTerms: _ftrFranchiseItems![index].franchiseTerms,
                locationsAvailable:
                _ftrFranchiseItems![index].locationsAvailable,
                kindOfSupport: _ftrFranchiseItems![index].kindOfSupport,
                allProducts: _ftrFranchiseItems![index].allProducts,
                brandStartOperation:
                _ftrFranchiseItems![index].brandStartOperation,
                spaceRequiredMin:
                _ftrFranchiseItems![index].spaceRequiredMin,
                spaceRequiredMax:
                _ftrFranchiseItems![index].spaceRequiredMax,
                totalInvestmentFrom:
                _ftrFranchiseItems![index].totalInvestmentFrom,
                totalInvestmentTo:
                _ftrFranchiseItems![index].totalInvestmentTo,
                brandFee: _ftrFranchiseItems![index].brandFee,
                avgNoOfStaff: _ftrFranchiseItems![index].avgNoOfStaff,
                avgMonthlySales:
                _ftrFranchiseItems![index].avgMonthlySales,
                avgEBITDA: _ftrFranchiseItems![index].avgEBITDA,
                showEditOption: false,
              ),
            ),
          );

        }
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          color: Colors.white,
          elevation: 2,
          child: Container(
            width: w * .5,
            height: 140.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 145.h,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      image: DecorationImage(
                        image: NetworkImage(item.imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                Text(
                  item.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: h * .017),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/loc.png',
                        height: h * 0.018,
                      ),
                      SizedBox(width: 5),
                      Text(
                        item.city,
                        style: TextStyle(fontSize: h * .015),
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
                        color: Colors.green,
                        size: h * 0.018,
                      ),
                      SizedBox(width: 5),
                      Text(
                        formatDateTime(item.postedTime),
                        style: TextStyle(fontSize: h * .015),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    return timeago.format(dateTime, allowFromNow: true);
  }
}