// import 'package:flutter/material.dart';
//
// class FeaturedListingScreen extends StatefulWidget {
//   const FeaturedListingScreen({super.key});
//
//   @override
//   State<FeaturedListingScreen> createState() => _FeaturedListingScreenState();
// }
//
// final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
// class _FeaturedListingScreenState extends State<FeaturedListingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Featured Listings',
//               style:
//                   TextStyle(fontWeight: FontWeight.bold, fontSize: h * 0.025),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: GridView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: 13,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 2 / 3,
//                 mainAxisSpacing: 8.0,
//                 crossAxisSpacing: 8.0,
//               ),
//               itemBuilder: (context, index) {
//                 //expert listing
//                 return Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(width: 2, color: Colors.black12),
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Image.asset("assets/coffeeday.png",
//                             height: h * 0.2),
//                       ),
//                       Text(
//                         "Cafe Cofee Day",
//                         style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.location_on,
//                             color: Colors.red,
//                             size: h * 0.02,
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             'Mumbai',
//                             style: TextStyle(fontSize: h * 0.013),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.access_time,
//                             color: Colors.green,
//                             size: h * 0.016,
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                               ''
//                               'Posted Just Now',
//                               style: TextStyle(fontSize: h * 0.013))
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(right: 6.0),
//                             child: Text('View >'),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//                 //
//               },
//             ),
//           ),
//         ],
//       ),
//       // Center(
//       //   child: Column(
//       //     mainAxisAlignment: MainAxisAlignment.center,
//       //     children: [
//       //       Text('Your Wishlist is Empty',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
//       //       SizedBox(height: 8,),
//       //       Text(textAlign: TextAlign.center,'It seems like you haven’t added any\nbusiness to your wishlist',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
//       //     ],
//       //   ),
//       // ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_emergio/services/featured.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../models/all profile model.dart';
import '../services/recent activities.dart';
import 'detail page/business deatil page.dart';
import 'detail page/franchise detail page.dart';
import 'detail page/invester detail page.dart';

class FeaturedListingScreen extends StatefulWidget {
  const FeaturedListingScreen({super.key});

  @override
  State<FeaturedListingScreen> createState() => _FeaturedListingScreenState();
}

class _FeaturedListingScreenState extends State<FeaturedListingScreen> {
  List<FeaturedDetails>? featuredItems;
  List<BusinessInvestorExplr>? _ftrAllItems; // Updated to List<ProductDetails>
  List<FranchiseExplr>? _ftrFranchiseItems;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFeaturedListings();
  }

  Future<void> _loadFeaturedListings() async {
    String type = "";
    final data = await Featured.fetchFeaturedData(type);
    setState(() {
      featuredItems = data!['featured'];
      _ftrAllItems = data!['featuredAll'];
      _ftrFranchiseItems = data!['featuredFranchiseItems'];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? _buildShimmerLoading(h)
          : ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Featured Listings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: h * 0.025,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: featuredItems?.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                var item = featuredItems![index];
                return InkWell(
                  onTap: () async {
                    await RecentActivities.recentActivities(
                        productId: item.id);
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
                    else if (item.type == 'investor') {
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
                            image2: _ftrAllItems![index].image2,
                            image3: _ftrAllItems![index].image3,
                            image4: _ftrAllItems![index].image4,
                          ),
                        ),
                      );
                    }                    else if(item.type == 'franchise') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FranchiseDetailPage(
                            id: _ftrFranchiseItems![index].id,
                            imageUrl: _ftrFranchiseItems![index].imageUrl,
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
                            image2: _ftrFranchiseItems![index].image2,
                            image3: _ftrFranchiseItems![index].image3,
                            image4: _ftrFranchiseItems![index].image4,
                            showEditOption: false,
                          ),
                        ),
                      );

                    }
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 2,
                    child: Container(
                      width: w * .5, // Set the width for each item
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading(double h) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Featured Listings',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: h * 0.025,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 6, // Number of shimmer items to show
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black12),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            height: h * 0.2,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: 20,
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(vertical: 8),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Container(
                              height: 10,
                              width: 60,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Container(
                              height: 10,
                              width: 60,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: Container(
                                height: 10,
                                width: 50,
                                color: Colors.white,
                              ),
                            )
                          ],
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

  String formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    return timeago.format(dateTime, allowFromNow: true);
  }
}
