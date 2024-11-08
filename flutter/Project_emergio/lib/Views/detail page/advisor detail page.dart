import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:project_emergio/controller/wishlist%20controller.dart';
import 'package:project_emergio/models/all%20profile%20model.dart';

import '../../Widgets/custom connect button.dart';
import '../../services/chatUserCheck.dart';
import '../../services/check subscribe.dart';
import '../../services/inbox service.dart';
import '../../services/testimonial/testimonial get.dart';
import '../chat screen.dart';
import '../pricing screen.dart';

class AdvisorDetailPage extends StatefulWidget {
  // final String imageUrl;
  // final String name;
  // final String? designation;
  // final String location;
  // final String? url;
  // final String? contactNumber;
  // final String? state;
  // final String? interest;
  // final String? description;
  // final String userId;
  final AdvisorExplr? advisor;

  const AdvisorDetailPage({
    Key? key,
    // required this.imageUrl,
    // required this.name,
    // this.designation,
    // required this.location,
    // this.url,
    // this.contactNumber,
    // this.state,
    // this.interest,
    // this.description,
    // required this.userId,
    this.advisor,
  }) : super(key: key);

  @override
  State<AdvisorDetailPage> createState() => _AdvisorDetailPageState();
}

class _AdvisorDetailPageState extends State<AdvisorDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoadingTestimonials = false;
  List<Map<String, dynamic>> _testimonials = [];
  var subscription;
  bool subscribed = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchTestimonials();
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

  Future<void> _fetchTestimonials() async {
    setState(() {
      _isLoadingTestimonials = true;
    });
    print(widget.advisor!.id);
    final testimonials =
    await TestimonialGet.fetchTestimonials(userId: widget.advisor!.id);
    _testimonials = testimonials!;

    setState(() {
      _isLoadingTestimonials = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WishlistController wishlistController = Get.put(WishlistController());
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SizedBox(height: h * 0.03),
            Stack(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    image: DecorationImage(
                      image: NetworkImage(
                          widget.advisor!.imageUrl.isNotEmpty
                              ? widget.advisor!.imageUrl
                              :
                          'https://via.placeholder.com/150'
                        // widget.imageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // child:
                ),
                // Back button and favorite icon
                Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white.withOpacity(0.2),
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
                                    token,
                                    widget.advisor!.id != null
                                        ? widget.advisor!.id
                                        : "1");
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
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
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
                    }),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image
                  // Container(
                  //   width: 120,
                  //   height: 120,

                  // ),

                  // Name and Title
                  Text(
                    widget. advisor!.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.advisor!.designation.toString() ,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),

                      // Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '4.8',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // CircleAvatar(
            //   radius: h * .08,
            //   backgroundImage: NetworkImage(
            // widget.imageUrl.isNotEmpty
            //     ? widget.imageUrl
            //     : 'https://via.placeholder.com/150',
            // ),
            // ),
            // SizedBox(height: h * .02),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       widget.name,
            //       style: TextStyle(
            //         fontSize: 20.0,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     Text(
            //       widget.designation ?? 'Designation not available',
            //       style: TextStyle(
            //         fontSize: 16.0,
            //         color: Colors.grey,
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: h * 0.015),
            TabBar(
              controller: _tabController,
              indicatorWeight: 7,
              unselectedLabelStyle: TextStyle(
                  color: Colors.black87.withOpacity(0.4),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              labelStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              tabs: [
                Tab(
                  text: 'Personal Info',
                ),
                Tab(text: 'Testimonials'),
              ],
              indicatorColor: Colors.yellow,
              indicatorSize: TabBarIndicatorSize.label,
            ),
            SizedBox(height: h * 0.02),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                      child: subscribed == true
                          ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffFEF9E4),
                                  borderRadius:
                                  BorderRadius.circular(15)),
                              height: 300.h,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 15,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "About Me",
                                      style: TextStyle(
                                          color: Colors.black
                                              .withOpacity(0.3),
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.advisor!.interest.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black
                                              .withOpacity(1)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffFEF9E4),
                                  borderRadius:
                                  BorderRadius.circular(15)),
                              height: 250.h,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 5),
                                    child: Text(
                                      'Contact Info',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color:
                                        Colors.black.withOpacity(0.4),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 5),
                                    child: Text(
                                      'Website: ${widget.advisor!.url ?? 'No URL available.'}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 5),
                                    child: Text(
                                      'Phone: ${widget.advisor!.contactNumber ?? 'No contact number available.'}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 5),
                                    child: Text(
                                      'State: ${widget.advisor!.state ?? 'No state available.'}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 5),
                                    child: Text(
                                      'City: ${widget.advisor!.location}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 5),
                                    child: Text(
                                      'Area of interest: ${widget.advisor!.interest ?? 'No interest available.'}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: h * 10),
                            Container(
                              height: h * 0.25,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, top: 10),
                                child: Text(
                                  'Description: ${widget.advisor!.description ?? 'No description available.'}',
                                  style: TextStyle(
                                    fontSize: h * 0.015,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: h * 10),
                          ],
                        ),
                      )
                          : Center(
                        child: Container(
                            width: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withOpacity(0.7),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    "assets/Component 3.svg"),
                                // flutter_svg: ^2.0.5
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Upgrade to Premium to See Details",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffD9D9D9),
                                  ),
                                ),
                              ],
                            )),
                      )),
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
                      ? Center(
                      child: Text(
                        'No testimonials available.',
                        style:
                        TextStyle(color: Colors.black, fontSize: 14),
                      ))
                      : ListView.builder(
                    itemCount: _testimonials.length,
                    itemBuilder: (context, index) {
                      var testimonial = _testimonials[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 4.0, right: 4, bottom: 4),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12.0),
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          title: Text(
                            testimonial['company'] ??
                                'Company name not available',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              testimonial['testimonial'] ??
                                  'No testimonial available.',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: Colors.grey[300]!, width: 1),
                          ),
                          tileColor: Colors.white,
                          trailing: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.format_quote,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            subscribed
                ? CustomConnectButton(
              buttonHeight: 45,
              buttonWidth: 200,
              textColor: Colors.white,
              buttonColor: Colors.yellow[600],
              text: 'Connect',
              onPressed: () async {
                String receiverUserId = widget.advisor!.id.toString();
                print('receiver userID : ${receiverUserId}');
                // Call the roomCreation function
                final userId = await ChatUserCheck.fetchChatUserData();
                // if (userId != receiverUserId) {
                var room = await Inbox.roomCreation(
                    receiverUserId: receiverUserId);
                print("room id is ${room}");
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
                          )));
                  print('Room created successfully.');
                } else {
                  // Handle error case
                  print('Room creation failed.');
                }
                // }
                // else {
                //   print('hiy7uhiokpo0');
                // }
              },
            )
                : Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.center,
                child: CustomConnectButton(
                    buttonHeight: 45,
                    buttonWidth: 150,
                    textColor: Colors.white,
                    buttonColor: Colors.yellow[600],
                    text: 'Subscribe',
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
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void _contactAdvisor(String? contactNumber) {
    if (contactNumber != null && contactNumber.isNotEmpty) {
      // Logic to contact the advisor via phone, SMS, or any other method
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No contact number available.')),
      );
    }
    }
}
