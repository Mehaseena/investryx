// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
// import 'package:project_emergio/Views/pricing%20screen.dart';
// import 'package:project_emergio/Widgets/shimmer%20widget.dart';
// import 'package:project_emergio/services/check%20subscribe.dart';
// import 'package:timeago/timeago.dart' as timeago;
// import 'package:project_emergio/Views/Profiles/Business%20addPage.dart';
// import 'package:project_emergio/Views/detail%20page/business%20deatil%20page.dart';
// import '../../services/profile forms/business/business get.dart';
//
// class BusinessListingsScreen extends StatefulWidget {
//   const BusinessListingsScreen({super.key});
//
//   @override
//   _BusinessListingsScreenState createState() => _BusinessListingsScreenState();
// }
//
// class _BusinessListingsScreenState extends State<BusinessListingsScreen> {
//   late Future<List<Business>?> _businesses;
//
//   @override
//   void initState() {
//     super.initState();
//     _businesses = BusinessGet.fetchBusinessListings();
//   }
//
//
//   Future<void> _refreshBusinesses() async {
//     setState(() {
//       _businesses = BusinessGet.fetchBusinessListings();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: FloatingActionButton(
//           backgroundColor: Color(0xff003C82),
//           onPressed: () async {
//             // Fetch the subscription status
//             var subscription = await CheckSubscription.fetchSubscription();
//
//             if (subscription!) {
//               // Navigate to the BusinessInfoPage and refresh businesses
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => BusinessInfoPage()),
//               ).then((_) => _refreshBusinesses());
//             } else {
//               // Show an alert and then navigate to the pricing screen
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('Subscription Status'),
//                     content: Text('You have not purchased any plans. Please visit the pricing page to choose a plan.'),
//                     actions: [
//                       TextButton(
//                         child: Text('Cancel'),
//                         onPressed: () {
//                           Navigator.of(context).pop(); // Close the alert dialog
//                         },
//                       ),
//                       TextButton(
//                         child: Text('View plans'),
//                         onPressed: () {
//                           Navigator.of(context).pop(); // Close the alert dialog
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => PricingPage()),
//                           );
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               );
//             }
//           },
//
//           child: Icon(Icons.add, color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.search),
//                   hintText: 'Search For a Business',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//
//                 ),
//               ),
//             ),
//             Expanded(
//               child: FutureBuilder<List<Business>?>(
//                 future: _businesses,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     // Use a default itemCount for shimmer while data is loading
//                     return const CustomShimmerLoading(itemCount: 4);
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Center(child: const Text('No businesses found.'));
//                   } else {
//                     return ListView.builder(
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         var business = snapshot.data![index];
//                         return BusinessCard(
//                           business: business,
//                           onDelete: () async {
//                             try {
//                               await BusinessGet.deleteBusiness(business.id!);
//                               _refreshBusinesses();
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(content: Text('Business deleted successfully')),
//                               );
//                             } catch (e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(content: Text('Failed to delete business')),
//                               );
//                             }
//                           },
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class BusinessCard extends StatelessWidget {
//   final Business business;
//   final VoidCallback onDelete;
//
//   const BusinessCard({
//     super.key,
//     required this.business,
//     required this.onDelete,
//   });
//
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
//             builder: (context) => BusinessDetailPage(
//               imageUrl: business.imageUrl,
//               name: business.name,
//               industry: business.industry,
//               establish_yr: business.establish_yr,
//               description: business.description,
//               address_1: business.address_1,
//               address_2: business.address_2,
//               pin: business.pin,
//               city: business.city,
//               state: business.state,
//               employees: business.employees,
//               entity: business.entity,
//               avg_monthly: business.avg_monthly,
//               latest_yearly: business.latest_yearly,
//               ebitda: business.ebitda,
//               rate: business.rate,
//               type_sale: business.type_sale,
//               url: business.url,
//               features: business.features,
//               facility: business.facility,
//               income_source: business.income_source,
//               reason: business.reason,
//               postedTime: business.postedTime,
//               topSelling: business.topSelling,
//               id: business.id,
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
//                 business.imageUrl,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: 200.0,
//               ),
//               SizedBox(height: 8.0),
//               Text(
//                 business.name,
//                 style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 4.0),
//               Row(
//                 children: [
//                   Icon(Icons.location_on, size: 16.0, color: Colors.red),
//                   SizedBox(width: 4.0),
//                   Text(business.city),
//                 ],
//               ),
//               SizedBox(height: 4.0),
//               Row(
//                 children: [
//                   Icon(Icons.access_time, size: 16.0, color: Colors.green),
//                   SizedBox(width: 4.0),
//                   Text(formatDateTime(business.postedTime) ?? 'N/A'),
//                 ],
//               ),
//               SizedBox(height: 8.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   // Text(
//                   //   'View >',
//                   //   style: TextStyle(
//                   //     color: Colors.blue,
//                   //     fontWeight: FontWeight.bold,
//                   //   ),
//                   // ),
//                   IconButton(
//                     icon:  Row(
//                       children: [
//                         Icon(Icons.delete, color: Colors.red),
//                         Text('Delete', style: TextStyle(color: Colors.red)),
//                       ],
//                     ),
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                           title: Text('Delete Business'),
//                           content: Text('Are you sure you want to delete this business?'),
//                           actions: [
//                             TextButton(
//                               child: Text('Cancel'),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                             TextButton(
//                               child: Text('Delete'),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                                 onDelete();
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
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
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:project_emergio/Views/pricing%20screen.dart';
import 'package:project_emergio/Widgets/shimmer%20widget.dart';
import 'package:project_emergio/services/check%20subscribe.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:project_emergio/Views/Profiles/Business/Business%20addPage.dart';
import 'package:project_emergio/Views/detail%20page/business%20deatil%20page.dart';
import '../../../services/profile forms/business/business get.dart';

class BusinessListingsScreen extends StatefulWidget {
  const BusinessListingsScreen({super.key});

  @override
  _BusinessListingsScreenState createState() => _BusinessListingsScreenState();
}

class _BusinessListingsScreenState extends State<BusinessListingsScreen> {
  late Future<List<Business>?> _businesses;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _businesses = BusinessGet.fetchBusinessListings();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  Future<void> _refreshBusinesses() async {
    setState(() {
      _businesses = BusinessGet.fetchBusinessListings();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xff003C82),
          onPressed: () async {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => BusinessInfoPage()));
           /// Fetch the subscription status
            var subscription = await CheckSubscription.fetchSubscription();
            if (subscription['status']) {
              // Navigate to the BusinessInfoPage and refresh businesses
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BusinessInfoPage()),
              ).then((_) => _refreshBusinesses());
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search For a Business',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Business>?>(
                future: _businesses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CustomShimmerLoading(itemCount: 4);
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: const Text('No businesses found.'));
                  } else {
                    var filteredBusinesses = snapshot.data!.where((business) {
                      return (business.name?.toLowerCase().contains(_searchQuery) ?? false) ||
                          (business.city?.toLowerCase().contains(_searchQuery) ?? false) ||
                          (business.industry?.toLowerCase().contains(_searchQuery) ?? false);
                    }).toList();


                    if (filteredBusinesses.isEmpty) {
                      return Center(child: const Text('No businesses match your search.'));
                    }

                    return ListView.builder(
                      itemCount: filteredBusinesses.length,
                      itemBuilder: (context, index) {
                        var business = filteredBusinesses[index];
                        return BusinessCard(
                          business: business,
                          onDelete: () async {
                            try {
                              await BusinessGet.deleteBusiness(business.id!);
                              _refreshBusinesses();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Business deleted successfully')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Failed to delete business')),
                              );
                            }
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BusinessCard extends StatelessWidget {
  final Business business;
  final VoidCallback onDelete;

  const BusinessCard({
    super.key,
    required this.business,
    required this.onDelete,
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
            builder: (context) => BusinessDetailPage(
              imageUrl: business.imageUrl,
              image2: business.image2,
              image3: business.image3,
              image4: business.image4,
              name: business.name,
              industry: business.industry,
              establish_yr: business.establish_yr,
              description: business.description,
              address_1: business.address_1,
              address_2: business.address_2,
              pin: business.pin,
              city: business.city,
              state: business.state,
              employees: business.employees,
              entity: business.entity,
              avg_monthly: business.avg_monthly,
              latest_yearly: business.latest_yearly,
              ebitda: business.ebitda,
              rate: business.rate,
              type_sale: business.type_sale,
              url: business.url,
              features: business.features,
              facility: business.facility,
              income_source: business.income_source,
              reason: business.reason,
              postedTime: business.postedTime,
              topSelling: business.topSelling,
              id: business.id,

              showEditOption: true,
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
                business.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
              SizedBox(height: 8.0),
              Text(
                business.name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16.0, color: Colors.red),
                  SizedBox(width: 4.0),
                  Text(business.city),
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16.0, color: Colors.green),
                  SizedBox(width: 4.0),
                  Text(formatDateTime(business.postedTime) ?? 'N/A'),
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Delete Business'),
                          content: Text('Are you sure you want to delete this business?'),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Delete'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                onDelete();
                              },
                            ),
                          ],
                        ),
                      );
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
