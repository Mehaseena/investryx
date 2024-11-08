import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:project_emergio/Views/detail%20page/advisor%20detail%20page.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../Views/detail page/business deatil page.dart';
import '../Views/detail page/franchise detail page.dart';
import '../Views/detail page/invester detail page.dart';
import '../models/all profile model.dart';
import '../services/recommended ads.dart';
import '../services/recent activities.dart';
import 'package:timeago/timeago.dart' as timeago;

class RecommendedAdsPage extends StatefulWidget {
  final String profile;
  const RecommendedAdsPage({Key? key, required this.profile}) : super(key: key);
  @override
  _RecommendedAdsPageState createState() => _RecommendedAdsPageState();
}

class _RecommendedAdsPageState extends State<RecommendedAdsPage> {
  List<ProductDetails>? _recommendedads;
  List<BusinessInvestorExplr> _wishlistAllItems = [];
  // List<Map<String, dynamic>> _wishlistAllItems = [];
  List<FranchiseExplr> _wishlistFranchiseItems = [];
  List<AdvisorExplr> _advisorItems = [];
  bool _isLoading = true;
  bool _hasError = false;
  bool _noData = false;

  @override
  void initState() {
    super.initState();
    _loadRecommendedAds();
  }

  Future<void> _loadRecommendedAds() async {
    try {
      final FlutterSecureStorage storage = FlutterSecureStorage();
      var data = await RecommendedAds.fetchRecommended();
      if (data != null &&
          data.containsKey("status") &&
          data["status"] == "loggedout") {
        // Handle logged out state
        // You might want to navigate to login page or show a message
      } else {
        setState(() {
          fetchRecommendedData(data!);
          _isLoading = false;
          _hasError = false;
          _noData = _recommendedads?.isEmpty ?? true;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _noData = false;
      });
    }
  }

  Future<void> fetchRecommendedData(Map<String, dynamic> data) async {
    switch (widget.profile) {
      case "investor":
        setState(() {
          _recommendedads = data['business_recommended'];
          _wishlistAllItems = data["business_data"] ?? [];
        });
        break;
      case "business":
        setState(() {
          _recommendedads = data['investor_recommended'];
          _wishlistAllItems = data["investor_data"] ?? [];
        });
        break;
      case "franchise":
        setState(() {
          _recommendedads = data['franchise_recommended'];
          _wishlistFranchiseItems = data["franchise_data"] ?? [];
        });
        break;
      case "advisor":
        _recommendedads = data["advisor_data"];
        _advisorItems = data["advisor_data"];
      default:
        setState(() {
          _recommendedads = data["recommended"];
          _wishlistAllItems = data["recommendedAll"];
          _wishlistFranchiseItems = data["recommendedFranchiseItems"] ?? [];
          _advisorItems = data["advisor_data"];
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

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
                'Recommended list',
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
        SizedBox(
          child: _isLoading
              ? _buildShimmer(w, h)
              : _hasError
              ? _buildErrorMessage(h)
              : _noData
              ? _buildNoDataMessage(h)
              : _buildRecommendedAdsList(w, h),
        ),
      ],
    );
  }

  Widget _buildShimmer(double w, double h) {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (context, index, realIndex) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Container(
              width: w * 0.8,
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    height: 150,
                    width: 120,
                    color: Colors.white,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: 100,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 16,
                          width: 150,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 14,
                          width: 80,
                          color: Colors.white,
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 36,
                          width: 100,
                          color: Colors.white,
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
      options: CarouselOptions(
        height: h * 0.35,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }

  Widget _buildErrorMessage(double h) {
    return Center(
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
    );
  }

  Widget _buildNoDataMessage(double h) {
    return Center(
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
            "No recommended ads available",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text(
            "Check back soon for exciting offers!",
            style: TextStyle(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedAdsList(double w, double h) {
    return CarouselSlider.builder(
      itemCount: _recommendedads?.length ?? 0,
      itemBuilder: (context, index, realIndex) {
        var item = _recommendedads![index];
        return GestureDetector(
          onTap: () {
            _navigateToDetailPage(item, index);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 5, top: 2),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 2,
                      offset: Offset(-1, 2)
                  )
                ]
            ),
            child: Row(
              children: [
                Container(
                  height: double.infinity,
                  width: 180.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        item.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${item.city} • ${item.type}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Posted: ${formatDateTime(item.postedTime)}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextButton(
                          onPressed: () {
                            _navigateToDetailPage(item, index);
                          },
                          child: Row(
                            children: [
                              Text(
                                'View Post ',
                                style: TextStyle(color: Color(0xff0D0B56)),
                              ),
                              Icon(CupertinoIcons.arrow_right_circle_fill,
                                  color: Color(0xff0D0B56))
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: h * 0.22,
        viewportFraction: 0.95,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }

  Future<void> _navigateToDetailPage(ProductDetails item, int index) async {
    await RecentActivities.recentActivities(productId: item.id);
    if (item.type == 'business') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BusinessDetailPage(
            buisines: _wishlistAllItems[index],
            imageUrl: _wishlistAllItems[index].imageUrl,
            image2: _wishlistAllItems[index].image2,
            image3: _wishlistAllItems[index].image3,
            image4: _wishlistAllItems[index].image4,
            name: _wishlistAllItems[index].name,
            industry: _wishlistAllItems[index].industry,
            establish_yr: _wishlistAllItems[index].establish_yr,
            description: _wishlistAllItems[index].description,
            address_1: _wishlistAllItems[index].address_1,
            address_2: _wishlistAllItems[index].address_2,
            pin: _wishlistAllItems[index].pin,
            city: _wishlistAllItems[index].city,
            state: _wishlistAllItems[index].state,
            employees: _wishlistAllItems[index].employees,
            entity: _wishlistAllItems[index].entity,
            avg_monthly: _wishlistAllItems[index].avg_monthly,
            latest_yearly: _wishlistAllItems[index].latest_yearly,
            ebitda: _wishlistAllItems[index].ebitda,
            rate: _wishlistAllItems[index].rate,
            type_sale: _wishlistAllItems[index].type_sale,
            url: _wishlistAllItems[index].url,
            features: _wishlistAllItems[index].features,
            facility: _wishlistAllItems[index].facility,
            income_source: _wishlistAllItems[index].income_source,
            reason: _wishlistAllItems[index].reason,
            postedTime: _wishlistAllItems[index].postedTime,
            topSelling: _wishlistAllItems[index].topSelling,
            id: _wishlistAllItems[index].id,
            showEditOption: false,
          ),
        ),
      );
    } else if (item.type == 'investor') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InvestorDetailPage(
            investor: _wishlistAllItems[index],
            imageUrl: _wishlistAllItems[index].imageUrl,
            name: _wishlistAllItems[index].name,
            city: _wishlistAllItems[index].city,
            postedTime: _wishlistAllItems[index].postedTime,
            state: _wishlistAllItems[index].state,
            industry: _wishlistAllItems[index].industry,
            description: _wishlistAllItems[index].description,
            url: _wishlistAllItems[index].url,
            rangeStarting: _wishlistAllItems[index].rangeStarting,
            rangeEnding: _wishlistAllItems[index].rangeEnding,
            evaluatingAspects: _wishlistAllItems[index].evaluatingAspects,
            CompanyName: _wishlistAllItems[index].companyName,
            locationInterested: _wishlistAllItems[index].locationIntrested,
            id: _wishlistAllItems[index].id,
            showEditOption: false,
            image2: _wishlistAllItems[index].image2 ?? '',
            image3: _wishlistAllItems[index].image3 ?? '',
            image4: _wishlistAllItems[index].image4,
          ),
        ),
      );
    } else if (item.type == 'franchise') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FranchiseDetailPage(
            franchise: _wishlistFranchiseItems[index],
            id: _wishlistFranchiseItems[index].id,
            imageUrl: _wishlistFranchiseItems[index].imageUrl,
            image2: _wishlistFranchiseItems[index].image2,
            image3: _wishlistFranchiseItems[index].image3,
            image4: _wishlistFranchiseItems[index].image4,
            brandName: _wishlistFranchiseItems[index].brandName,
            city: _wishlistFranchiseItems[index].city,
            postedTime: _wishlistFranchiseItems[index].postedTime,
            state: _wishlistFranchiseItems[index].state,
            industry: _wishlistFranchiseItems[index].industry,
            description: _wishlistFranchiseItems![index].description,
            url: _wishlistFranchiseItems[index].url,
            initialInvestment: _wishlistFranchiseItems[index].initialInvestment,
            projectedRoi: _wishlistFranchiseItems[index].projectedRoi,
            iamOffering: _wishlistFranchiseItems[index].iamOffering,
            currentNumberOfOutlets:
            _wishlistFranchiseItems[index].currentNumberOfOutlets,
            franchiseTerms: _wishlistFranchiseItems[index].franchiseTerms,
            locationsAvailable:
            _wishlistFranchiseItems[index].locationsAvailable,
            kindOfSupport: _wishlistFranchiseItems[index].kindOfSupport,
            allProducts: _wishlistFranchiseItems[index].allProducts,
            brandStartOperation:
            _wishlistFranchiseItems[index].brandStartOperation,
            spaceRequiredMin: _wishlistFranchiseItems[index].spaceRequiredMin,
            spaceRequiredMax: _wishlistFranchiseItems[index].spaceRequiredMax,
            totalInvestmentFrom:
            _wishlistFranchiseItems[index].totalInvestmentFrom,
            totalInvestmentTo: _wishlistFranchiseItems[index].totalInvestmentTo,
            brandFee: _wishlistFranchiseItems[index].brandFee,
            avgNoOfStaff: _wishlistFranchiseItems[index].avgNoOfStaff,
            avgMonthlySales: _wishlistFranchiseItems[index].avgMonthlySales,
            avgEBITDA: _wishlistFranchiseItems[index].avgEBITDA,
            showEditOption: false,
          ),
        ),
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AdvisorDetailPage(
                advisor: _advisorItems[index],

              )));
    }
  }

  String formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    return timeago.format(dateTime, allowFromNow:true);
    }
}
