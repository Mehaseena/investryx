import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_emergio/Widgets/plan%20shimmer%20widget.dart';
import '../Widgets/plan card_widget.dart';
import '../services/check subscribe.dart';
import '../services/pricings.dart';

class PricingPage extends StatefulWidget {
  const PricingPage({Key? key}) : super(key: key);

  @override
  _PricingPageState createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> with WidgetsBindingObserver {
  final CarouselSliderController _popularController = CarouselSliderController();
  Timer? _popularTimer;
  String subscribedId = "";
  List<Map<String, dynamic>> _plans = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchPlans();
    _startCarouselTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshSubscriptionStatus();
    }
  }

  void _startCarouselTimer() {
    _popularTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      _popularController.animateToPage(
        1,  // Customize this to navigate to a specific page
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    });
  }

  Future<void> _fetchPlans() async {
    List<Map<String, dynamic>>? plans = await PlansGet.fetchPlans();
    await _refreshSubscriptionStatus();
    if (plans != null) {
      setState(() {
        _plans = plans;
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshSubscriptionStatus() async {
    var subscribe = await CheckSubscription.fetchSubscription();
    setState(() {
      subscribedId = subscribe['id'].toString();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _popularTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Popular Plans',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: h * 0.6,
            child: _isLoading
                ? PlanCardShimmer()
                : CarouselSlider(
              items: _plans.map((plan) {
                return PlanCardWidget(
                  id: plan['id'].toString(),
                  planType: plan['name'] ?? 'Unknown Plan',
                  price: plan['rate'].toString(),
                  timePeriod: plan['time_period'].toString(),
                  isRecommended: plan['feature'],
                  features: List<String>.from(plan['description'].values),
                  isHighlighted: plan['id'] == 1,
                  subscribedId: subscribedId,
                  onPurchaseComplete: _refreshSubscriptionStatus,
                );
              }).toList(),
              carouselController: _popularController,  // Updated controller type
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                height: h * 0.55,
                viewportFraction: 0.78,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
