import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_emergio/Views/franchise%20explore%20page.dart';
import '../Views/business explore page.dart';

class HomeFranchiseWidget extends StatefulWidget {
  const HomeFranchiseWidget({super.key});

  @override
  State<HomeFranchiseWidget> createState() =>
      _HomeInvestmentAndFranchiseWidgetState();
}

class _HomeInvestmentAndFranchiseWidgetState
    extends State<HomeFranchiseWidget> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(6.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(4.0.w),
                child: Text(
                  'Franchise\nOpportunities',
                  style:
                      TextStyle(fontSize: 21.sp, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0.w),
                child: Text(
                  'Pellentesque egestas elementum\negestas faucibus sem. Velit nunc\negestas ut morbi.',
                  style:
                      TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0.w),
                child: SizedBox(
                  height: 32.h,
                  width: 100.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: Color(0xff1A1A1A)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FranchiseExplorePage(
                                      searchQuery: '',
                                    )));
                      },
                      child: Text(
                        'Explore >',
                        style:
                            TextStyle(color: Colors.white, fontSize: h * 0.013),
                      )),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              'assets/businessimg.png',
              width: w * .435,
            ),
          ),
        ],
      ),
    );
  }
}
