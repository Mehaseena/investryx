import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_emergio/Views/Profiles/advisor/advisor%20profile%20screen.dart';
import 'package:project_emergio/Views/Profiles/Business/business%20listing%20page.dart';
import 'package:project_emergio/Views/Profiles/franchise/franchise%20listing%20page.dart';
import 'package:project_emergio/Views/Profiles/investor/investment%20listing.dart';

import '../Views/pricing screen.dart';
import '../controller/App bar controller.dart';
import '../services/check subscribe.dart';
import '../services/profile forms/advisor/advisor explore.dart';
import '../services/profile forms/advisor/advisor get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final double iconSize;
  final AppbarController _profileController = Get.put(AppbarController());

  CustomAppBar({
    this.height = 45.0,
    this.iconSize = 24.0,
    required GlobalKey<ScaffoldState> scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 80,
      leading: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset('assets/logo1.png', fit: BoxFit.cover),
      ),
      toolbarHeight: height,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PopupMenuButton<String>(
            onSelected: (value) async {
              /// Navigate to respective pages based on selected value
              switch (value) {
                case 'Business':
                  _profileController.switchToBusinessProfile();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BusinessListingsScreen()),
                  );
                  break;
                case 'Franchise':
                  _profileController.switchToFranchiseProfile();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FranchiseListingsScreen()),
                  );
                  break;
                case 'Investor':
                  _profileController.switchToInvestorProfile();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InvestorListingsScreen()),
                  );
                  break;
                case 'Advisor':
                /// Fetch the subscription status
                  var subscription = await CheckSubscription.fetchSubscription();
                  if (subscription['status']) {
                    // Navigate to the advisor
                    _profileController.switchToAdvisorProfile();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AdvisorProfileScreen()
                      ),
                    );
                  }
                  else {
                    // Show an alert and then navigate to the pricing screen
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Subscription Status'),
                          content: Text('You have not purchased any plans. Please visit the pricing page to choose a plan.'),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the alert dialog
                              },
                            ),
                            TextButton(
                              child: Text('View plans'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the alert dialog
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PricingPage()),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                  break;
                default:
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'Business',
                  child: Row(
                    children: [
                      Icon(Icons.business),
                      SizedBox(width: 8),
                      Text('Switch To Business Profile'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Franchise',
                  child: Row(
                    children: [
                      Icon(Icons.store),
                      SizedBox(width: 8),
                      Text('Switch To Franchise Profile'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Investor',
                  child: Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(width: 8),
                      Text('Switch To Investor Profile'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Advisor',
                  child: Row(
                    children: [
                      Icon(Icons.person_outline),
                      SizedBox(width: 8),
                      Text('Switch To Advisor Profile'),
                    ],
                  ),
                ),
              ];
            },
            child: CircleAvatar(
              backgroundColor: Colors.black12,
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: Icon(
                Icons.menu,
                size: iconSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
