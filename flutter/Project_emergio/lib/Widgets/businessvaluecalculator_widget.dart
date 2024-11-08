// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:project_emergio/Views/Home/business%20valuation%20calculator%20page.dart';
// import 'package:project_emergio/Widgets/BVC%20calculator_widget.dart';
//
// class BusinessValueCalculatorWidget extends StatefulWidget {
//   const BusinessValueCalculatorWidget({super.key});
//
//   @override
//   State<BusinessValueCalculatorWidget> createState() =>
//       _BusinessValueCalculatorWidgetState();
// }
//
// class _BusinessValueCalculatorWidgetState
//     extends State<BusinessValueCalculatorWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return SizedBox(
//       height: 250.h,
//       child: Stack(
//         children: [
//           Opacity(
//             opacity: .85,
//             child: SizedBox(
//               height: 237.h,
//               //color: Colors.red,
//               child: Image.asset(
//                 'assets/businessvaluecalculator.png',
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Container(
//             height: 237.h,
//             color: Colors.black45,
//           ),
//           Positioned(
//               top: 15.h,
//               left: 45.w,
//               child: Text(
//                 'Business Valuation Calculator',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 21.sp),
//               )),
//           Positioned(
//               top: 60.h,
//               left: 13.w,
//               child: Text(
//                 'Our business valuation calculator is a powerful tool designed\nto help you understand the worth of your business. With just\na few inputs, you can obtain an estimate of your business value\nempowering you to make informed decisions about its future.',
//                 style: TextStyle(color: Colors.white, fontSize: 12.sp),
//               )),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: EdgeInsets.only(bottom: 35.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SizedBox(
//                     height: 30.h,
//                     width: 120.w,
//                     child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5.r))),
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       BusinessValuationScreen()));
//                         },
//                         child: Text(
//                           'View More',
//                           style:
//                               TextStyle(color: Colors.white, fontSize: 12.sp),
//                         )),
//                   ),
//                   SizedBox(
//                     height: 30.h,
//                     width: 120.w,
//                     child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5.r))),
//                         onPressed: () {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) =>
//                                 BusinessValuationPopup(),
//                           );
//                         },
//                         child: Text(
//                           'Calculate',
//                           style:
//                               TextStyle(color: Colors.white, fontSize: 12.sp),
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_emergio/Widgets/BVC%20calculator_widget.dart';

class BusinessValuationPromoCard extends StatelessWidget {
  const BusinessValuationPromoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: .5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Business valuation\nCalculator',
                  style: TextStyle(
                    fontSize: 20.h,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E), // Dark blue color
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'In the office, remote, or a mix of\nthe two, with Miro, your team ca\nn connect, collaborate, and co-cr',
                  style: TextStyle(
                    fontSize: 12.h,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 15.h),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BusinessValuationScreen()));
                  },
                  child: Text(
                    'See More',
                    style: TextStyle(fontSize: 13.h,color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFCC00), // Amber color
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 160,
              child: Image.asset(
                'assets/BVC.png', // You'll need to create this asset
                // width: 160,
                // height: 170,
              ),
            ),
          ],
        ),
      ),
    );
  }
}