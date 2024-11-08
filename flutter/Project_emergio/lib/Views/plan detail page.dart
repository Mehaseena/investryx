import 'package:flutter/material.dart';
import 'package:project_emergio/Widgets/razorpay%20widget.dart';

class PlanDetailsPage extends StatefulWidget {
  final String planType;
  final String price;
  final String id;
  final List<String> features;
  final String subscribedId;
  final String timePeriod;
  final VoidCallback onPurchaseComplete;

  PlanDetailsPage({
    required this.planType,
    required this.price,
    required this.features,
    required this.id,
    required this.subscribedId,
    required this.onPurchaseComplete,
    required this.timePeriod,
  });

  @override
  _PlanDetailsPageState createState() => _PlanDetailsPageState();
}

class _PlanDetailsPageState extends State<PlanDetailsPage> {
  late String _currentSubscribedId;

  @override
  void initState() {
    super.initState();
    _currentSubscribedId = widget.subscribedId;
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryGray = Color(0xFFDEE2E6);
    final Color darkBlue = Color(0xFF007BFF);
    final Color darkGray = Color(0xFF495057);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Plan Details', style: TextStyle(color: darkGray)),
        elevation: 0,
        backgroundColor: primaryGray,
        iconTheme: IconThemeData(color: darkGray),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              decoration: BoxDecoration(
                color: primaryGray,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.planType,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: darkGray,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '₹${widget.price}',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff37498B),
                    ),
                  ),
                  Text(
                    'for ${widget.timePeriod} Months',
                    style: TextStyle(fontSize: 18, color: darkGray.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Plan Features',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: darkGray,
                    ),
                  ),
                  SizedBox(height: 16),
                  ...widget.features.map((feature) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: primaryGray,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.check, color: darkBlue, size: 20),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(fontSize: 16, height: 1.5, color: darkGray),
                          ),
                        ),
                      ],
                    ),
                  )),
                  SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: _currentSubscribedId == widget.id ? darkGray : Colors.white,
                        backgroundColor: _currentSubscribedId == widget.id ? primaryGray : Color(0xff37498B),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _currentSubscribedId == widget.id
                          ? null
                          : () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PayMoney(
                              amount: int.parse(widget.price),
                              name: widget.planType,
                              description: 'Description of ${widget.planType}',
                              email: 'example@example.com',
                              id: widget.id,
                            ),
                          ),
                        );
                        if (result == true) {
                          setState(() {
                            _currentSubscribedId = widget.id;
                          });
                          widget.onPurchaseComplete();
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _currentSubscribedId == widget.id ? Icons.check : Icons.rocket_launch,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            _currentSubscribedId == widget.id ? 'Already Subscribed' : 'Start Now',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}