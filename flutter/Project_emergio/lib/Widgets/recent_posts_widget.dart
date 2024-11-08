// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:project_emergio/models/all%20profile%20model.dart';
// import 'package:timeago/timeago.dart' as timeago;
//
// import '../services/latest transactions and activites.dart';
//
// class LatestActivitiesList extends StatefulWidget {
//   final String profile;
//   const LatestActivitiesList({Key? key, required this.profile})
//       : super(key: key);
//   @override
//   _LatestActivitiesListState createState() => _LatestActivitiesListState();
// }
//
// class _LatestActivitiesListState extends State<LatestActivitiesList> {
//   List<LatestActivites>? _activities;
//   List<BusinessInvestorExplr> _recentBusiness = [];
//   List<FranchiseExplr> _recentFranchise = [];
//   List<AdvisorExplr> _recentAdvisor = [];
//   bool _isLoading = true;
//   String? _error;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchActivities();
//   }
//
//   Future<void> _fetchActivities() async {
//     try {
//       String item = widget.profile == "business"
//           ? "investor"
//           : widget.profile == "investor"
//           ? "business"
//           : widget.profile == "franchise"
//           ? "franchise"
//           :widget.profile == "advisor" ? "advisor"
//           : "";
//
//       final data = await LatestTransactions.fetchRecentPosts(item);
//       if (data != null) {
//         fetchRecent(data);
//       } else {
//         print("Rceents lists is empty");
//       }
//       // if (widget.profile == "") {
//       //   _activities = await LatestTransactions.fetchLatestTransactions();
//       //   setState(() {});
//       // } else {
//       //   if (data != null) {
//       //     fetchRecent(data);
//       //   }
//       // }
//
//       _isLoading = false;
//     } catch (e) {
//       setState(() {
//         _error = 'Failed to load activities';
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> fetchRecent(Map<String, dynamic> data) async {
//     switch (widget.profile) {
//       case "business":
//         setState(() {
//           _recentBusiness = data["investor_data"];
//         });
//         break;
//
//       case "investor":
//         setState(() {
//           _recentBusiness = data["business_data"];
//         });
//         break;
//       case "franchise":
//         setState(() {
//           _recentFranchise = data["franchise_data"];
//         });
//         break;
//       default:
//         setState(() {
//           _activities = data["home_data"];
//         });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(left: 16.0, right: 16, top: 8, bottom: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Recent Post',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 'See all',
//                 style: TextStyle(
//                   color: Colors.amber,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (_isLoading)
//           Center(child: CircularProgressIndicator())
//         else if (_error != null)
//           Center(child: Text(_error!))
//         else if (widget.profile == "business" &&
//               _recentBusiness != null &&
//               _recentBusiness.isEmpty)
//             Center(child: Text('No posts available'))
//           else if (widget.profile == "investor" &&
//                 _recentBusiness != null &&
//                 _recentBusiness.isEmpty)
//               Center(child: Text('No posts available'))
//             else if (widget.profile == "franchise" &&
//                   _recentFranchise != null &&
//                   _recentFranchise.isEmpty)
//                 Center(child: Text('No posts available'))
//               else if (widget.profile == "business" || widget.profile == "investor")
//                   CarouselSlider.builder(
//                     itemCount: _recentBusiness.length,
//                     itemBuilder: (context, index, realIndex) {
//                       return ActivityCard(
//                         business: _recentBusiness[index],
//                         profile: widget.profile,
//                       );
//                     },
//                     options: CarouselOptions(
//                       height: 230.h,
//                       viewportFraction: 0.65,
//                       enlargeCenterPage: true,
//                       autoPlay: true,
//                       autoPlayInterval: Duration(seconds: 3),
//                       autoPlayAnimationDuration: Duration(milliseconds: 800),
//                       autoPlayCurve: Curves.fastOutSlowIn,
//                     ),
//                   )
//                 else if (widget.profile == "franchise")
//                     CarouselSlider.builder(
//                       itemCount: _recentFranchise.length,
//                       itemBuilder: (context, index, realIndex) {
//                         return ActivityCard(
//                           franchise: _recentFranchise[index],
//                           profile: "franchise",
//                         );
//                       },
//                       options: CarouselOptions(
//                         height: 230.h,
//                         viewportFraction: 0.65,
//                         enlargeCenterPage: true,
//                         autoPlay: true,
//                         autoPlayInterval: Duration(seconds: 3),
//                         autoPlayAnimationDuration: Duration(milliseconds: 800),
//                         autoPlayCurve: Curves.fastOutSlowIn,
//                       ),
//                     )
//                   else
//                     CarouselSlider.builder(
//                       itemCount: _activities!.length,
//                       itemBuilder: (context, index, realIndex) {
//                         return ActivityCard(
//                           activity: _activities![index],
//                           profile: "",
//                         );
//                       },
//                       options: CarouselOptions(
//                         height: 230.h,
//                         viewportFraction: 0.65,
//                         enlargeCenterPage: true,
//                         autoPlay: true,
//                         autoPlayInterval: Duration(seconds: 3),
//                         autoPlayAnimationDuration: Duration(milliseconds: 800),
//                         autoPlayCurve: Curves.fastOutSlowIn,
//                       ),
//                     )
//       ],
//     );
//   }
// }
//
// class ActivityCard extends StatelessWidget {
//   final LatestActivites? activity;
//   final BusinessInvestorExplr? business;
//   final FranchiseExplr? franchise;
//   final String profile;
//
//   const ActivityCard(
//       {Key? key,
//         this.activity,
//         this.business,
//         this.franchise,
//         required this.profile})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final item = profile == "franchise" ? franchise : business;
//
//     return Container(
//         margin: EdgeInsets.symmetric(horizontal: 5.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           image: DecorationImage(
//             image: business != null && business!.imageUrl != null
//                 ? NetworkImage(business!.imageUrl)
//                 : franchise != null
//                 ? NetworkImage(franchise!.imageUrl)
//                 : activity != null && activity!.imageUrl != null
//                 ? NetworkImage(activity!.imageUrl)
//                 : AssetImage('assets/businessimg.png'),
//             // image: NetworkImage(activity.imageUrl),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Stack(
//             children: [
//               // Positioned(
//               //   top: 10,
//               //   right: 10,
//               //   child: Container(
//               //     padding: EdgeInsets.all(5),
//               //     decoration: BoxDecoration(
//               //       color: Colors.white,
//               //       shape: BoxShape.circle,
//               //     ),
//               //     child: Icon(Icons.favorite, color: Colors.red, size: 20),
//               //   ),
//               // ),
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.bottomCenter,
//                       end: Alignment.topCenter,
//                       colors: [Colors.black.withOpacity(0.8), Colors.transparent],
//                     ),
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(15),
//                       bottomRight: Radius.circular(15),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           width: 150.w,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(50)),
//                           child: Padding(
//                             padding: const EdgeInsets.all(6.0),
//                             child: Text(
//                               business != null
//                                   ? business!.name
//                                   : franchise != null
//                                   ? franchise!.brandName
//                                   : activity != null
//                                   ? activity!.name
//                                   : "N/A",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Container(
//                           width: 100.w,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(6.0),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.location_on,
//                                     color: Colors.amber, size: 18.h),
//                                 SizedBox(width: 5),
//                                 Flexible(
//                                   child: Text(
//                                     business != null
//                                         ? business!.address_1 ?? "N/A"
//                                         : franchise != null
//                                         ? franchise!.city ?? "N/A"
//                                         : activity!.city,
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 13),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         // Padding(
//                         //   padding: const EdgeInsets.all(6.0),
//                         //   child: Text(
//                         //     timeago.format(DateTime.parse(activity.postedTime)),
//                         //     style: TextStyle(color: Colors.white60, fontSize: 12),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//             ),
//         );
//     }
// }


