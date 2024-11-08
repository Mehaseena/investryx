import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBusiness extends StatelessWidget {
  final String title;
  final String description;
  final String mainImage;
  final String topRightImage;
  final String bottomRightImage;
  final Color backgroundColor;
  final double height;

  const CustomBusiness({
    super.key,
    this.title = 'Business for Sale',
    this.description = 'Lorem Ipsum Dolor Sit Amet Consectetur, Tellus Iaculis Orci Semper Pellentesque Enim Quam Ut.',
    this.mainImage = 'assets/business_vector.png',
    this.topRightImage = 'assets/investor_vector.png',
    this.bottomRightImage = 'assets/img2.png',
    this.backgroundColor = const Color(0xff6B89B7),
    this.height = 210,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Opacity(
                          opacity: 0.6,
                            child: Image.asset(mainImage)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              description,
                              style: const TextStyle(color: Colors.white70),
                            ),
                             SizedBox(height: 7.h),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                onPressed: (){}, child: Text('Explore >',style: TextStyle(color: Color(0xffFFCC00)),)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: height / 2 - 4,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          opacity: 0.8,
                          image: AssetImage(
                              topRightImage,),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: height / 2 - 4, // Accounting for the gap
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          opacity: 0.8,
                          image: AssetImage(bottomRightImage),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}