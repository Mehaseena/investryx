// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../services/api_list.dart';
// import '../../services/profile forms/franchise/franchise get.dart';
// import '../detail page/franchise detail page.dart';
// import 'Franchise Form.dart';
//
// class FranchiseFetchPage {
//   static var client = http.Client();
//
//   static Future<List<Franchise>?> fetchFranchiseData() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userId = prefs.getInt('userId');
//       if (userId == null) {
//         log('Error: userId not found in SharedPreferences');
//         return null;
//       }
//
//       var response = await client.get(Uri.parse('${ApiList.franchiseAddPage}0$userId'));
//
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body) as List;
//         List<Franchise> franchises = data.map((json) => Franchise.fromJson(json)).toList();
//         return franchises;
//       } else {
//         log('Failed to fetch franchise data: ${response.statusCode}');
//         return null;
//       }
//     } on SocketException catch (e) {
//       log('SocketException: ${e.message}');
//       return null;
//     } on http.ClientException catch (e) {
//       log('ClientException: ${e.message}');
//       return null;
//     } catch (e) {
//       log('Unexpected error: $e');
//       return null;
//     }
//   }
//
//   static Future<void> deleteFranchise(String id) async
//   {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userId = prefs.getInt('userId');
//       if (userId == null) {
//         log('Error: userId not found in SharedPreferences');
//         throw Exception('User ID not found');
//       }
//
//       var response = await client.delete(
//         Uri.parse('${ApiList.franchiseAddPage}$id'),
//       );
//
//       if (response.statusCode == 200) {
//         log('Franchise deleted successfully');
//       } else {
//         throw Exception('Failed to delete franchise: ${response.statusCode}');
//       }
//     } on SocketException catch (e) {
//       log('SocketException: ${e.message}');
//       throw Exception('Failed to delete franchise: ${e.message}');
//     } on http.ClientException catch (e) {
//       log('ClientException: ${e.message}');
//       throw Exception('Failed to delete franchise: ${e.message}');
//     } catch (e) {
//       log('Unexpected error: $e');
//       throw Exception('Failed to delete franchise: $e');
//     }
//   }
//  }
//
// class FranchiseListingsScreen extends StatefulWidget {
//   const FranchiseListingsScreen({Key? key}) : super(key: key);
//
//   @override
//   _FranchiseListingsScreenState createState() => _FranchiseListingsScreenState();
// }
//
// class _FranchiseListingsScreenState extends State<FranchiseListingsScreen> {
//   List<Franchise>? _franchises;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchFranchises();
//   }
//
//   Future<void> fetchFranchises() async {
//     var franchises = await FranchiseFetchPage.fetchFranchiseData();
//     setState(() {
//       _franchises = franchises;
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
//         title: Text('Franchise Listings'),
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: FloatingActionButton(
//           backgroundColor: Color(0xff003C82),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => FranchiseFormScreen()),
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
//               padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.search),
//                   hintText: 'Search For a Franchise',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   suffixIcon: Icon(Icons.filter_list),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: _franchises == null
//                   ? Center(child: CircularProgressIndicator())
//                   : _franchises!.isEmpty
//                   ? Center(child: Text('No franchise data found.'))
//                   : ListView.builder(
//                 itemCount: _franchises!.length,
//                 itemBuilder: (context, index) {
//                   var franchiseData = _franchises![index];
//                   return FranchiseCard(
//                     imageUrl: franchiseData.imageUrl,
//                     brandName: franchiseData.brandName,
//                     city: franchiseData.city,
//                     postedTime: franchiseData.postedTime,
//                     state: franchiseData.state,
//                     industry: franchiseData.industry,
//                     description: franchiseData.description,
//                     url: franchiseData.url,
//                     initialInvestment: franchiseData.initialInvestment,
//                     projectedRoi: franchiseData.projectedRoi,
//                     iamOffering: franchiseData.iamOffering,
//                     currentNumberOfOutlets: franchiseData.currentNumberOfOutlets,
//                     franchiseTerms: franchiseData.franchiseTerms,
//                     locationsAvailable: franchiseData.locationsAvailable,
//                     kindOfSupport: franchiseData.kindOfSupport,
//                     allProducts: franchiseData.allProducts,
//                     brandStartOperation: franchiseData.brandStartOperation,
//                     spaceRequiredMin: franchiseData.spaceRequiredMin,
//                     spaceRequiredMax: franchiseData.spaceRequiredMax,
//                     totalInvestmentFrom: franchiseData.totalInvestmentFrom,
//                     totalInvestmentTo: franchiseData.totalInvestmentTo,
//                     brandFee: franchiseData.brandFee,
//                     avgNoOfStaff: franchiseData.avgNoOfStaff,
//                     avgMonthlySales: franchiseData.avgMonthlySales,
//                     avgEBITDA: franchiseData.avgEBITDA,
//                     id: franchiseData.id,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => FranchiseDetailPage(
//                             id: franchiseData.id,
//                             imageUrl: franchiseData.imageUrl,
//                             brandName: franchiseData.brandName,
//                             city: franchiseData.city,
//                             postedTime: franchiseData.postedTime,
//                             state: franchiseData.state,
//                             industry: franchiseData.industry,
//                             description: franchiseData.description,
//                             url: franchiseData.url,
//                             initialInvestment: franchiseData.initialInvestment,
//                             projectedRoi: franchiseData.projectedRoi,
//                             iamOffering: franchiseData.iamOffering,
//                             currentNumberOfOutlets: franchiseData.currentNumberOfOutlets,
//                             franchiseTerms: franchiseData.franchiseTerms,
//                             locationsAvailable: franchiseData.locationsAvailable,
//                             kindOfSupport: franchiseData.kindOfSupport,
//                             allProducts: franchiseData.allProducts,
//                             brandStartOperation: franchiseData.brandStartOperation,
//                             spaceRequiredMin: franchiseData.spaceRequiredMin,
//                             spaceRequiredMax: franchiseData.spaceRequiredMax,
//                             totalInvestmentFrom: franchiseData.totalInvestmentFrom,
//                             totalInvestmentTo: franchiseData.totalInvestmentTo,
//                             brandFee: franchiseData.brandFee,
//                             avgNoOfStaff: franchiseData.avgNoOfStaff,
//                             avgMonthlySales: franchiseData.avgMonthlySales,
//                             avgEBITDA: franchiseData.avgEBITDA,
//                           ),
//                         ),
//                       );
//                     },
//                     onDelete: () {
//                       _showDeleteConfirmationDialog(context, franchiseData.id, index);
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showDeleteConfirmationDialog(
//       BuildContext context, String franchiseId, int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delete Franchise'),
//           content: Text('Are you sure you want to delete this franchise?'),
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
//                   await FranchiseFetchPage.deleteFranchise(franchiseId);
//                   _removeFranchise(index);
//                 } catch (e) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Failed to delete franchise: $e'),
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
//   void _removeFranchise(int index) {
//     setState(() {
//       _franchises?.removeAt(index);
//     });
//   }
// }
//
// class FranchiseCard extends StatelessWidget {
//   final String imageUrl;
//   final String brandName;
//   final String city;
//   final String postedTime;
//   final String? state;
//   final String? industry;
//   final String? description;
//   final String? url;
//   final String? initialInvestment;
//   final String? projectedRoi;
//   final String? iamOffering;
//   final String? currentNumberOfOutlets;
//   final String? franchiseTerms;
//   final String? locationsAvailable;
//   final String? kindOfSupport;
//   final String? allProducts;
//   final String? brandStartOperation;
//   final String? spaceRequiredMin;
//   final String? spaceRequiredMax;
//   final String? totalInvestmentFrom;
//   final String? totalInvestmentTo;
//   final String? brandFee;
//   final String? avgNoOfStaff;
//   final String? avgMonthlySales;
//   final String? avgEBITDA;
//   final String id;
//   final VoidCallback? onTap;
//   final VoidCallback? onDelete;
//
//   const FranchiseCard({
//     required this.imageUrl,
//     required this.brandName,
//     required this.city,
//     required this.postedTime,
//     this.state,
//     this.industry,
//     this.description,
//     this.url,
//     this.initialInvestment,
//     this.projectedRoi,
//     this.iamOffering,
//     this.currentNumberOfOutlets,
//     this.franchiseTerms,
//     this.locationsAvailable,
//     this.kindOfSupport,
//     this.allProducts,
//     this.brandStartOperation,
//     this.spaceRequiredMin,
//     this.spaceRequiredMax,
//     this.totalInvestmentFrom,
//     this.totalInvestmentTo,
//     this.brandFee,
//     this.avgNoOfStaff,
//     this.avgMonthlySales,
//     this.avgEBITDA,
//     required this.id,
//     this.onTap,
//     this.onDelete,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8.0),
//       child: InkWell(
//         onTap: onTap,
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
//                 brandName,
//                 style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 4.0),
//               Row(
//                 children: [
//                   Icon(Icons.location_on, size: 16.0, color: Colors.red),
//                   SizedBox(width: 4.0),
//                   Text(locationsAvailable!),
//                 ],
//               ),
//               SizedBox(height: 4.0),
//               Row(
//                 children: [
//                   Icon(Icons.access_time, size: 16.0, color: Colors.green),
//                   SizedBox(width: 4.0),
//                   Text(postedTime),
//                 ],
//               ),
//               SizedBox(height: 8.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton.icon(
//                     onPressed: onDelete,
//                     icon: Icon(Icons.delete, color: Colors.red),
//                     label: Text(
//                       'Delete',
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   ),
//                   SizedBox(width: 8.0),
//                   TextButton.icon(
//                     onPressed: onTap,
//                     icon: Icon(Icons.info, color: Colors.blue),
//                     label: Text(
//                       'View Details',
//                       style: TextStyle(color: Colors.blue),
//                     ),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:project_emergio/Widgets/shimmer%20widget.dart';
import '../../../services/check subscribe.dart';
import '../../../services/profile forms/franchise/franchise get.dart';
import '../../detail page/franchise detail page.dart';
import '../../pricing screen.dart';
import 'Franchise Form.dart';
import 'package:timeago/timeago.dart' as timeago;

class FranchiseListingsScreen extends StatefulWidget {
  const FranchiseListingsScreen({Key? key}) : super(key: key);

  @override
  _FranchiseListingsScreenState createState() =>
      _FranchiseListingsScreenState();
}

class _FranchiseListingsScreenState extends State<FranchiseListingsScreen> {
  List<Franchise>? _franchises;
  List<Franchise>? _filteredFranchises;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchFranchises();
    _searchController.addListener(_filterFranchises);
  }

  Future<void> fetchFranchises() async {
    var franchises = await FranchiseFetchPage.fetchFranchiseData();
    setState(() {
      _franchises = franchises;
      _filteredFranchises = franchises;
    });
  }

  void _filterFranchises() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredFranchises = _franchises?.where((franchise) {
        return franchise.brandName.toLowerCase().contains(query);
      }).toList();
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
        title: Text('Franchise Listings'),
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
                MaterialPageRoute(builder: (context) => FranchiseFormScreen()),
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
                  hintText: 'Search For a Franchise',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                ),
              ),
            ),
            Expanded(
              child: _filteredFranchises == null
                  ? CustomShimmerLoading(itemCount: 4)
                  : _filteredFranchises!.isEmpty
                      ? Center(child: Text('No franchise data found.'))
                      : ListView.builder(
                          itemCount: _filteredFranchises!.length,
                          itemBuilder: (context, index) {
                            var franchiseData = _filteredFranchises![index];
                            return FranchiseCard(
                              imageUrl: franchiseData.imageUrl,
                              brandName: franchiseData.brandName,
                              city: franchiseData.city,
                              postedTime: franchiseData.postedTime,
                              state: franchiseData.state,
                              industry: franchiseData.industry,
                              description: franchiseData.description,
                              url: franchiseData.url,
                              initialInvestment:
                                  franchiseData.initialInvestment,
                              projectedRoi: franchiseData.projectedRoi,
                              iamOffering: franchiseData.iamOffering,
                              currentNumberOfOutlets:
                                  franchiseData.currentNumberOfOutlets,
                              franchiseTerms: franchiseData.franchiseTerms,
                              locationsAvailable:
                                  franchiseData.locationsAvailable,
                              kindOfSupport: franchiseData.kindOfSupport,
                              allProducts: franchiseData.allProducts,
                              brandStartOperation:
                                  franchiseData.brandStartOperation,
                              spaceRequiredMin: franchiseData.spaceRequiredMin,
                              spaceRequiredMax: franchiseData.spaceRequiredMax,
                              totalInvestmentFrom:
                                  franchiseData.totalInvestmentFrom,
                              totalInvestmentTo:
                                  franchiseData.totalInvestmentTo,
                              brandFee: franchiseData.brandFee,
                              avgNoOfStaff: franchiseData.avgNoOfStaff,
                              avgMonthlySales: franchiseData.avgMonthlySales,
                              avgEBITDA: franchiseData.avgEBITDA,
                              id: franchiseData.id,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FranchiseDetailPage(
                                      id: franchiseData.id,
                                      imageUrl: franchiseData.imageUrl,
                                      brandName: franchiseData.brandName,
                                      city: franchiseData.city,
                                      postedTime: franchiseData.postedTime,
                                      state: franchiseData.state,
                                      industry: franchiseData.industry,
                                      description: franchiseData.description,
                                      url: franchiseData.url,
                                      initialInvestment:
                                          franchiseData.initialInvestment,
                                      projectedRoi: franchiseData.projectedRoi,
                                      iamOffering: franchiseData.iamOffering,
                                      currentNumberOfOutlets:
                                          franchiseData.currentNumberOfOutlets,
                                      franchiseTerms:
                                          franchiseData.franchiseTerms,
                                      locationsAvailable:
                                          franchiseData.locationsAvailable,
                                      kindOfSupport:
                                          franchiseData.kindOfSupport,
                                      allProducts: franchiseData.allProducts,
                                      brandStartOperation:
                                          franchiseData.brandStartOperation,
                                      spaceRequiredMin:
                                          franchiseData.spaceRequiredMin,
                                      spaceRequiredMax:
                                          franchiseData.spaceRequiredMax,
                                      totalInvestmentFrom:
                                          franchiseData.totalInvestmentFrom,
                                      totalInvestmentTo:
                                          franchiseData.totalInvestmentTo,
                                      brandFee: franchiseData.brandFee,
                                      avgNoOfStaff: franchiseData.avgNoOfStaff,
                                      avgMonthlySales:
                                          franchiseData.avgMonthlySales,
                                      avgEBITDA: franchiseData.avgEBITDA,
                                      showEditOption: true,
                                      image2: franchiseData.image2,
                                      image3: franchiseData.image3,
                                      image4: franchiseData.image4,
                                    ),
                                  ),
                                );
                              },
                              onDelete: () {
                                _showDeleteConfirmationDialog(
                                    context, franchiseData.id, index);
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, String franchiseId, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Franchise'),
          content: Text('Are you sure you want to delete this franchise?'),
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
                  await FranchiseFetchPage.deleteFranchise(franchiseId);
                  _removeFranchise(index);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete franchise: $e'),
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

  void _removeFranchise(int index) {
    setState(() {
      _filteredFranchises?.removeAt(index);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class FranchiseCard extends StatelessWidget {
  final String imageUrl;
  final String brandName;
  final String city;
  final String postedTime;
  final String? state;
  final String? industry;
  final String? description;
  final String? url;
  final String? initialInvestment;
  final String? projectedRoi;
  final String? iamOffering;
  final String? currentNumberOfOutlets;
  final String? franchiseTerms;
  final String? locationsAvailable;
  final String? kindOfSupport;
  final String? allProducts;
  final String? brandStartOperation;
  final String? spaceRequiredMin;
  final String? spaceRequiredMax;
  final String? totalInvestmentFrom;
  final String? totalInvestmentTo;
  final String? brandFee;
  final String? avgNoOfStaff;
  final String? avgMonthlySales;
  final String? avgEBITDA;
  final String id;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const FranchiseCard({
    required this.imageUrl,
    required this.brandName,
    required this.city,
    required this.postedTime,
    this.state,
    this.industry,
    this.description,
    this.url,
    this.initialInvestment,
    this.projectedRoi,
    this.iamOffering,
    this.currentNumberOfOutlets,
    this.franchiseTerms,
    this.locationsAvailable,
    this.kindOfSupport,
    this.allProducts,
    this.brandStartOperation,
    this.spaceRequiredMin,
    this.spaceRequiredMax,
    this.totalInvestmentFrom,
    this.totalInvestmentTo,
    this.brandFee,
    this.avgNoOfStaff,
    this.avgMonthlySales,
    this.avgEBITDA,
    required this.id,
    this.onTap,
    this.onDelete,
  });

  String formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    return timeago.format(dateTime, allowFromNow: true);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
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
                brandName,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16.0, color: Colors.red),
                  SizedBox(width: 4.0),
                  Text(locationsAvailable!),
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
                  TextButton.icon(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete, color: Colors.red),
                    label: Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
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
