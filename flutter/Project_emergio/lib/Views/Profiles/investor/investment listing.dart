// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
// import 'package:project_emergio/Views/Profiles/Investor%20form.dart';
// import '../../Widgets/shimmer widget.dart';
// import '../../services/profile forms/investor/investor get.dart';
// import '../detail page/invester detail page.dart';
// import 'package:timeago/timeago.dart' as timeago;
//
// class InvestorListingsScreen extends StatefulWidget {
//   const InvestorListingsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<InvestorListingsScreen> createState() => _InvestorListingsScreenState();
// }
//
// class _InvestorListingsScreenState extends State<InvestorListingsScreen> {
//   List<Investor>? _investors;
//   List<Investor>? _filteredInvestors;
//   final TextEditingController _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchInvestors();
//     _searchController.addListener(_filterInvestors);
//   }
//
//   void _fetchInvestors() async {
//     try {
//       final investors = await InvestorFetchPage.fetchInvestorData();
//       setState(() {
//         _investors = investors;
//         _filteredInvestors = investors;
//       });
//     } catch (e) {
//       // Handle error
//       log('Error fetching investors: $e');
//     }
//   }
//
//   void _filterInvestors() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       _filteredInvestors = _investors?.where((investor) {
//         return investor.companyName!.toLowerCase().contains(query);
//       }).toList();
//     });
//   }
//
//   void _showDeleteConfirmationDialog(
//       BuildContext context, String investorId, int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delete Investor'),
//           content: Text('Are you sure you want to delete this investor?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Dismiss the dialog
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 Navigator.of(context).pop(); // Dismiss the dialog
//                 try {
//                   await InvestorFetchPage.deleteInvestor(investorId);
//                   _removeInvestor(index);
//                 } catch (e) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Failed to delete investor: $e'),
//                       duration: Duration(seconds: 3),
//                     ),
//                   );
//                 }
//               },
//               child: Text('Delete', style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _removeInvestor(int index) {
//     setState(() {
//       _filteredInvestors?.removeAt(index);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         shadowColor: Colors.white,
//         surfaceTintColor: Colors.white,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text('Investor Listings'),
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: FloatingActionButton(
//           backgroundColor: Color(0xff003C82),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => InvestorFormScreen()),
//             );
//           },
//           child: Icon(Icons.add, color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.search),
//                   hintText: 'Search For an Investor',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//
//                 ),
//               ),
//             ),
//             Expanded(
//               child: _filteredInvestors == null
//                   ? CustomShimmerLoading(itemCount: 4)
//                   : _filteredInvestors!.isEmpty
//                       ? Center(child: Text('No investor data found.'))
//                       : ListView.builder(
//                           itemCount: _filteredInvestors!.length,
//                           itemBuilder: (context, index) {
//                             var investorData = _filteredInvestors![index];
//                             return InvestorCard(
//                               index: index,
//                               investorId: investorData.id,
//                               imageUrl: investorData.imageUrl,
//                               name: investorData.name,
//                               city: investorData.city,
//                               postedTime: investorData.postedTime,
//                               state: investorData.state,
//                               industry: investorData.industry,
//                               description: investorData.description,
//                               url: investorData.url,
//                               rangeStarting: investorData.rangeStarting,
//                               rangeEnding: investorData.rangeEnding,
//                               evaluatingAspects: investorData.evaluatingAspects,
//                               CompanyName: investorData.companyName,
//                               locationInterested:
//                                   investorData.locationIntrested,
//                               onDelete: (investorId, index) =>
//                                   _showDeleteConfirmationDialog(
//                                       context, investorId, index),
//                               id: investorData.id,
//                             );
//                           },
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class InvestorCard extends StatelessWidget {
//   final int index;
//   final String investorId;
//   final String imageUrl;
//   final String name;
//   final String city;
//   final String postedTime;
//   final String? state;
//   final String? industry;
//   final String? description;
//   final String? url;
//   final String? rangeStarting;
//   final String? rangeEnding;
//   final String? evaluatingAspects;
//   final String? locationInterested;
//   final String? CompanyName;
//   final String id;
//   final Function(String, int) onDelete;
//
//   const InvestorCard({
//     required this.index,
//     required this.investorId,
//     required this.imageUrl,
//     required this.name,
//     required this.city,
//     required this.postedTime,
//     this.state,
//     this.industry,
//     this.description,
//     this.url,
//     this.rangeStarting,
//     this.rangeEnding,
//     this.evaluatingAspects,
//     this.CompanyName,
//     required this.onDelete,
//     this.locationInterested,
//     required this.id,
//   });
//   String formatDateTime(String dateTimeStr) {
//     DateTime dateTime = DateTime.parse(dateTimeStr);
//     return timeago.format(dateTime, allowFromNow: true);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => InvestorDetailPage(
//               imageUrl: imageUrl,
//               name: name,
//               city: city,
//               postedTime: postedTime,
//               state: state,
//               industry: industry,
//               description: description,
//               url: url,
//               rangeStarting: rangeStarting,
//               rangeEnding: rangeEnding,
//               evaluatingAspects: evaluatingAspects,
//               CompanyName: CompanyName,
//               locationInterested: locationInterested,
//               id: id,
//               showEditOption: true,
//             ),
//           ),
//         );
//       },
//       child: Card(
//         margin: EdgeInsets.symmetric(vertical: 8.0),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.network(
//                 imageUrl,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: 200.0,
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 CompanyName!,
//                 style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 4.0),
//               Row(
//                 children: [
//                   Icon(Icons.location_on, size: 16.0, color: Colors.red),
//                   SizedBox(width: 4.0),
//                   Text(city),
//                 ],
//               ),
//               SizedBox(height: 4.0),
//               Row(
//                 children: [
//                   Icon(Icons.access_time, size: 16.0, color: Colors.green),
//                   SizedBox(width: 4.0),
//                   Text(formatDateTime(postedTime) ?? 'N/A'),
//                 ],
//               ),
//               SizedBox(height: 8.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   IconButton(
//                     icon: Row(
//                       children: [
//                         Icon(Icons.delete, color: Colors.red),
//                         Text('Delete', style: TextStyle(color: Colors.red)),
//                       ],
//                     ),
//                     onPressed: () => onDelete(investorId, index),
//                   ),
//                   // SizedBox(width: 10),
//                   // Text(
//                   //   'View Details >',
//                   //   style: TextStyle(
//                   //     color: Colors.blue,
//                   //     fontWeight: FontWeight.bold,
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_emergio/Views/Profiles/investor/Investor%20form.dart';
import '../../../Widgets/shimmer widget.dart';
import '../../../services/check subscribe.dart';
import '../../../services/profile forms/investor/investor get.dart';
import '../../detail page/invester detail page.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:share_plus/share_plus.dart';

import '../../pricing screen.dart';


class InvestorListingsScreen extends StatefulWidget {
  const InvestorListingsScreen({Key? key}) : super(key: key);

  @override
  State<InvestorListingsScreen> createState() => _InvestorListingsScreenState();
}

class _InvestorListingsScreenState extends State<InvestorListingsScreen> {
  List<Investor>? _investors;
  List<Investor>? _filteredInvestors;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchInvestors();
    _searchController.addListener(_filterInvestors);
  }

  void _fetchInvestors() async {
    try {
      final investors = await InvestorFetchPage.fetchInvestorData();
      setState(() {
        _investors = investors;
        _filteredInvestors = investors;
      });
    } catch (e) {
      // Handle error
      log('Error fetching investors: $e');
    }
  }

  void _filterInvestors() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredInvestors = _investors?.where((investor) {
        return investor.companyName!.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, String investorId, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Investor'),
          content: Text('Are you sure you want to delete this investor?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Dismiss the dialog
                try {
                  await InvestorFetchPage.deleteInvestor(investorId);
                  _removeInvestor(index);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete investor: $e'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _removeInvestor(int index) {
    setState(() {
      _filteredInvestors?.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Investor Listings'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xff003C82),
          onPressed: () async {
            /// Fetch the subscription status
            var subscription = await CheckSubscription.fetchSubscription();
            if (subscription['status']) {
              // Navigate to the BusinessInfoPage and refresh businesses
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InvestorFormScreen()),
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
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search For an Investor',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                ),
              ),
            ),
            Expanded(
              child: _filteredInvestors == null
                  ? CustomShimmerLoading(itemCount: 4)
                  : _filteredInvestors!.isEmpty
                  ? Center(child: Text('No investor data found.'))
                  : ListView.builder(
                itemCount: _filteredInvestors!.length,
                itemBuilder: (context, index) {
                  var investorData = _filteredInvestors![index];
                  return InvestorCard(
                    index: index,
                    investorId: investorData.id,
                    imageUrl: investorData.imageUrl,
                    name: investorData.name,
                    city: investorData.city,
                    postedTime: investorData.postedTime,
                    state: investorData.state,
                    industry: investorData.industry,
                    description: investorData.description,
                    url: investorData.url,
                    rangeStarting: investorData.rangeStarting,
                    rangeEnding: investorData.rangeEnding,
                    evaluatingAspects: investorData.evaluatingAspects,
                    CompanyName: investorData.companyName,
                    locationInterested:
                    investorData.locationIntrested,
                    onDelete: (investorId, index) =>
                        _showDeleteConfirmationDialog(
                            context, investorId, index),
                    id: investorData.id,
                    image2: investorData.image2,
                    image3: investorData.image3,
                    image4: investorData.image4,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class InvestorCard extends StatelessWidget {
  final int index;
  final String investorId;
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
  final String? locationInterested;
  final String? CompanyName;
  final String id;
  final String image2;
  final String image3;
  final String? image4;

  final Function(String, int) onDelete;

  const InvestorCard({
    required this.index,
    required this.investorId,
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
    required this.onDelete,
    this.locationInterested,
    required this.id,
    required this.image2,
    required this.image3,
    this.image4,
  });

  String formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    return timeago.format(dateTime, allowFromNow: true);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InvestorDetailPage(
              imageUrl: imageUrl,
              name: name,
              city: city,
              postedTime: postedTime,
              state: state,
              industry: industry,
              description: description,
              url: url,
              rangeStarting: rangeStarting,
              rangeEnding: rangeEnding,
              evaluatingAspects: evaluatingAspects,
              CompanyName: CompanyName,
              locationInterested: locationInterested,
              id: id,
              showEditOption: true,
              image2: image2,
              image3: image3,
              image4: image4,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
              SizedBox(height: 8.0),
              Text(
                CompanyName!,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16.0, color: Colors.red),
                  SizedBox(width: 4.0),
                  Text(city),
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16.0, color: Colors.green),
                  SizedBox(width: 4.0),
                  Text(formatDateTime(postedTime) ?? 'N/A'),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    onPressed: () => onDelete(investorId, index),
                  ),
                  IconButton(
                    icon: Row(
                      children: [
                        Icon(Icons.share, color: Colors.blue),
                        Text('Share', style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                    onPressed: () {
                      // Content to be shared
                      final contentToShare =
                          'Check out this investor:\n\nCompany Name: $CompanyName\nLocation: $city, $state\nIndustry: $industry\nDescription: $description\nPosted: ${formatDateTime(postedTime)}\n';

                      // Share the content
                      Share.share(contentToShare);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
