import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_emergio/Views/detail%20page/business%20deatil%20page.dart';
import 'package:project_emergio/Views/detail%20page/franchise%20detail%20page.dart';
import 'package:project_emergio/Views/detail%20page/invester%20detail%20page.dart';
import 'package:project_emergio/models/all%20profile%20model.dart';
import 'package:project_emergio/services/recent%20activities.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../services/latest transactions and activites.dart';

class TopBusinessWidget extends StatefulWidget {
  final String profile;
  const TopBusinessWidget({Key? key, required this.profile}) : super(key: key);
  @override
  _TopBusinessWidgetState createState() => _TopBusinessWidgetState();
}

class _TopBusinessWidgetState extends State<TopBusinessWidget> {
  List<LatestActivites>? _activities;
  List<BusinessInvestorExplr> _featured = [];
  List<FranchiseExplr> _franchiseFeatured = [];
  List<AdvisorExplr> _advisorFeatured = [];

  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchActivities();
  }

  Future<void> _fetchActivities() async {
    String item = widget.profile == "business"
        ? "investor"
        : widget.profile == "investor"
        ? "business"
        : widget.profile == "franchise"
        ? "franchise"
        : "";
    try {
      final activities =
      await LatestTransactions.fetchFeaturedLists(profile: item);

      if (activities != null) {
        fetchFeatured(activities);
        setState(() {
          _isLoading = false;
        });
      } else {
        print("Result is empty lists");
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load activities';
        _isLoading = false;
      });
    }
  }

  Future<void> fetchFeatured(Map<String, dynamic> data) async {
    switch (widget.profile) {
      case "business":
        setState(() {
          _featured = data["investor_data"];
        });
        break;
      case "investor":
        setState(() {
          _featured = data["business_data"];
        });
        break;
      case "franchise":
        setState(() {
          _franchiseFeatured = data["franchise_data"];
        });
        break;

      default:
        setState(() {
          _franchiseFeatured = data["franchise_data"];
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
          const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.profile == "business"
                    ? "Featured investors"
                    : widget.profile == "investor"
                    ? 'Featured Business'
                    : "Featured franchises",
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
        else if (widget.profile == "business" && _featured.isEmpty)
            Center(child: Text('No posts available'))
          else if (widget.profile == "investor" && _featured.isEmpty)
              Center(child: Text('No posts available'))
            else if (widget.profile == "franchise" && _franchiseFeatured.isEmpty)
                Center(child: Text('No posts available'))
              else if (widget.profile == "" && _activities!.isEmpty)
                  Center(child: Text('No activities available'))
                else if (widget.profile == "business" || widget.profile == "investor")
                    CarouselSlider.builder(
                      itemCount: _featured.length,
                      itemBuilder: (context, index, realIndex) {
                        return ActivityCard(
                          business: _featured[index],
                          profile: widget.profile,
                          index: index,
                          id: _featured[index].id,
                        );
                      },
                      options: CarouselOptions(
                        height: 270.h,
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
                        itemCount: _franchiseFeatured.length,
                        itemBuilder: (context, index, realIndex) {
                          return ActivityCard(
                            franchise: _franchiseFeatured[index],
                            profile: "franchise",
                            index: index,
                            id: _franchiseFeatured[index].id,
                          );
                        },
                        options: CarouselOptions(
                          height: 270.h,
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
  final BusinessInvestorExplr? business;
  final FranchiseExplr? franchise;
  final String profile;
  final LatestActivites? allProfile;
  final int index;
  final String id;

  const ActivityCard(
      {Key? key,
        required this.index,
        required this.profile,
        this.business,
        this.allProfile,
        required this.id,
        this.franchise})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _navigateToDetailPage(index, id, context, profile);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: business != null && business!.imageUrl != null
                ? NetworkImage(business!.imageUrl)
                : franchise != null && franchise!.imageUrl != null
                ? NetworkImage(franchise!.imageUrl)
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
                                : allProfile!.username ?? "",
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
                                      ? business!.city
                                      : franchise != null
                                      ? franchise!.city
                                      : allProfile!.username,
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

  Future<void> _navigateToDetailPage(
      int index, String id, BuildContext context, String profile) async {
    await RecentActivities.recentActivities(productId: id);

    if (profile == 'investor') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BusinessDetailPage(
            buisines: business,
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
    } else if (profile == 'business') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InvestorDetailPage(
            investor: business,
            imageUrl: business!.imageUrl,
            name: business!.name,
            city: business!.city,
            postedTime: business!.postedTime,
            state: business!.state,
            industry: business!.industry,
            description: business!.description,
            url: business!.url,
            rangeStarting: business!.rangeStarting,
            rangeEnding: business!.rangeEnding,
            evaluatingAspects: business!.evaluatingAspects,
            CompanyName: business!.companyName,
            locationInterested: business!.locationIntrested,
            id: business!.id,
            showEditOption: false,
            image2: business!.image2 ?? '',
            image3: business!.image3 ?? '',
            image4: business!.image4,
          ),
        ),
      );
    } else {
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
    }
    }
}
