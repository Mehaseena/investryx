import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_emergio/Views/Investment%20explore%20page.dart';

import '../Views/business explore page.dart';
import '../services/profile forms/investor/investor explore.dart';

class HomeInvestorWidget extends StatelessWidget {
  const HomeInvestorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0.w), // Using ScreenUtil for padding
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.w), // Using ScreenUtil for padding
            child: Image.asset(
              'assets/businessimg.png',
              width: 0.435.sw, // Using ScreenUtil for width
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(4.0.w), // Using ScreenUtil for padding
                  child: Text(
                    'Investment\nOpportunities',
                    style: TextStyle(
                      fontSize: 21.sp, // Using ScreenUtil for font size
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(4.0.w), // Using ScreenUtil for padding
                  child: Text(
                    'Pellentesque egestas elementum egestas faucibus sem. Velit nunc egestas ut morbi.',
                    style: TextStyle(
                      fontSize: 11.sp, // Using ScreenUtil for font size
                      fontWeight: FontWeight.w400,
                    ),
                    softWrap: true,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(4.0.w), // Using ScreenUtil for padding
                  child: SizedBox(
                    height: 32.h, // Using ScreenUtil for height
                    width: 100.w, // Using ScreenUtil for width
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5.r), // Using ScreenUtil for radius
                        ),
                        backgroundColor: const Color(0xff1A1A1A),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InvestorExplorePage(
                              searchQuery: '',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Explore >',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp, // Using ScreenUtil for font size
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
