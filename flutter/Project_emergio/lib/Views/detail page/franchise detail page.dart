// import 'dart:math';
// import 'package:project_emergio/services/profile%20forms/franchise/franchise%20get.dart';
// import 'package:timeago/timeago.dart' as timeago;
// import 'package:draggable_home/draggable_home.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:like_button/like_button.dart';
// import 'package:project_emergio/Views/edit%20profile/franchise.dart';
// import 'package:project_emergio/Widgets/custom%20connect%20button.dart';
// import '../../controller/wishlist controller.dart';
// import '../../services/chatUserCheck.dart';
// import '../../services/check subscribe.dart';
// import '../../services/inbox service.dart';
// import '../chat screen.dart';
// import '../pricing screen.dart';
//
// class FranchiseDetailPage extends StatefulWidget {
//   final String id;
//   final String imageUrl;
//   final String image2;
//   final String image3;
//   final String? image4;
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
//   final String? brandLogo;
//   final String? businessPhotos;
//   final String? businessDocuments;
//   final String? businessProof;
//   final bool showEditOption;
//
//   const FranchiseDetailPage({
//     required this.id,
//     required this.imageUrl,
//     required this.image2,
//     required this.image3,
//     this.image4,
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
//     this.brandLogo,
//     this.businessPhotos,
//     this.businessDocuments,
//     this.businessProof,
//     required this.showEditOption,
//   });
//
//   @override
//   State<FranchiseDetailPage> createState() => _FranchiseDetailPageState();
// }
//
// class _FranchiseDetailPageState extends State<FranchiseDetailPage> {
//   late Future<List<Franchise>?> futureFranchise;
//   @override
//   void initState() {
//     super.initState();
//     futureFranchise = FranchiseFetchPage.fetchFranchiseData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final h = MediaQuery.of(context).size.height;
//
//     final WishlistController wishlistController = Get.put(WishlistController());
//
//     // Check if the item is in the wishlist when the page is built
//     _checkWishlistStatus() async {
//       // Use FlutterSecureStorage to retrieve the token
//       final storage = FlutterSecureStorage();
//       final token = await storage.read(key: 'token');
//
//       // Check if the token is not null before making the API call
//       if (token != null) {
//         await wishlistController.checkIfItemInWishlist(token, widget.id);
//       } else {
//         print('Token not found');
//       }
//     }
//
//     // Call the method to check wishlist status
//     _checkWishlistStatus();
//
//     return DraggableHome(
//       floatingActionButton: widget.showEditOption
//           ? CircleAvatar(
//         backgroundColor: Colors.green,
//         radius: h * 0.03,
//         child: IconButton(
//           icon: Icon(Icons.edit, color: Colors.white),
//           onPressed: () async {
//             final franchise = await futureFranchise;
//             final franchiseId = franchise![0].id;
//
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => FranchiseEditScreen(franchiseId: franchiseId,),
//               ),
//             );
//           },
//         ),
//       )
//           : CustomConnectButton(text: 'Connect',
//         onPressed: () async {
//
//           var subscription = await CheckSubscription.fetchSubscription();
//           String receiverUserId = widget.id.toString();
//           print('receiver userID : ${receiverUserId}');
//           // Call the roomCreation function
//           final userId = await ChatUserCheck.fetchChatUserData();
//           if (subscription['status']) {
//             if (userId != receiverUserId) {
//               var room = await Inbox.roomCreation(
//                   receiverUserId: receiverUserId);
//               print("room id is ${room}");
//               if (room['status']) {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) =>
//                     ChatScreen(roomId: room['id'].toString(),
//                         name: room['name'],
//                         chatUserId: userId,
//                         imageUrl: room['image'])));
//                 print('Room created successfully.');
//               } else {
//                 // Handle error case
//                 print('Room creation failed.');
//               }
//             }
//             else {
//               print('hiy7uhiokpo0');
//             }
//           } else {
//             // Show an alert and then navigate to the pricing screen
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Text('Subscription Status'),
//                   content: Text('You have not purchased any plans. Please visit the pricing page to choose a plan.'),
//                   actions: [
//                     TextButton(
//                       child: Text('Cancel'),
//                       onPressed: () {
//                         Navigator.of(context).pop(); // Close the alert dialog
//                       },
//                     ),
//                     TextButton(
//                       child: Text('View plans'),
//                       onPressed: () {
//                         Navigator.of(context).pop(); // Close the alert dialog
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => PricingPage()),
//                         );
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//         },
//
//       ),
//       headerWidget: headerWidget(context),
//       alwaysShowLeadingAndAction: true,
//       leading: Padding(
//         padding: const EdgeInsets.all(6.0),
//         child: CircleAvatar(
//             backgroundColor: Colors.black12,
//             child:IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),),
//       ),
//       actions: [
//         Obx(() {
//           return CircleAvatar(
//             backgroundColor: Colors.black12,
//             child: Center(
//               child: LikeButton(
//                 isLiked: wishlistController.isAddedToWishlist.value,
//                 onTap: (bool isLiked) async {
//                   // Retrieve the token from secure storage
//                   final storage = FlutterSecureStorage();
//                   final token = await storage.read(key: 'token');
//
//                   if (token != null) {
//                     // Pass the token instead of userId
//                     wishlistController.toggleWishlist(token, widget.id);
//                     return !isLiked; // Return the new liked state
//                   } else {
//                     // Handle the case where the token is not found
//                     Get.snackbar(
//                       'Error',
//                       'Token not found. Please log in again.',
//                       backgroundColor: Colors.red,
//                       colorText: Colors.white,
//                       snackPosition: SnackPosition.BOTTOM,
//                     );
//                     return isLiked; // Return the current state if token is not found
//                   }
//                 },
//                 likeBuilder: (bool isLiked) {
//                   return Icon(
//                     isLiked ? Icons.favorite : Icons.favorite_border,
//                     color: isLiked ? Colors.red : Colors.white,
//                     size: 24.0, // Adjust size if needed
//                   );
//                 },
//                 // Animation configurations
//                 animationDuration: Duration(milliseconds: 900), // Adjust duration as needed
//                 bubblesColor: BubblesColor(
//                   dotPrimaryColor: Colors.white,
//                   dotSecondaryColor: Colors.red,
//                 ),
//               ),
//             ),
//           );
//         })
//       ],
//       title: Text(widget.brandName),
//       body: [
//         detailCard(
//           widget.brandName,
//           [
//             if (widget.industry != null) detailRow('Industry:', widget.industry!),
//             if (widget.description != null) detailRow('Description:', widget.description!),
//             detailRow('Posted Time:', _formatDateTime(widget.postedTime)),
//           ],
//         ),
//         detailCard(
//           'Location',
//           [
//             detailRow('Locations available:', widget.locationsAvailable!),
//             if (widget.state != null) detailRow('State:', widget.state!),
//           ],
//         ),
//         detailCard(
//           'Franchise Details',
//           [
//             if (widget.initialInvestment != null)
//               detailRow('Initial Investment:', widget.initialInvestment!),
//             if (widget.projectedRoi != null)
//               detailRow('Projected ROI:', widget.projectedRoi!),
//             if (widget.iamOffering != null) detailRow('Offerings:', widget.iamOffering!),
//             if (widget.currentNumberOfOutlets != null)
//               detailRow('Current Number of Outlets:', widget.currentNumberOfOutlets!),
//             if (widget.franchiseTerms != null)
//               detailRow('Franchise Terms:', widget.franchiseTerms!),
//             if (widget.locationsAvailable != null)
//               detailRow('Locations Available:', widget.locationsAvailable!),
//             if (widget.kindOfSupport != null)
//               detailRow('Support Provided:', widget.kindOfSupport!),
//             if (widget.allProducts != null)
//               detailRow('Products Offered:', widget.allProducts!),
//             if (widget.brandStartOperation != null)
//               detailRow('Brand Start Operation:', widget.brandStartOperation!),
//             if (widget.spaceRequiredMin != null && widget.spaceRequiredMax != null)
//               detailRow('Space Required:',
//                   '${widget.spaceRequiredMin} - ${widget.spaceRequiredMax} sq ft'),
//             if (widget.totalInvestmentFrom != null && widget.totalInvestmentTo != null)
//               detailRow('Total Investment:',
//                   '${widget.totalInvestmentFrom} - ${widget.totalInvestmentTo}'),
//             if (widget.brandFee != null) detailRow('Brand Fee:', widget.brandFee!),
//             if (widget.avgNoOfStaff != null)
//               detailRow('Average Number of Staff:', widget.avgNoOfStaff!),
//             if (widget.avgMonthlySales != null)
//               detailRow('Average Monthly Sales:', widget.avgMonthlySales!),
//             if (widget.avgEBITDA != null) detailRow('Average EBITDA:', widget.avgEBITDA!),
//           ],
//         ),
//         detailCard(
//           'Contact Information',
//           [
//             if (widget.url != null) detailRow('Website:', widget.url!),
//             SizedBox(height: 40.0),
//
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget headerWidget(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _showImageDialog(context, 0);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: NetworkImage(widget.imageUrl),
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget detailCard(String title, List<Widget> rows) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title,
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8.0),
//             ...rows,
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget detailRow(String title, String content) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           SizedBox(width: 8.0),
//           Expanded(child: Text(content)),
//         ],
//       ),
//     );
//   }
//
//   void _showImageDialog(BuildContext context, int initialIndex) {
//     final PageController pageController =
//     PageController(initialPage: initialIndex);
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           insetPadding: EdgeInsets.all(0),
//           child: Stack(
//             children: [
//               PageView.builder(
//                 controller: pageController,
//                 itemCount: 1, // Only one image for now
//                 itemBuilder: (context, index) {
//                   return Container(
//                     width: w,
//                     height: h,
//                     decoration: BoxDecoration(
//                       color: Colors.black26,
//                       image: DecorationImage(
//                         image: NetworkImage(widget.imageUrl),
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               Positioned(
//                 top: 16,
//                 left: 16,
//                 child: IconButton(
//                   icon: Icon(Icons.arrow_back, color: Colors.white),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//               Positioned(
//                 bottom: 16,
//                 left: 0,
//                 right: 0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(1, (index) {
//                     return AnimatedBuilder(
//                       animation: pageController,
//                       builder: (context, child) {
//                         double selectedness = Curves.easeOut.transform(
//                           max(
//                               0.0,
//                               1.0 -
//                                   ((pageController.page ??
//                                       pageController.initialPage) -
//                                       index)
//                                       .abs()),
//                         );
//                         double zoom = 1.0 + (selectedness * 0.3);
//                         return Container(
//                           margin: EdgeInsets.symmetric(horizontal: 4),
//                           height: 8,
//                           width: 8,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withOpacity(selectedness),
//                           ),
//                           child: Transform.scale(
//                             scale: zoom,
//                             child: child,
//                           ),
//                         );
//                       },
//                       child: Container(
//                         height: 8,
//                         width: 8,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.white,
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//   String _formatDateTime(String dateTimeStr) {
//     DateTime dateTime = DateTime.parse(dateTimeStr);
//     return timeago.format(dateTime, allowFromNow: true);
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:project_emergio/Views/chat%20screen.dart';
import 'package:project_emergio/Views/pricing%20screen.dart';
import 'package:project_emergio/Widgets/custom%20connect%20button.dart';
import 'package:project_emergio/controller/wishlist%20controller.dart';
import 'package:project_emergio/models/all%20profile%20model.dart';

import '../../services/chatUserCheck.dart';
import '../../services/check subscribe.dart';
import '../../services/inbox service.dart';

class FranchiseDetailPage extends StatefulWidget {
  @override
  State<FranchiseDetailPage> createState() => _FranchiseDetailPageState();
  final FranchiseExplr? franchise;
  final String? id;
  final String? imageUrl;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? brandName;
  final String? city;
  final String? postedTime;
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
  final String? brandLogo;
  final String? businessPhotos;
  final String? businessDocuments;
  final String? businessProof;
  final bool showEditOption;

  const FranchiseDetailPage({
    this.franchise,
    this.id,
    this.imageUrl,
    this.image2,
    this.image3,
    this.image4,
    this.brandName,
    this.city,
    this.postedTime,
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
    this.brandLogo,
    this.businessPhotos,
    this.businessDocuments,
    this.businessProof,
    required this.showEditOption,
  });
}

class _FranchiseDetailPageState extends State<FranchiseDetailPage> {
  var subscription;
  bool subscribed = false;
  void initState() {
    super.initState();

    _checkSubscription();
  }

  void _checkSubscription() async {
    try {
      subscription = await CheckSubscription.fetchSubscription();
      setState(() {
        subscribed = subscription['status'];
      });
      print(subscribed);
    } catch (e) {
      print("Error fetching subscription: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _buildHeader(),
                ImageSliderHeader(
                  franchise: widget.franchise!,
                  image1: widget.franchise!.image2 != null
                      ? widget.franchise!.image2
                      : "No Data",
                  image2: widget.franchise!.image3 != null
                      ? widget.franchise!.image3
                      : "No Data",
                  image3: widget.franchise!.image4 != null
                      ? widget.franchise!.image3
                      : "No Data",
                ),
                _buildCompanyTitle(),
                _buildDescriptionSection(),
                _buildOverviewSection(),
                _buildSpaceSection(),
                _buildInvestmentRangSection(),
                _buildAdditionalInfoSection(),
                SizedBox(height: 15),
                DocumentButton(text: 'Business Documents'),
                SizedBox(height: 15),
                DocumentButton(text: 'Business Proof'),
                SizedBox(height: 40),
                // SubscribeButton(),
                subscribed
                    ? CustomConnectButton(
                  buttonHeight: 45,
                  buttonWidth: 200,
                  buttonColor: Colors.yellow[600],
                  text: 'Connect',
                  onPressed: () async {
                    String receiverUserId =
                    widget.franchise!.id.toString();
                    final userId =
                    await ChatUserCheck.fetchChatUserData();
                    var room = await Inbox.roomCreation(
                        receiverUserId: receiverUserId);
                    if (room['status']) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            roomId: room['id'].toString(),
                            name: room['name'],
                            chatUserId: userId,
                            imageUrl: room['image'],
                            number: '',
                          ),
                        ),
                      );
                    } else {
                      print('Room creation failed.');
                    }
                  },
                )
                    : Align(
                  alignment: Alignment.center,
                  child: CustomConnectButton(
                      buttonHeight: 45,
                      buttonWidth: 200,
                      buttonColor: Colors.yellow[600],
                      text: "Subscribe",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Subscription Status'),
                              content: Text(
                                  'You have not purchased any plans. Please visit the pricing page to choose a plan.'),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('View plans'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PricingPage()),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }),
                ),
                SizedBox(height: 10),
                //  _buildBuisinessDocuments(),
                // _buildBuisinessProof(),
                // _buildSubscribeButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            child: Image.asset(
              '',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite, color: Colors.white),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyTitle() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Profile Image Row
              Text(
                widget.franchise!.brandName.toString(),
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xff4C4C4C),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.grey, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.franchise!.state ?? "No Data"}, ${widget.franchise!.city ?? "No Data"}',
                    style: TextStyle(
                      color: Color(0xff4C4C4C),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '4.5', // pending
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Location and Rating Row
            ],
          ),
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(// No field
                "https://images.pexels.com/photos/29094491/pexels-photo-29094491/free-photo-of-modern-glass-skyscraper-against-blue-sky.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('About'),
          const SizedBox(height: 8),
          Text(
            " ${widget.franchise!.description ?? "No data"}",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Overview'),
          const SizedBox(height: 16),
          _buildInfoRow(
            'Industry',
            "${widget.franchise!.industry ?? "No Data"}",
          ),
          _buildInfoRow('Established Year',
              "  ${widget.franchise!.established_year ?? "No Data"}"),
          _buildInfoRow(
              'Offering', '${widget.franchise!.iamOffering ?? "No Data"}'),
          _buildInfoRow('Initial Investment',
              '${widget.franchise!.initialInvestment ?? "No Data"}'),
          _buildInfoRow('Projected ROI',
              '${widget.franchise!.projectedRoi ?? "No Data"}'),
          _buildInfoRow(
              'Location Available', '${widget.franchise!.city ?? "No Data"}'),
          _buildInfoRow('State', '${widget.franchise!.state ?? "No Data"}'),
          _buildInfoRow('Current No. of Outlet',
              '${widget.franchise!.currentNumberOfOutlets ?? "No Data"}'),
          _buildInfoRow('Franchise Terms',
              '${widget.franchise!.franchiseTerms ?? "No Data"}'),
        ],
      ),
    );
  }

  Widget _buildSpaceSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Space Required'),
          const SizedBox(height: 16),
          _buildInfoRow(
              'Min', '${widget.franchise!.spaceRequiredMin ?? "No Data"}'),
          _buildInfoRow(
              'Max', '${widget.franchise!.spaceRequiredMax ?? "No Data"}'),
        ],
      ),
    );
  }

  Widget _buildInvestmentRangSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Investment Rang'),
          const SizedBox(height: 16),
          _buildInfoRow(
              'From', '${widget.franchise!.totalInvestmentFrom ?? "No Data"}'),
          _buildInfoRow(
              'To', '${widget.franchise!.totalInvestmentTo ?? "No Data"}'),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Additional Info'),
          const SizedBox(height: 16),
          _buildInfoRow(
              'Brand Fee', '${widget.franchise!.brandFee ?? "No Data"}'),
          _buildInfoRow('Avg Staff Required',
              '${widget.franchise!.avgNoOfStaff ?? "No Data"}'),
          _buildInfoRow('Avg Monthly Sales',
              '${widget.franchise!.avgMonthlySales ?? "No Data"}'),
          _buildInfoRow(
              'Avg EBITDA', '${widget.franchise!.avgEBITDA ?? "No Data"}'),
          // _buildInfoRow('Brand Operation',
          //     '${widget.franchise!.brandStartOperation ?? "No Data"},'),

          _buildInfoRow(
              'Product', '${widget.franchise!.allProducts ?? "No Data"}'),

        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xff4C4C4C),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
          ),
          const Text(
            ': ',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Top container for displaying images
class ImageSliderHeader extends StatefulWidget {
  const ImageSliderHeader({
    Key? key,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.franchise,
  }) : super(key: key);
  final FranchiseExplr franchise;
  final String image1;
  final String image2;
  final String image3;
  @override
  State<ImageSliderHeader> createState() => _ImageSliderHeaderState();
}

class _ImageSliderHeaderState extends State<ImageSliderHeader> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late List<String> _images = [
    widget.image1 ??
        'https://images.pexels.com/photos/29094491/pexels-photo-29094491/free-photo-of-modern-glass-skyscraper-against-blue-sky.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    widget.image2 ??
        'https://images.pexels.com/photos/29104613/pexels-photo-29104613/free-photo-of-cityscape-with-train-and-skyscrapers-in-melbourne.jpeg?auto=compress&cs=tinysrgb&w=600',
    widget.image3 ??
        'https://images.pexels.com/photos/29049243/pexels-photo-29049243/free-photo-of-modern-curved-skyscraper-in-urban-setting.jpeg?auto=compress&cs=tinysrgb&w=600',
  ];

  final WishlistController wishlistController = Get.put(WishlistController());

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ZoomImagePage(
                      image1: widget.image1,
                      image2: widget.image2,
                      image3: widget.image3,
                    )));
          },
          child: SizedBox(
            height: 320,
            child: Column(
              children: [
                Container(
                  height: 270,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(16),
                      top: Radius.circular(16),
                    ),
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          _images[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        Positioned(
            top: 16,
            right: 16,
            child: Obx(() {
              return CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2),
                child: Center(
                  child: LikeButton(
                    isLiked: wishlistController.isAddedToWishlist.value,
                    onTap: (bool isLiked) async {
                      final storage = FlutterSecureStorage();
                      final token = await storage.read(key: 'token');

                      if (token != null) {
                        wishlistController.toggleWishlist(
                            token, widget.franchise!.id);
                        return !isLiked;
                      } else {
                        Get.snackbar(
                          'Error',
                          'Token not found. Please log in again.',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return isLiked;
                      }
                    },
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.white,
                        size: 24.0,
                      );
                    },
                    animationDuration: Duration(milliseconds: 900),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Colors.white,
                      dotSecondaryColor: Colors.red,
                    ),
                  ),
                ),
              );
            })
          // Container(
          //   padding: const EdgeInsets.all(8),
          //   decoration: BoxDecoration(
          //     color: Colors.white.withOpacity(0.2),
          //     shape: BoxShape.circle,
          //   ),
          //   child: const Icon(Icons.favorite, color: Colors.white),
          // ),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _images.length,
                  (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Colors.amber
                      : Colors.amber.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// page for zoomIn property
class ZoomImagePage extends StatefulWidget {
  const ZoomImagePage({
    Key? key,
    required this.image1,
    required this.image2,
    required this.image3,
  }) : super(key: key);

  static const String routeName = '/zoom-image';
  final String image1;
  final String image2;
  final String image3;

  @override
  State<ZoomImagePage> createState() => _ZoomImagePageState();
}

class _ZoomImagePageState extends State<ZoomImagePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isZoomed = false;

  late List<String> _images = [
    widget.image1 ??
        'https://images.pexels.com/photos/29094491/pexels-photo-29094491/free-photo-of-modern-glass-skyscraper-against-blue-sky.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    widget.image2 ??
        'https://images.pexels.com/photos/29104613/pexels-photo-29104613/free-photo-of-cityscape-with-train-and-skyscrapers-in-melbourne.jpeg?auto=compress&cs=tinysrgb&w=600',
    widget.image3 ??
        'https://images.pexels.com/photos/29049243/pexels-photo-29049243/free-photo-of-modern-curved-skyscraper-in-urban-setting.jpeg?auto=compress&cs=tinysrgb&w=600',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleImageTap() {
    setState(() {
      _isZoomed = _isZoomed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                if (_isZoomed)
                  Expanded(
                    child: Container(
                      color: Colors.black,
                      child: PhotoViewGallery.builder(
                        pageController: _pageController,
                        itemCount: _images.length,
                        builder: (context, index) {
                          return PhotoViewGalleryPageOptions(
                            imageProvider: NetworkImage(_images[index]),
                            minScale: PhotoViewComputedScale.contained,
                            maxScale: PhotoViewComputedScale.covered * 2,
                          );
                        },
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        backgroundDecoration:
                        const BoxDecoration(color: Colors.black),
                      ),
                    ),
                  )
                else
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                          child: GestureDetector(
                            onTap: _handleImageTap,
                            child: PageView.builder(
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                              itemCount: _images.length,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  _images[index],
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Image indicators
                      if (_isZoomed)
                        Container(
                          height: 120,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _images.length,
                                  (index) => GestureDetector(
                                onTap: () {
                                  _pageController.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    height: 120,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: _currentPage == index
                                            ? Colors.white
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          child: Image.network(
                                            _images[index],
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                          ),
                                        ),
                                        if (_currentPage == index)
                                          Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(20),
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
            // Back button
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (_isZoomed) {
                      setState(() {
                        _isZoomed = false;
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Favorite button
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: () {
                    // Add favorite functionality here
                  },
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DocumentButton extends StatelessWidget {
  final String text;

  const DocumentButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.80,
        height: 55,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xffF3D55E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.insert_drive_file, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Icon(Icons.download, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class SubscribeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.45,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.yellow[600],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Subscribe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            ),
        );
    }
}