import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_emergio/Views/detail%20page/advisor%20detail%20page.dart';
import 'package:project_emergio/Views/detail%20page/business%20deatil%20page.dart';
import 'package:project_emergio/Views/detail%20page/franchise%20detail%20page.dart';
import 'package:project_emergio/Views/detail%20page/invester%20detail%20page.dart';
import 'package:project_emergio/models/all%20profile%20model.dart';
import 'package:project_emergio/services/recent%20activities.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../services/latest transactions and activites.dart';

List<BusinessInvestorExplr> _recentBusiness = [];
List<FranchiseExplr> _recentFranchise = [];
List<BusinessInvestorExplr> _recentInvestors = [];

class LatestActivitiesList extends StatefulWidget {
  final String profile;
  const LatestActivitiesList({Key? key, required this.profile})
      : super(key: key);
  @override
  _LatestActivitiesListState createState() => _LatestActivitiesListState();
}

class _LatestActivitiesListState extends State<LatestActivitiesList> {
  List<LatestActivites>? _activities;

  List<AdvisorExplr> _recentAdvisor = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchActivities();
  }

  Future<void> _fetchActivities() async {
    try {
      String item = widget.profile == "business"
          ? "investor"
          : widget.profile == "investor"
          ? "business"
          : widget.profile == "franchise"
          ? "franchise"
          : widget.profile == "advisor"
          ? "advisor"
          : "";

      final data = await LatestTransactions.fetchRecentPosts(item);
      if (data != null) {
        fetchRecent(data);
      } else {
        print("Rceents lists is empty");
      }

      _isLoading = false;
    } catch (e) {
      setState(() {
        _error = 'Failed to load activities';
        _isLoading = false;
      });
    }
  }

  Future<void> fetchRecent(Map<String, dynamic> data) async {
    switch (widget.profile) {
      case "business":
        setState(() {
          _recentBusiness = data["investor_data"];
        });

        break;

      case "investor":
        setState(() {
          _recentBusiness = data["business_data"];
        });
        break;
      case "franchise":
        setState(() {
          _recentFranchise = data["franchise_data"];
        });
        break;
      default:
        setState(() {
          _activities = data["home_data"];
          _recentBusiness = data["business"];
          _recentFranchise = data["franchises"];
          _recentInvestors = data["investors"];
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16, top: 8, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Post',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'See all',
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        if (_isLoading)
          Center(child: CircularProgressIndicator())
        else if (_error != null)
          Center(child: Text(_error!))
        else if (widget.profile == "business" &&
              _recentBusiness != null &&
              _recentBusiness.isEmpty)
            Center(child: Text('No posts available'))
          else if (widget.profile == "investor" &&
                _recentBusiness != null &&
                _recentBusiness.isEmpty)
              Center(child: Text('No posts available'))
            else if (widget.profile == "franchise" &&
                  _recentFranchise != null &&
                  _recentFranchise.isEmpty)
                Center(child: Text('No posts available'))
              else if (widget.profile == "" &&
                    (_activities != null && _activities!.isEmpty))
                  Center(child: Text('No posts available'))
                else if (widget.profile == "business" || widget.profile == "investor")
                    CarouselSlider.builder(
                      itemCount: _recentBusiness.length,
                      itemBuilder: (context, index, realIndex) {
                        return ActivityCard(
                          index: index,
                          business: _recentBusiness[index],
                          profile: widget.profile,
                        );
                      },
                      options: CarouselOptions(
                        height: 230.h,
                        viewportFraction: 0.65,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                      ),
                    )
                  else if (widget.profile == "franchise")
                      CarouselSlider.builder(
                        itemCount: _recentFranchise.length,
                        itemBuilder: (context, index, realIndex) {
                          return ActivityCard(
                            index: index,
                            franchise: _recentFranchise[index],
                            profile: "franchise",
                          );
                        },
                        options: CarouselOptions(
                          height: 230.h,
                          viewportFraction: 0.65,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                        ),
                      )
                    else
                      CarouselSlider.builder(
                        itemCount: _activities != null ? _activities!.length : 0,
                        itemBuilder: (context, index, realIndex) {
                          return ActivityCard(
                            index: index,
                            activity: _activities![index],
                            profile: "",
                            // business: _recentBusiness[index],
                            // franchise: _recentFranchise[index],
                            // investor: _recentInvestors[index],
                          );
                        },
                        options: CarouselOptions(
                          height: 230.h,
                          viewportFraction: 0.65,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                        ),
                      )
      ],
    );
  }
}

