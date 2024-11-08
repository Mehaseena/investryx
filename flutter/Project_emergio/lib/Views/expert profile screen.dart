import 'package:flutter/material.dart';

class FeaturedExpertsProfile extends StatefulWidget {
  const FeaturedExpertsProfile({super.key});

  @override
  State<FeaturedExpertsProfile> createState() => _FeaturedExpertsProfileState();
}

class _FeaturedExpertsProfileState extends State<FeaturedExpertsProfile> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h * 0.03,
            ),
            CircleAvatar(
              radius: h * .08,
              backgroundImage: AssetImage('assets/profile_picture.jpg'),
            ),
            SizedBox(height: h * .02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ayesha Bazmi',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Marketing Manager',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.facebook),
                SizedBox(width: w * 0.05),
                Image.asset(
                  'assets/insta.png',
                  height: h * 0.02,
                ),
                SizedBox(width: w * 0.05),
                Image.asset(
                  'assets/twitter.png',
                  height: h * 0.02,
                ),
              ],
            ),
            SizedBox(
              height: h * 0.025,
            ),
            Container(
              height: h * 0.25,
              width: w * 0.9,
              decoration: BoxDecoration(
                  color: Color(0xff3D3F54),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 16),
                    child: Text(
                      'About Me',
                      style: TextStyle(
                        fontSize: h * 0.018,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 10),
                    child: Text(
                      'Ayesha Bazmi is a results-driven Marketing Manager with a passion for leveraging innovative strategies to drive brand growth and customer engagement in the ever-evolving digital landscape.',
                      style: TextStyle(
                        fontSize: h * 0.015,
                        color: Color(0xffD9D9D9),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 10),
                    child: Text(
                      'Feel free to reach me out for any specific queries.',
                      style: TextStyle(
                        fontSize: h * 0.015,
                        color: Color(0xffD9D9D9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: h * 0.015,
            ),
            Container(
              height: h * 0.25,
              width: w * 0.9,
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                'Upgrade to premium to see the details',
                style: TextStyle(color: Colors.white),
              )),
            ),
            SizedBox(
              height: h * 0.013,
            ),
            SizedBox(
              height: h * 0.055,
              width: w * 0.9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: Color(0xff003C82)),
                onPressed: () {},
                child: Text(
                  'Message Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.025,
            ),
          ],
        ),
      ),
    );
  }
}
