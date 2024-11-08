import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';

class DetailPage extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String city;
  final String postedTime;
  final String? state;
  final String? industry;
  final String? description;
  final String? url;
  final String? rangeStarting;
  final String? rangeEnding;
  final String? evaluatingAspects;
  final String? CompanyName;

  DetailPage({
    required this.imageUrl,
    required this.name,
    required this.city,
    required this.postedTime,
    this.state,
    this.industry,
    this.description,
    this.url,
    this.rangeStarting,
    this.rangeEnding,
    this.evaluatingAspects,
    this.CompanyName,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return DraggableHome(
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(left: h * .042, bottom: 8),
          child: SizedBox(
            width: w * 0.85,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Color(0xff003C82),
              child: Text(
                'Contact Business',
                style: TextStyle(color: Colors.white, fontSize: h * 0.019),
              ),
            ),
          ),
        ),
      ),
      headerWidget: headerWidget(context),
      alwaysShowLeadingAndAction: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.favorite_border, color: Colors.white),
          onPressed: () {},
        ),
      ],
      body: [
        bodyContent(context),
      ],
      title: Text(''),
    );
  }

  Widget headerWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showImageDialog(context, 0);
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/coffeeday.png'), // Using NetworkImage to load the image from URL
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget bodyContent(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CompanyName!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: h * 0.03),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.red,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                '${city}  ${state}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                CupertinoIcons.time,
                color: Colors.green,
                size: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                postedTime,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 16),
          if (description != null) ...[
            Text(
              "Overview :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              description!,
              style: TextStyle(fontSize: 16),
            ),
          ],
          SizedBox(height: 16),
          Text(
            "EBITDA Margin :",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            height: 50,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black45)),
            child: Center(
                child: Text(
              '12%',
              style:
                  TextStyle(fontSize: h * 0.017, fontWeight: FontWeight.w600),
            )),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Industry :",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                industry!,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Investment Range :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    "From -",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    rangeStarting!,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                width: h * 0.05,
              ),
              Row(
                children: [
                  Text(
                    "To -",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    rangeEnding!,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                "Company Name :",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                CompanyName!,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                softWrap: true,
                "Company Website :",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                url!,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                "Evaluating Aspects :",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  softWrap: true,
                  evaluatingAspects!,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  void _showImageDialog(BuildContext context, int initialIndex) {
    final PageController pageController =
        PageController(initialPage: initialIndex);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(0),
          child: Stack(
            children: [
              PageView.builder(
                controller: pageController,
                itemCount: 1, // Only one image for now
                itemBuilder: (context, index) {
                  return Container(
                    width: w,
                    height: h,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      image: DecorationImage(
                        image: AssetImage('assets/coffeeday.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                top: 16,
                left: 16,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(1, (index) {
                    return AnimatedBuilder(
                      animation: pageController,
                      builder: (context, child) {
                        double selectedness = Curves.easeOut.transform(
                          max(
                              0.0,
                              1.0 -
                                  ((pageController.page ??
                                              pageController.initialPage) -
                                          index)
                                      .abs()),
                        );
                        double zoom = 1.0 + (selectedness * 0.3);
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(selectedness),
                          ),
                          child: Transform.scale(
                            scale: zoom,
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
