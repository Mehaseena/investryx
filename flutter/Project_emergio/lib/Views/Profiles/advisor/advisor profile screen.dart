// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import '../../Widgets/add testimonal widget.dart';
// import '../../Widgets/shimmer widget profile.dart';
// import '../../services/profile forms/advisor/advisor get.dart';
// import '../../services/testimonial/testimonial get.dart';
// import '../edit profile/advisor edit.dart';
// import 'Advisor form.dart';
//
//
//
// class AdvisorProfileScreen extends StatefulWidget {
//   const AdvisorProfileScreen({super.key});
//
//   @override
//   State<AdvisorProfileScreen> createState() => _AdvisorProfileScreenState();
// }
//
// class _AdvisorProfileScreenState extends State<AdvisorProfileScreen>
//     with SingleTickerProviderStateMixin {
//   late Future<List<Advisor>?> futureAdvisors;
//   late TabController _tabController;
//   List<Map<String, dynamic>> _testimonials = [];
//   bool _isLoadingTestimonials = false;
//   late String userId;
//
//   @override
//   void initState() {
//     super.initState();
//     futureAdvisors = AdvisorFetchPage.fetchAdvisorData();
//     _tabController = TabController(length: 2, vsync: this);
//     _fetchTestimonials();
//   }
//
//   Future<void> _fetchTestimonials() async {
//     setState(() {
//       _isLoadingTestimonials = true;
//     });
//     print("Fetching testimonials");
//     final testimonials = await TestimonialGet.fetchTestimonials(userId: '');
//
//     setState(() {
//       _isLoadingTestimonials = false;
//       _testimonials = testimonials ?? [];
//     });
//   }
//
//   Future<void> _refreshTestimonials() async {
//     await _fetchTestimonials();
//   }
//
//   void _addTestimonial() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AddTestimonialDialog(
//           onTestimonialAdded: _refreshTestimonials,
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(6.0),
//             child: TextButton(
//               onPressed: () async {
//                 final advisors = await futureAdvisors;
//                 if (advisors != null && advisors.isNotEmpty) {
//                   final advisorId = advisors[0].id;
//                   // Wait for the result from the update screen
//                   await Get.to(() => UpdateAdvisorScreen(advisorId: advisorId));
//                   // Refresh the data after returning
//                   setState(() {
//                     futureAdvisors = AdvisorFetchPage.fetchAdvisorData();
//                   });
//                 }
//               },
//               child: Text('Edit Profile'),
//             ),
//
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<Advisor>?>(
//         future: futureAdvisors,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return AdvisorDetailShimmer();
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             Future.microtask(() => Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => AdvisorFormScreen()),
//             ));
//             return Container();
//           } else {
//             final advisor = snapshot.data![0];
//             return Column(
//               children: [
//                 SizedBox(height: h * 0.03),
//                 CircleAvatar(
//                   radius: h * .08,
//                   backgroundImage: NetworkImage(
//                       advisor.imageUrl ?? 'assets/default_profile_picture.jpg'),
//                 ),
//                 SizedBox(height: h * .02),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       advisor.name ?? 'Name not available',
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       advisor.designation ?? 'Location not available',
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: h * 0.015),
//                 TabBar(
//                   controller: _tabController,
//                   tabs: [
//                     Tab(text: 'Personal Info'),
//                     Tab(text: 'Testimonials'),
//                   ],
//                   indicatorColor: Colors.blue,
//                 ),
//                 SizedBox(height: h * 0.02),
//                 Expanded(
//                   child: TabBarView(
//                     controller: _tabController,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: w * 0.05),
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               Container(
//                                 height: 230.h,
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   color: Color(0xff3D3F54),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 16.0, top: 16),
//                                       child: Text(
//                                         'About Me',
//                                         style: TextStyle(
//                                           fontSize: h * 0.018,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 8.0),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 16.0, top: 10),
//                                       child: Text(
//                                         'Website: ${advisor.url ?? 'No URL available.'}',
//                                         style: TextStyle(
//                                           fontSize: h * 0.015,
//                                           color: Color(0xffD9D9D9),
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 16.0, top: 10),
//                                       child: Text(
//                                         'Phone: ${advisor.contactNumber ?? 'No contact number available.'}',
//                                         style: TextStyle(
//                                           fontSize: h * 0.015,
//                                           color: Color(0xffD9D9D9),
//                                         ),
//                                       ),
//                                     ),
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 16.0, top: 10),
//                                           child: Text(
//                                             'State: ${advisor.state ?? 'No state available.'}',
//                                             style: TextStyle(
//                                               fontSize: h * 0.015,
//                                               color: Color(0xffD9D9D9),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 16.0, top: 10),
//                                           child: Text(
//                                             'City: ${advisor.location ?? 'No city available.'}',
//                                             style: TextStyle(
//                                               fontSize: h * 0.015,
//                                               color: Color(0xffD9D9D9),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 16.0, top: 10),
//                                       child: Text(
//                                         'Area of interest: ${advisor.interest ?? 'No description available.'}',
//                                         style: TextStyle(
//                                           fontSize: h * 0.015,
//                                           color: Color(0xffD9D9D9),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: h * 0.015),
//                               Container(
//                                 height: h * 0.25,
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   color: Colors.black87,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 16.0, top: 10),
//                                   child: Text(
//                                     'Description: ${advisor.description ?? 'No description available.'}',
//                                     style: TextStyle(
//                                       fontSize: h * 0.015,
//                                       color: Color(0xffD9D9D9),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: h * 0.015),
//                             ],
//                           ),
//                         ),
//                       ),
//                       RefreshIndicator(
//                         onRefresh: _refreshTestimonials,
//                         child: Stack(
//                           children: [
//                             _isLoadingTestimonials
//                                 ? Center(
//                               child: Lottie.asset(
//                                 'assets/loading.json',
//                                 height: 70.h,
//                                 width: 150.w,
//                                 fit: BoxFit.cover,
//                               ),
//                             )
//                                 : _testimonials.isEmpty
//                                 ? Center(
//                                 child:
//                                 Text('No testimonials available.'))
//                                 : ListView.builder(
//                               itemCount: _testimonials.length,
//                               itemBuilder: (context, index) {
//                                 var testimonial = _testimonials[index];
//                                 return Slidable(
//                                   key: Key(testimonial['id'].toString()),
//                                   endActionPane: ActionPane(
//                                     motion: const ScrollMotion(),
//                                     children: [
//                                       SlidableAction(
//                                         onPressed: (context) async {
//                                           bool? shouldDelete = await showDialog(
//                                             context: context,
//                                             builder: (BuildContext context) {
//                                               return AlertDialog(
//                                                 title: Text("Delete Confirmation"),
//                                                 content: Text("Are you sure you want to delete this testimonial?"),
//                                                 actions: <Widget>[
//                                                   TextButton(
//                                                     onPressed: () => Navigator.of(context).pop(false),
//                                                     child: Text("Cancel"),
//                                                   ),
//                                                   TextButton(
//                                                     onPressed: () {
//                                                       Navigator.of(context).pop(true);
//                                                     },
//                                                     child: Text("Delete"),
//                                                   ),
//                                                 ],
//                                               );
//                                             },
//                                           );
//
//                                           if (shouldDelete == true) {
//                                             await TestimonialGet.deleteTestimonial(testimonial['id'].toString());
//                                             setState(() {
//                                               _testimonials.removeAt(index);
//                                             });
//                                           }
//                                         },
//                                         backgroundColor: Colors.red,
//                                         foregroundColor: Colors.white,
//                                         icon: Icons.delete,
//                                         label: 'Delete',
//                                       ),
//                                     ],
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 4.0, right: 4, bottom: 4),
//                                     child: ListTile(
//                                       contentPadding: EdgeInsets.all(12.0),
//                                       leading: Container(
//                                         width: 50,
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           color: Colors.blueAccent.withOpacity(0.1),
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: Icon(
//                                           Icons.person,
//                                           size: 30,
//                                           color: Colors.blueAccent,
//                                         ),
//                                       ),
//                                       title: Text(
//                                         testimonial['company'] ?? 'Company name not available',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16.0,
//                                           color: Colors.black87,
//                                         ),
//                                       ),
//                                       subtitle: Padding(
//                                         padding: const EdgeInsets.only(top: 4.0),
//                                         child: Text(
//                                           testimonial['testimonial'] ?? 'No testimonial available.',
//                                           style: TextStyle(
//                                             fontSize: 14.0,
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                       ),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10.0),
//                                         side: BorderSide(color: Colors.grey[300]!, width: 1),
//                                       ),
//                                       tileColor: Colors.white,
//                                       trailing: Container(
//                                         padding: EdgeInsets.all(8.0),
//                                         decoration: BoxDecoration(
//                                           color: Colors.blueAccent.withOpacity(0.1),
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: Icon(
//                                           Icons.format_quote,
//                                           color: Colors.blueAccent,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//
//                               },
//                             ),
//                             Positioned(
//                               bottom: 20,
//                               right: 20,
//                               child: FloatingActionButton(
//                                 backgroundColor: Color(0xff003C82),
//                                 onPressed: _addTestimonial,
//                                 child: Icon(Icons.add, color: Colors.white),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:dismissible_page/dismissible_page.dart';
import '../../../Widgets/add testimonal widget.dart';
import '../../../Widgets/shimmer widget profile.dart';
import '../../../services/profile forms/advisor/advisor get.dart';
import '../../../services/testimonial/testimonial get.dart';
import '../../edit profile/advisor edit.dart';
import 'Advisor form.dart';

class AdvisorProfileScreen extends StatefulWidget {
  const AdvisorProfileScreen({super.key});

  @override
  State<AdvisorProfileScreen> createState() => _AdvisorProfileScreenState();
}

class _AdvisorProfileScreenState extends State<AdvisorProfileScreen>
    with SingleTickerProviderStateMixin {
  late Future<List<Advisor>?> futureAdvisors;
  late TabController _tabController;
  List<Map<String, dynamic>> _testimonials = [];
  bool _isLoadingTestimonials = false;
  late String userId;

  @override
  void initState() {
    super.initState();
    futureAdvisors = AdvisorFetchPage.fetchAdvisorData();
    _tabController = TabController(length: 2, vsync: this);
    _fetchTestimonials();
  }

  Future<void> _fetchTestimonials() async {
    setState(() {
      _isLoadingTestimonials = true;
    });
    print("Fetching testimonials");
    final testimonials = await TestimonialGet.fetchTestimonials(userId: '');

    setState(() {
      _isLoadingTestimonials = false;
      _testimonials = testimonials ?? [];
    });
  }

  Future<void> _refreshTestimonials() async {
    await _fetchTestimonials();
  }

  void _addTestimonial() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTestimonialDialog(
          onTestimonialAdded: _refreshTestimonials,
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
        actions: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextButton(
              onPressed: () async {
                final advisors = await futureAdvisors;
                if (advisors != null && advisors.isNotEmpty) {
                  final advisorId = advisors[0].id;
                  await Get.to(() => UpdateAdvisorScreen(advisorId: advisorId));
                  setState(() {
                    futureAdvisors = AdvisorFetchPage.fetchAdvisorData();
                  });
                }
              },
              child: Text('Edit Profile'),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Advisor>?>(
        future: futureAdvisors,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AdvisorDetailShimmer();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            Future.microtask(() => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdvisorFormScreen()),
            ));
            return Container();
          } else {
            final advisor = snapshot.data![0];
            return Column(
              children: [
                SizedBox(height: h * 0.03),
                CircleAvatar(
                  radius: h * .08,
                  backgroundImage: NetworkImage(
                      advisor.imageUrl ?? 'assets/default_profile_picture.jpg'),
                ),
                SizedBox(height: h * .02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      advisor.name ?? 'Name not available',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      advisor.designation ?? 'Location not available',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.015),
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: 'Personal Info'),
                    Tab(text: 'Testimonials'),
                  ],
                  indicatorColor: Colors.blue,
                ),
                SizedBox(height: h * 0.02),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 230.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xff3D3F54),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, top: 16),
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
                                      padding: const EdgeInsets.only(
                                          left: 16.0, top: 10),
                                      child: Text(
                                        'Website: ${advisor.url ?? 'No URL available.'}',
                                        style: TextStyle(
                                          fontSize: h * 0.015,
                                          color: Color(0xffD9D9D9),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, top: 10),
                                      child: Text(
                                        'Phone: ${advisor.contactNumber ?? 'No contact number available.'}',
                                        style: TextStyle(
                                          fontSize: h * 0.015,
                                          color: Color(0xffD9D9D9),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0, top: 10),
                                          child: Text(
                                            'State: ${advisor.state ?? 'No state available.'}',
                                            style: TextStyle(
                                              fontSize: h * 0.015,
                                              color: Color(0xffD9D9D9),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0, top: 10),
                                          child: Text(
                                            'City: ${advisor.location ?? 'No city available.'}',
                                            style: TextStyle(
                                              fontSize: h * 0.015,
                                              color: Color(0xffD9D9D9),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, top: 10),
                                      child: Text(
                                        'Area of interest: ${advisor.interest ?? 'No description available.'}',
                                        style: TextStyle(
                                          fontSize: h * 0.015,
                                          color: Color(0xffD9D9D9),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: h * 0.015),
                              Container(
                                height: h * 0.25,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 10),
                                  child: Text(
                                    'Description: ${advisor.description ?? 'No description available.'}',
                                    style: TextStyle(
                                      fontSize: h * 0.015,
                                      color: Color(0xffD9D9D9),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: h * 0.015),
                            ],
                          ),
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: _refreshTestimonials,
                        child: Stack(
                          children: [
                            _isLoadingTestimonials
                                ? Center(
                              child: Lottie.asset(
                                'assets/loading.json',
                                height: 70.h,
                                width: 150.w,
                                fit: BoxFit.cover,
                              ),
                            )
                                : _testimonials.isEmpty
                                ? Center(child: Text('No testimonials available.'))
                                : ListView.builder(
                              itemCount: _testimonials.length,
                              itemBuilder: (context, index) {
                                var testimonial = _testimonials[index];
                                return DismissiblePage(
                                  onDismissed: () async {
                                    bool? shouldDelete = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Delete Confirmation"),
                                          content: Text("Are you sure you want to delete this testimonial?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.of(context).pop(false),
                                              child: Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                              },
                                              child: Text("Delete"),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    if (shouldDelete == true) {
                                      await TestimonialGet.deleteTestimonial(testimonial['id'].toString());
                                      setState(() {
                                        _testimonials.removeAt(index);
                                      });
                                    }
                                  },
                                  direction: DismissiblePageDismissDirection.endToStart,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4.0, right: 4, bottom: 4),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(12.0),
                                      leading: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          size: 30,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      title: Text(
                                        testimonial['company'] ?? 'Company name not available',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          testimonial['testimonial'] ?? 'No testimonial available.',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side: BorderSide(color: Colors.grey[300]!, width: 1),
                                      ),
                                      tileColor: Colors.white,
                                      trailing: Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.format_quote,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              bottom: 20,
                              right: 20,
                              child: FloatingActionButton(
                                backgroundColor: Color(0xff003C82),
                                onPressed: _addTestimonial,
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}