// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project_emergio/services/wishlist.dart';
// import 'Views/detail page/business deatil page.dart';
// import 'Views/detail page/franchise detail page.dart';
// import 'Views/detail page/invester detail page.dart';
// import 'controller/wishlist controller.dart';
// import 'models/all profile model.dart';
//
// class WishlistScreen extends StatefulWidget {
//   const WishlistScreen({super.key});
//
//   @override
//   State<WishlistScreen> createState() => _WishlistScreenState();
// }
//
// class _WishlistScreenState extends State<WishlistScreen> {
//   final WishlistController wishlistController = Get.put(WishlistController());
//   List<ProductDetails> businessItems = [];
//   List<ProductDetails> franchiseItems = [];
//   List<ProductDetails> investorItems = [];
//   bool isLoading = true;
//   String? error;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadWishlistData();
//   }
//
//   Future<void> _loadWishlistData() async {
//     try {
//       await wishlistController.fetchWishlistItems();
//       await fetchWishlistItems();
//     } catch (e) {
//       setState(() {
//         error = 'An error occurred while loading wishlist data';
//         isLoading = false;
//       });
//     }
//   }
//
//   Future<void> fetchWishlistItems() async {
//     try {
//       final result = await WishList.fetchWishlistData();
//       if (result != null) {
//         final List<ProductDetails> allItems =
//             List<ProductDetails>.from(result["wishlist"]);
//
//         setState(() {
//           businessItems = allItems
//               .where((item) => item.type.toLowerCase() == 'business')
//               .toList();
//           franchiseItems = allItems
//               .where((item) => item.type.toLowerCase() == 'franchise')
//               .toList();
//           investorItems = allItems
//               .where((item) => item.type.toLowerCase() == 'investor')
//               .toList();
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           error = 'Failed to fetch wishlist items';
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         error = 'An error occurred while fetching wishlist items';
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : error != null
//                 ? Center(child: Text(error!))
//                 : Obx(() => wishlistController.isLoading.value
//                     ? const Center(child: CircularProgressIndicator())
//                     : SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               _buildHeader(),
//                               const SizedBox(height: 20),
//                               _buildCollectionTitle(),
//                               const SizedBox(height: 20),
//                               if (businessItems.isNotEmpty) ...[
//                                 _buildBusinessSection(),
//                                 const SizedBox(height: 20),
//                               ],
//                               if (franchiseItems.isNotEmpty) ...[
//                                 _buildFranchiseSection(),
//                                 const SizedBox(height: 20),
//                               ],
//                               if (investorItems.isNotEmpty)
//                                 _buildInvestorSection(),
//                             ],
//                           ),
//                         ),
//                       )),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.arrow_back, color: Colors.black),
//           ),
//         ),
//         const Text(
//           'Wishlist',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Stack(
//           children: [
//             const Icon(Icons.notifications_outlined),
//             Positioned(
//               right: 0,
//               top: 0,
//               child: Container(
//                 padding: const EdgeInsets.all(4),
//                 decoration: const BoxDecoration(
//                   color: Colors.amber,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Text(
//                   '${businessItems.length + franchiseItems.length + investorItems.length}',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 10,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCollectionTitle() {
//     final totalItems =
//         businessItems.length + franchiseItems.length + investorItems.length;
//     return Row(
//       children: [
//         const Text(
//           'My Collections',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           '( $totalItems )',
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildBusinessSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             color: const Color(0xff6B89B7),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               const Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.white,
//                     child: Icon(Icons.business, color: Color(0xff6B89B7)),
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     'Business',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               Text(
//                 '( ${businessItems.length} )',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 16),
//         _buildItemGrid(businessItems, 'business'),
//       ],
//     );
//   }
//
//   Widget _buildFranchiseSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             color: const Color(0xffF3D55E),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               const Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.white,
//                     child: Icon(Icons.store, color: Color(0xffF3D55E)),
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     'Franchise',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               Text(
//                 '( ${franchiseItems.length} )',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 16),
//         _buildItemGrid(franchiseItems, 'franchise'),
//       ],
//     );
//   }
//
//   Widget _buildInvestorSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             color: const Color(0xffBDD0E7),
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               const Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.white,
//                     child: Icon(Icons.store, color: Color(0xffBDD0E7)),
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     'Investor',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               Text(
//                 '( ${investorItems.length} )',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 16),
//         _buildItemGrid(investorItems, 'investor'),
//       ],
//     );
//   }
//
//   Widget _buildItemGrid(List<ProductDetails> items, String type) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 2,
//         mainAxisSpacing: 8,
//         childAspectRatio: 0.8,
//       ),
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         final item = items[index];
//         return GestureDetector(
//           onTap: () {
//             if (type == 'business') {
//               final businessItem = wishlistController.wishlistAllItems
//                   .firstWhereOrNull((element) => element.id == item.id);
//
//               if (businessItem != null) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BusinessDetailPage(
//                       imageUrl: businessItem.imageUrl,
//                       image2: businessItem.image2 ?? '',
//                       image3: businessItem.image3 ?? '',
//                       image4: businessItem.image4 ?? '',
//                       name: businessItem.name,
//                       industry: businessItem.industry ?? '',
//                       establish_yr: businessItem.establish_yr ?? '',
//                       description: businessItem.description ?? '',
//                       address_1: businessItem.address_1 ?? '',
//                       address_2: businessItem.address_2 ?? '',
//                       pin: businessItem.pin ?? '',
//                       city: businessItem.city,
//                       state: businessItem.state ?? '',
//                       employees: businessItem.employees ?? '',
//                       entity: businessItem.entity ?? '',
//                       avg_monthly: businessItem.avg_monthly ?? '',
//                       latest_yearly: businessItem.latest_yearly ?? '',
//                       ebitda: businessItem.ebitda ?? '',
//                       rate: businessItem.rate ?? '',
//                       type_sale: businessItem.type_sale ?? '',
//                       url: businessItem.url ?? '',
//                       features: businessItem.features ?? '',
//                       facility: businessItem.facility ?? '',
//                       income_source: businessItem.income_source ?? '',
//                       reason: businessItem.reason ?? '',
//                       postedTime: businessItem.postedTime,
//                       topSelling: businessItem.topSelling ?? '',
//                       id: businessItem.id,
//                       showEditOption: false,
//                     ),
//                   ),
//                 );
//               }
//             } else if (type == 'franchise') {
//               final franchiseItem = wishlistController.wishlistFranchiseItems
//                   .firstWhereOrNull((element) => element.id == item.id);
//
//               if (franchiseItem != null) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => FranchiseDetailPage(
//                       id: franchiseItem.id,
//                       imageUrl: franchiseItem.imageUrl,
//                       image2: franchiseItem.image2 ?? '',
//                       image3: franchiseItem.image3 ?? '',
//                       image4: franchiseItem.image4 ?? '',
//                       brandName: franchiseItem.brandName ?? '',
//                       city: franchiseItem.city,
//                       postedTime: franchiseItem.postedTime,
//                       state: franchiseItem.state ?? '',
//                       industry: franchiseItem.industry ?? '',
//                       description: franchiseItem.description ?? '',
//                       url: franchiseItem.url ?? '',
//                       initialInvestment: franchiseItem.initialInvestment ?? '',
//                       projectedRoi: franchiseItem.projectedRoi ?? '',
//                       iamOffering: franchiseItem.iamOffering ?? '',
//                       currentNumberOfOutlets:
//                           franchiseItem.currentNumberOfOutlets ?? '',
//                       franchiseTerms: franchiseItem.franchiseTerms ?? '',
//                       locationsAvailable:
//                           franchiseItem.locationsAvailable ?? '',
//                       kindOfSupport: franchiseItem.kindOfSupport ?? '',
//                       allProducts: franchiseItem.allProducts ?? '',
//                       brandStartOperation:
//                           franchiseItem.brandStartOperation ?? '',
//                       spaceRequiredMin: franchiseItem.spaceRequiredMin ?? '',
//                       spaceRequiredMax: franchiseItem.spaceRequiredMax ?? '',
//                       totalInvestmentFrom:
//                           franchiseItem.totalInvestmentFrom ?? '',
//                       totalInvestmentTo: franchiseItem.totalInvestmentTo ?? '',
//                       brandFee: franchiseItem.brandFee ?? '',
//                       avgNoOfStaff: franchiseItem.avgNoOfStaff ?? '',
//                       avgMonthlySales: franchiseItem.avgMonthlySales ?? '',
//                       avgEBITDA: franchiseItem.avgEBITDA ?? '',
//                       showEditOption: false,
//                     ),
//                   ),
//                 );
//               }
//             } else if (type == 'investor') {
//               final investorItem = wishlistController.wishlistAllItems
//                   .firstWhereOrNull((element) => element.id == item.id);
//
//               if (investorItem != null) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => InvestorDetailPage(
//                       imageUrl: investorItem.imageUrl,
//                       name: investorItem.name,
//                       city: investorItem.city,
//                       postedTime: investorItem.postedTime,
//                       state: investorItem.state ?? '',
//                       industry: investorItem.industry ?? '',
//                       description: investorItem.description ?? '',
//                       url: investorItem.url ?? '',
//                       rangeStarting: investorItem.rangeStarting ?? '',
//                       rangeEnding: investorItem.rangeEnding ?? '',
//                       evaluatingAspects: investorItem.evaluatingAspects ?? '',
//                       CompanyName: investorItem.companyName ?? '',
//                       locationInterested: investorItem.locationIntrested ?? '',
//                       id: investorItem.id,
//                       showEditOption: false,
//                       image2: investorItem.image2 ?? '',
//                       image3: investorItem.image3 ?? '',
//                       image4: investorItem.image4 ?? '',
//                     ),
//                   ),
//                 );
//               }
//             }
//             wishlistController
//                 .fetchWishlistItems(); // Refresh the wishlist after navigation
//           },
//           child: Card(
//             elevation: 2,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     image: DecorationImage(
//                       image: NetworkImage(item.imageUrl),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           padding: const EdgeInsets.all(4),
//                           child: Text(
//                             item.name,
//                             style: const TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           padding: const EdgeInsets.symmetric(horizontal: 2),
//                           child: Row(
//                             children: [
//                               const Icon(
//                                 Icons.location_on,
//                                 size: 16,
//                                 color: Colors.amber,
//                               ),
//                               const SizedBox(width: 4),
//                               Text(
//                                 item.city,
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

