import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:project_emergio/Views/chat%20screen.dart';
import 'package:project_emergio/Views/pricing%20screen.dart';
import 'package:project_emergio/Widgets/custom%20connect%20button.dart';
import 'package:project_emergio/controller/wishlist%20controller.dart';
import 'package:project_emergio/models/all%20profile%20model.dart';
import 'package:project_emergio/services/chatUserCheck.dart';
import 'package:project_emergio/services/check%20subscribe.dart';
import 'package:project_emergio/services/inbox%20service.dart';
import 'package:project_emergio/services/profile%20forms/business/business%20explore.dart';
import 'package:project_emergio/services/profile%20forms/business/business%20get.dart';
import 'package:project_emergio/services/profile%20forms/investor/investor%20get.dart';

class InvestorDetailPage extends StatefulWidget {
  late PageController _pageController;
  final BusinessInvestorExplr? investor;
  final String? imageUrl;
  final String? image2;
  final String? image3;
  final String? image4; // Optional fourth image
  final String? name;
  final String? city;
  final String? postedTime;
  final String? state;
  final String? industry;
  final String? description;
  final String? url;
  final String? rangeStarting;
  final String? rangeEnding;
  final String? evaluatingAspects;
  final String? CompanyName;
  final String? locationInterested;
  final String? id;
  final bool? showEditOption;

  InvestorDetailPage({
    this.imageUrl,
    this.image2,
    this.image3,
    this.image4,
    this.name,
    this.city,
    this.postedTime,
    this.state,
    this.industry,
    this.description,
    this.url,
    this.rangeStarting,
    this.rangeEnding,
    this.evaluatingAspects,
    this.CompanyName,
    this.locationInterested,
    this.id,
    this.showEditOption,
    this.investor,
  });

  @override
  State<InvestorDetailPage> createState() => _InvestorDetailPageState();
}

class _InvestorDetailPageState extends State<InvestorDetailPage> {
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
                    investor: widget.investor,
                    image1: widget.investor!.image2,
                    image2: widget.investor!.image3,
                    image3: widget.investor!.image4.toString()),
                _buildCompanyTitle(),
                _buildDescriptionSection(),
                _buildOverviewSection(),
                _buildFinancialsSection(),
                _buildAdditionalInfoSection(),
                SizedBox(height: 15),
                DocumentButton(text: 'Business Documents'),
                SizedBox(height: 15),
                DocumentButton(text: 'Business Proof'),
                SizedBox(height: 50),
                // SubscribeButton(
                //   investor: widget.investor,
                // ),
                subscribed
                    ? CustomConnectButton(
                  text: 'Connect',
                  onPressed: () async {
                    String receiverUserId =
                    widget.investor!.id.toString();
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.investor!.name,
            style: TextStyle(
              fontSize: 22,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.grey, size: 20),
              const SizedBox(width: 4),
              Text(
                '${widget.investor!.state}, ${widget.investor!.city}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  const Text(
                    '4.5', // Data not available
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
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
          _buildSectionTitle('Description'),
          const SizedBox(height: 8),
          Text(
            widget.investor!.description.toString(),
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
          _buildInfoRow('Industry', '${widget.investor!.industry}'),
          _buildInfoRow('Established Year',
              '${widget.investor!.establish_yr}'), // Year Missing
          _buildInfoRow('Address - 1',
              '${widget.investor!.address_1}'), // Address 1 Missing
          _buildInfoRow('Address - 2',
              '${widget.investor!.address_2}'), // Address 2 Missing
          _buildInfoRow(
              'Pin Code', '${widget.investor!.pin}'), // Pincode Missing
          _buildInfoRow('City', widget.investor!.city),
          _buildInfoRow('State', '${widget.investor!.state}'),
          _buildInfoRow('No. Of Employees',
              '${widget.investor!.employees}'), // Employee Count Missing
          _buildInfoRow('Entity Type',
              '${widget.investor!.entity}'), // Entity Type Missing
        ],
      ),
    );
  }

  Widget _buildFinancialsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Financials'),
          const SizedBox(height: 16),
          _buildInfoRow('Avg Monthly Revenue',
              '${widget.investor!.avgMonthlySales}' ?? "No Data"),
          _buildInfoRow(
              'Latest Yearly Revenue', '${widget.investor!.latest_yearly}'),
          _buildInfoRow('EBITDA', '${widget.investor!.ebitda}'),
          _buildInfoRow('Rate', '${widget.investor!.rate}'),
          _buildInfoRow('Type Of Sale', '${widget.investor!.type_sale}'),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoSection() {
    // DateTime time = DateTime.parse(widget.investor.postedTime);
    DateTime parsedDateTime = DateTime.parse(widget.investor!.postedTime);

// Format to show date and time
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDateTime);
    String formattedTime = DateFormat('HH:mm').format(parsedDateTime);

// Combine date and time
    String formattedDateTime = '$formattedDate $formattedTime';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Additional Info'),
          const SizedBox(height: 16),
          _buildInfoRow('Website', '${widget.investor!.url}'),
          _buildInfoRow('Features', '${widget.investor!.features}'), // missing
          _buildInfoRow(
              'Facilities', '${widget.investor!.facility}'), // missing
          _buildInfoRow(
              'Income Sources', '${widget.investor!.income_source}'), // missing
          _buildInfoRow(
              'Reason For Sale', '${widget.investor!.reason}'), // missing
          _buildInfoRow('Posted Time', '${formattedDateTime}'),
          _buildInfoRow(
              'Top Selling', '${widget.investor!.topSelling}'), // missing
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
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
  const ImageSliderHeader(
      {Key? key,
        required this.investor,
        required this.image1,
        required this.image2,
        required this.image3})
      : super(key: key);
  final BusinessInvestorExplr? investor;
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
    widget.image1,
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
                            token, widget.investor!.id);
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
            })),
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
  final String image1;
  final String image2;
  final String image3;
  static const String routeName = '/zoom-image';

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
      _isZoomed = !_isZoomed;
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
                      if (!_isZoomed)
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
                                        if (_currentPage != index)
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

