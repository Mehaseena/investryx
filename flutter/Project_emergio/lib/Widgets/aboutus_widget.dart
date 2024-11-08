// import 'package:flutter/material.dart';
//
// class AboutUsWidget extends StatefulWidget {
//   const AboutUsWidget({Key? key}) : super(key: key);
//
//   @override
//   State<AboutUsWidget> createState() => _AboutUsWidgetState();
// }
//
// class _AboutUsWidgetState extends State<AboutUsWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     return Opacity(
//       opacity: .69,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Color(0xff000000),
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(7.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 14.0),
//               Center(
//                 child: Text(
//                   'About Us',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 17.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(height: h * .04),
//               Text(
//                 'Emergio Games',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 17.0,
//                     fontWeight: FontWeight.w600),
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 'Emergio Games Pvt Ltd, headquartered in Kochi, Kerala, is India\'s premier game development company. With years of experience, Emergio not only excels in crafting captivating games but also offers high-quality training in lucrative IT domains.',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 12.0,
//                 ),
//               ),
//               SizedBox(height: h * .03),
//               Center(
//                 child: Text(
//                   'Contact Us',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 17.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 18.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Icon(
//                         Icons.location_on,
//                         color: Colors.white,
//                         size: 18,
//                       ),
//                       SizedBox(height: 8.0),
//                       Text(
//                         '9th Floor, Noel Focus,\nSeaport - Airport Rd, CSEZ,\nChattenkurussi, Kochi,\nKerala 682037',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.phone,
//                             color: Colors.white,
//                             size: 18,
//                           ),
//                           SizedBox(width: 8.0),
//                           Text(
//                             '+91 7594088814',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8.0),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.email,
//                             color: Colors.white,
//                             size: 18,
//                           ),
//                           SizedBox(width: 8.0),
//                           Text(
//                             'hr@emergiotech.com',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               SizedBox(height: h * .03),
//               Center(
//                 child: Text(
//                   'Join Our Social Community',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 17.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(height: h * .02),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Image.asset(
//                     'assets/Vector.png',
//                     height: 30,
//                   ),
//                   SizedBox(width: 8.0),
//                   Icon(
//                     Icons.facebook,
//                     color: Colors.white,
//                     size: 25,
//                   ),
//                   SizedBox(width: 8.0),
//                   Image.asset(
//                     'assets/instalogo.png',
//                     height: 30,
//                   ),
//                   SizedBox(width: 8.0),
//                   Image.asset(
//                     'assets/twitterlogo.png',
//                     height: 30,
//                   ),
//                 ],
//               ),
//               SizedBox(height: h * .02),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsWidget extends StatefulWidget {
  const AboutUsWidget({Key? key}) : super(key: key);

  @override
  State<AboutUsWidget> createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Opacity(
      opacity: .69,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff000000),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 14.0),
              Center(
                child: Text(
                  'About Us',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: h * .04),
              Text(
                'Emergio Games',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8.0),
              Text(
                'Emergio Games Pvt Ltd, headquartered in Kochi, Kerala, is India\'s premier game development company. With years of experience, Emergio not only excels in crafting captivating games but also offers high-quality training in lucrative IT domains.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: h * .03),
              Center(
                child: Text(
                  'Contact Us',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _launchUrl('https://maps.app.goo.gl/e9pjbWkpavLuJ48e6'),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '9th Floor, Noel Focus,\nSeaport - Airport Rd, CSEZ,\nChattenkurussi, Kochi,\nKerala 682037',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => _launchUrl('tel:+917594088814'),
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '+91 7594088814',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () => _launchUrl('mailto:hr@emergiotech.com'),
                        child: Row(
                          children: [
                            Icon(
                              Icons.email,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'hr@emergiotech.com',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: h * .03),
              Center(
                child: Text(
                  'Join Our Social Community',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: h * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _launchUrl('https://www.emergiogames.com/'),
                    child: Image.asset(
                      'assets/Vector.png',
                      height: 30,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () => _launchUrl('https://www.facebook.com/emergiogames/'),
                    child: Icon(
                      Icons.facebook,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () => _launchUrl('https://www.instagram.com/emergio.games/'),
                    child: Image.asset(
                      'assets/instalogo.png',
                      height: 30,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () => _launchUrl('https://x.com/home'),
                    child: Image.asset(
                      'assets/twitterlogo.png',
                      height: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * .02),
            ],
          ),
        ),
      ),
    );
  }
}