class ActivityCard extends StatelessWidget {
  final LatestActivites? activity;
  final BusinessInvestorExplr? business;
  final FranchiseExplr? franchise;
  final BusinessInvestorExplr? investor;
  final String profile;
  final int index;

  const ActivityCard(
      {Key? key,
        required this.index,
        this.activity,
        this.business,
        this.franchise,
        this.investor,
        required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = profile == "franchise" ? franchise : business;

    return InkWell(
      onTap: () {
        if (profile == "business" && business != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InvestorDetailPage(
                investor: business,
              ),
            ),
          );
        } else if (profile == "investor" && business != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BusinessDetailPage(
                buisines: business ?? _recentBusiness[index],
                imageUrl: business!.imageUrl,
                image2: business!.image2,
                image3: business!.image3,
                image4: business!.image4,
                name: business!.name,
                industry: business!.industry,
                establish_yr: business!.establish_yr,
                description: business!.description,
                address_1: business!.address_1,
                address_2: business!.address_2,
                pin: business!.pin,
                city: business!.city,
                state: business!.state,
                employees: business!.employees,
                entity: business!.entity,
                avg_monthly: business!.avg_monthly,
                latest_yearly: business!.latest_yearly,
                ebitda: business!.ebitda,
                rate: business!.rate,
                type_sale: business!.type_sale,
                url: business!.url,
                features: business!.features,
                facility: business!.facility,
                income_source: business!.income_source,
                reason: business!.reason,
                postedTime: business!.postedTime,
                topSelling: business!.topSelling,
                id: business!.id,
                showEditOption: false,
              ),
            ),
          );
        } else if (profile == "franchise" && franchise != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FranchiseDetailPage(
                franchise: franchise,
                id: franchise!.id,
                imageUrl: franchise!.imageUrl,
                image2: franchise!.image2,
                image3: franchise!.image3,
                image4: franchise!.image4,
                brandName: franchise!.brandName,
                city: franchise!.city,
                postedTime: franchise!.postedTime,
                state: franchise!.state,
                industry: franchise!.industry,
                description: franchise!.description,
                url: franchise!.url,
                initialInvestment: franchise!.initialInvestment,
                projectedRoi: franchise!.projectedRoi,
                iamOffering: franchise!.iamOffering,
                currentNumberOfOutlets: franchise!.currentNumberOfOutlets,
                franchiseTerms: franchise!.franchiseTerms,
                locationsAvailable: franchise!.locationsAvailable,
                kindOfSupport: franchise!.kindOfSupport,
                allProducts: franchise!.allProducts,
                brandStartOperation: franchise!.brandStartOperation,
                spaceRequiredMin: franchise!.spaceRequiredMin,
                spaceRequiredMax: franchise!.spaceRequiredMax,
                totalInvestmentFrom: franchise!.totalInvestmentFrom,
                totalInvestmentTo: franchise!.totalInvestmentTo,
                brandFee: franchise!.brandFee,
                avgNoOfStaff: franchise!.avgNoOfStaff,
                avgMonthlySales: franchise!.avgMonthlySales,
                avgEBITDA: franchise!.avgEBITDA,
                showEditOption: false,
              ),
            ),
          );
        } else {
          if (activity != null) {
            goToDetailPage(
                context,
                activity!.type == "investor"
                    ? _recentInvestors[index]
                    : activity!.type == "business"
                    ? _recentBusiness[index]
                    : _recentFranchise[index],
                activity!.type);
          }
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: business != null && business!.imageUrl != null
                ? NetworkImage(business!.imageUrl)
                : franchise != null
                ? NetworkImage(franchise!.imageUrl)
                : activity != null && activity!.imageUrl != null
                ? NetworkImage(activity!.imageUrl)
                : AssetImage('assets/businessimg.png'),
            // image: NetworkImage(activity.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Positioned(
            //   top: 10,
            //   right: 10,
            //   child: Container(
            //     padding: EdgeInsets.all(5),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       shape: BoxShape.circle,
            //     ),
            //     child: Icon(Icons.favorite, color: Colors.red, size: 20),
            //   ),
            // ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 150.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            business != null
                                ? business!.name
                                : franchise != null
                                ? franchise!.brandName
                                : activity != null
                                ? activity!.name
                                : "N/A",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: Colors.amber, size: 18.h),
                              SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  business != null
                                      ? business!.address_1 ?? "N/A"
                                      : franchise != null
                                      ? franchise!.city ?? "N/A"
                                      : activity!.city,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      // Padding(
                      //   padding: const EdgeInsets.all(6.0),
                      //   child: Text(
                      //     timeago.format(DateTime.parse(activity.postedTime)),
                      //     style: TextStyle(color: Colors.white60, fontSize: 12),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goToDetailPage(BuildContext context, dynamic model, String type) {
    if (type == "investor" && model is BusinessInvestorExplr) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InvestorDetailPage(investor: model),
        ),
      );
    } else if (type == "business" && model is BusinessInvestorExplr) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BusinessDetailPage(
            buisines: model,
            showEditOption: false,
          ),
        ),
      );
    } else if (type == "franchise" && model is FranchiseExplr) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FranchiseDetailPage(
            franchise: model,

            showEditOption: false,
          ),
        ),
      );
    }
  }
}
