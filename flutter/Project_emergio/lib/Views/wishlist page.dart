// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:timeago/timeago.dart' as timeago;
// import '../Widgets/AppBar_widget.dart';
// import '../Widgets/drawer.dart';
// import '../Widgets/wishlist shimmer.dart';
// import '../controller/wishlist controller.dart';
// import 'detail page/business deatil page.dart';
// import 'detail page/franchise detail page.dart';
// import 'detail page/invester detail page.dart';
//
// class WishListScreen extends StatefulWidget {
//   @override
//   _WishListScreenState createState() => _WishListScreenState();
// }
//
// class _WishListScreenState extends State<WishListScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final WishlistController wishlistController = Get.put(WishlistController());
//
//   @override
//   void initState() {
//     super.initState();
//     wishlistController.fetchWishlistItems();
//   }
//
//   String formatDateTime(String dateTimeStr) {
//     DateTime dateTime = DateTime.parse(dateTimeStr);
//     return timeago.format(dateTime, allowFromNow: true);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
//       // endDrawer: CustomDrawerWidget(),
//       body: Obx(
//         () => wishlistController.isLoading.value
//             ? WishlistShimmerWidget(width: 150, height: 150)
//             : wishlistController.wishlistItems.isEmpty
//                 ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Your Wishlist is Empty',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w600, fontSize: 16)),
//                         SizedBox(height: 8),
//                         Text(
//                             'It seems like you havent added any\nitems to your wishlist',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w500, fontSize: 14),
//                             textAlign: TextAlign.center),
//                       ],
//                     ),
//                   )
//                 : ListView(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           'Wishlist Items',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: h * 0.025),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: GridView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: wishlistController.wishlistItems.length,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             childAspectRatio: 2 / 3,
//                             mainAxisSpacing: 8.0,
//                             crossAxisSpacing: 8.0,
//                           ),
//                           itemBuilder: (context, index) {
//                             var item = wishlistController.wishlistItems[index];
//                             return GestureDetector(
//                               onTap: () {
//                                 if (item.type == 'business') {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => BusinessDetailPage(
//                                         imageUrl: wishlistController
//                                             .wishlistAllItems[index].imageUrl,
//                                         image2: wishlistController
//                                             .wishlistAllItems[index].image2,
//                                         image3: wishlistController
//                                             .wishlistAllItems[index].image3,
//                                         image4: wishlistController
//                                             .wishlistAllItems[index].image4,
//                                         name: wishlistController
//                                             .wishlistAllItems[index].name,
//                                         industry: wishlistController
//                                             .wishlistAllItems[index].industry,
//                                         establish_yr: wishlistController
//                                             .wishlistAllItems[index]
//                                             .establish_yr,
//                                         description: wishlistController
//                                             .wishlistAllItems[index]
//                                             .description,
//                                         address_1: wishlistController
//                                             .wishlistAllItems[index].address_1,
//                                         address_2: wishlistController
//                                             .wishlistAllItems[index].address_2,
//                                         pin: wishlistController
//                                             .wishlistAllItems[index].pin,
//                                         city: wishlistController
//                                             .wishlistAllItems[index].city,
//                                         state: wishlistController
//                                             .wishlistAllItems[index].state,
//                                         employees: wishlistController
//                                             .wishlistAllItems[index].employees,
//                                         entity: wishlistController
//                                             .wishlistAllItems[index].entity,
//                                         avg_monthly: wishlistController
//                                             .wishlistAllItems[index]
//                                             .avg_monthly,
//                                         latest_yearly: wishlistController
//                                             .wishlistAllItems[index]
//                                             .latest_yearly,
//                                         ebitda: wishlistController
//                                             .wishlistAllItems[index].ebitda,
//                                         rate: wishlistController
//                                             .wishlistAllItems[index].rate,
//                                         type_sale: wishlistController
//                                             .wishlistAllItems[index].type_sale,
//                                         url: wishlistController
//                                             .wishlistAllItems[index].url,
//                                         features: wishlistController
//                                             .wishlistAllItems[index].features,
//                                         facility: wishlistController
//                                             .wishlistAllItems[index].facility,
//                                         income_source: wishlistController
//                                             .wishlistAllItems[index]
//                                             .income_source,
//                                         reason: wishlistController
//                                             .wishlistAllItems[index].reason,
//                                         postedTime: wishlistController
//                                             .wishlistAllItems[index].postedTime,
//                                         topSelling: wishlistController
//                                             .wishlistAllItems[index].topSelling,
//                                         id: wishlistController
//                                             .wishlistAllItems[index].id,
//                                         showEditOption: false,
//                                       ),
//                                     ),
//                                   );
//                                 } else if (item.type == 'investor') {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => InvestorDetailPage(
//                                         imageUrl: wishlistController
//                                             .wishlistAllItems[index].imageUrl,
//                                         name: wishlistController
//                                             .wishlistAllItems[index].name,
//                                         city: wishlistController
//                                             .wishlistAllItems[index].city,
//                                         postedTime: wishlistController
//                                             .wishlistAllItems[index].postedTime,
//                                         state: wishlistController
//                                             .wishlistAllItems[index].state,
//                                         industry: wishlistController
//                                             .wishlistAllItems[index].industry,
//                                         description: wishlistController
//                                             .wishlistAllItems[index]
//                                             .description,
//                                         url: wishlistController
//                                             .wishlistAllItems[index].url,
//                                         rangeStarting: wishlistController
//                                             .wishlistAllItems[index]
//                                             .rangeStarting,
//                                         rangeEnding: wishlistController
//                                             .wishlistAllItems[index]
//                                             .rangeEnding,
//                                         evaluatingAspects: wishlistController
//                                             .wishlistAllItems[index]
//                                             .evaluatingAspects,
//                                         CompanyName: wishlistController
//                                             .wishlistAllItems[index]
//                                             .companyName,
//                                         locationInterested: wishlistController
//                                             .wishlistAllItems[index]
//                                             .locationIntrested,
//                                         id: wishlistController
//                                             .wishlistAllItems[index].id,
//                                         showEditOption: false,
//                                         image2: wishlistController
//                                                 .wishlistAllItems[index]
//                                                 .image2 ??
//                                             '',
//                                         image3: wishlistController
//                                                 .wishlistAllItems[index]
//                                                 .image3 ??
//                                             '',
//                                         image4: wishlistController
//                                             .wishlistAllItems[index].image4,
//                                       ),
//                                     ),
//                                   );
//                                 } else if (item.type == 'franchise') {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => FranchiseDetailPage(
//                                         id: wishlistController
//                                             .wishlistFranchiseItems[index].id,
//                                         imageUrl: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .imageUrl,
//                                         image2: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .image2,
//                                         image3:  wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .image2,
//                                         image4:  wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .image4,
//                                         brandName: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .brandName,
//                                         city: wishlistController
//                                             .wishlistFranchiseItems[index].city,
//                                         postedTime: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .postedTime,
//                                         state: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .state,
//                                         industry: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .industry,
//                                         description: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .description,
//                                         url: wishlistController
//                                             .wishlistFranchiseItems[index].url,
//                                         initialInvestment: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .initialInvestment,
//                                         projectedRoi: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .projectedRoi,
//                                         iamOffering: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .iamOffering,
//                                         currentNumberOfOutlets:
//                                             wishlistController
//                                                 .wishlistFranchiseItems[index]
//                                                 .currentNumberOfOutlets,
//                                         franchiseTerms: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .franchiseTerms,
//                                         locationsAvailable: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .locationsAvailable,
//                                         kindOfSupport: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .kindOfSupport,
//                                         allProducts: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .allProducts,
//                                         brandStartOperation: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .brandStartOperation,
//                                         spaceRequiredMin: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .spaceRequiredMin,
//                                         spaceRequiredMax: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .spaceRequiredMax,
//                                         totalInvestmentFrom: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .totalInvestmentFrom,
//                                         totalInvestmentTo: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .totalInvestmentTo,
//                                         brandFee: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .brandFee,
//                                         avgNoOfStaff: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .avgNoOfStaff,
//                                         avgMonthlySales: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .avgMonthlySales,
//                                         avgEBITDA: wishlistController
//                                             .wishlistFranchiseItems[index]
//                                             .avgEBITDA,
//                                         showEditOption: false,
//                                       ),
//                                     ),
//                                   );
//                                 }
//                                 wishlistController
//                                     .fetchWishlistItems(); // Refresh the wishlist
//                               },
//                               child: Card(
//                                 color: Colors.white,
//                                 elevation: 2,
//                                 child: Container(
//                                   width: w * .5,
//                                   decoration: BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                     border: Border.all(color: Colors.black12),
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Container(
//                                           height: 140,
//                                           decoration: BoxDecoration(
//                                             color: Colors.black12,
//                                             image: DecorationImage(
//                                               image:
//                                                   NetworkImage(item.imageUrl),
//                                               fit: BoxFit.cover,
//                                             ),
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(10)),
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         item.name,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: h * .017),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 8.0, top: 10),
//                                         child: Row(
//                                           children: [
//                                             Image.asset(
//                                               'assets/loc.png',
//                                               height: h * 0.018,
//                                             ),
//                                             SizedBox(width: 5),
//                                             Text(
//                                               item.city,
//                                               style:
//                                                   TextStyle(fontSize: h * .015),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Row(
//                                           children: [
//                                             Icon(
//                                               CupertinoIcons.time,
//                                               color: Colors.green,
//                                               size: h * 0.018,
//                                             ),
//                                             SizedBox(width: 5),
//                                             Text(
//                                               formatDateTime(item.postedTime),
//                                               style:
//                                                   TextStyle(fontSize: h * .015),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_emergio/services/wishlist.dart';
import '../Widgets/wishlist shimmer.dart';
import '../controller/wishlist controller.dart';
import 'detail page/business deatil page.dart';
import 'detail page/franchise detail page.dart';
import 'detail page/invester detail page.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistController wishlistController = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Center(
          child: Text(
            'Wishlist',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Stack(
              children: [
                const Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${wishlistController.businessItems.length + wishlistController.franchiseItems.length + wishlistController.investorItems.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() => wishlistController.isLoading.value
            ? WishlistShimmer.buildShimmerLoading()
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _buildHeader(),
                const SizedBox(height: 20),
                _buildCollectionTitle(),
                const SizedBox(height: 20),
                if (wishlistController.businessItems.isNotEmpty) ...[
                  _buildBusinessSection(),
                  const SizedBox(height: 20),
                ],
                if (wishlistController.franchiseItems.isNotEmpty) ...[
                  _buildFranchiseSection(),
                  const SizedBox(height: 20),
                ],
                if (wishlistController.investorItems.isNotEmpty)
                  _buildInvestorSection(),
              ],
            ),
          ),
        )),
      ),
    );
  }


  Widget _buildCollectionTitle() {
    return Obx(() {
      final totalItems = wishlistController.businessItems.length +
          wishlistController.franchiseItems.length +
          wishlistController.investorItems.length;
      return Row(
        children: [
          const Text(
            'My Collections',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '( $totalItems )',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildBusinessSection() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xff6B89B7),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.business, color: Color(0xff6B89B7)),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Business',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '( ${wishlistController.businessItems.length} )',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildItemGrid(wishlistController.businessItems.value, 'business'),
      ],
    ));
  }

  Widget _buildFranchiseSection() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xffF3D55E),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.store, color: Color(0xffF3D55E)),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Franchise',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '( ${wishlistController.franchiseItems.length} )',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildItemGrid(
            wishlistController.franchiseItems.value, 'franchise'),
      ],
    ));
  }

  Widget _buildInvestorSection() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xffBDD0E7),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.store, color: Color(0xffBDD0E7)),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Investor',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '( ${wishlistController.investorItems.length} )',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildItemGrid(wishlistController.investorItems.value, 'investor'),
      ],
    ));
  }

  Widget _buildItemGrid(List<ProductDetails> items, String type) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 8,
          childAspectRatio: 0.8,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () async {
              if (type == 'business') {
                final businessItem = wishlistController.wishlistAllItems
                    .firstWhereOrNull((element) => element.id == item.id);

                if (businessItem != null) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusinessDetailPage(
                        buisines: businessItem,
                        imageUrl: businessItem.imageUrl,
                        image2: businessItem.image2 ?? '',
                        image3: businessItem.image3 ?? '',
                        image4: businessItem.image4 ?? '',
                        name: businessItem.name,
                        industry: businessItem.industry ?? '',
                        establish_yr: businessItem.establish_yr ?? '',
                        description: businessItem.description ?? '',
                        address_1: businessItem.address_1 ?? '',
                        address_2: businessItem.address_2 ?? '',
                        pin: businessItem.pin ?? '',
                        city: businessItem.city,
                        state: businessItem.state ?? '',
                        employees: businessItem.employees ?? '',
                        entity: businessItem.entity ?? '',
                        avg_monthly: businessItem.avg_monthly ?? '',
                        latest_yearly: businessItem.latest_yearly ?? '',
                        ebitda: businessItem.ebitda ?? '',
                        rate: businessItem.rate ?? '',
                        type_sale: businessItem.type_sale ?? '',
                        url: businessItem.url ?? '',
                        features: businessItem.features ?? '',
                        facility: businessItem.facility ?? '',
                        income_source: businessItem.income_source ?? '',
                        reason: businessItem.reason ?? '',
                        postedTime: businessItem.postedTime,
                        topSelling: businessItem.topSelling ?? '',
                        id: businessItem.id,
                        showEditOption: false,
                        // onRemoveFromWishlist: () async {
                        // await wishlistController.removeFromWishlist(businessItem.id);
                        // },
                      ),
                    ),
                  );

                  if (result == true) {
                    await wishlistController.fetchWishlistItems();
                  }
                }
              } else if (type == 'franchise') {
                final franchiseItem = wishlistController.wishlistFranchiseItems
                    .firstWhereOrNull((element) => element.id == item.id);

                if (franchiseItem != null) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FranchiseDetailPage(
                        franchise: franchiseItem,
                        id: franchiseItem.id,
                        imageUrl: franchiseItem.imageUrl,
                        image2: franchiseItem.image2 ?? '',
                        image3: franchiseItem.image3 ?? '',
                        image4: franchiseItem.image4 ?? '',
                        brandName: franchiseItem.brandName ?? '',
                        city: franchiseItem.city,
                        postedTime: franchiseItem.postedTime,
                        state: franchiseItem.state ?? '',
                        industry: franchiseItem.industry ?? '',
                        description: franchiseItem.description ?? '',
                        url: franchiseItem.url ?? '',
                        initialInvestment: franchiseItem.initialInvestment ?? '',
                        projectedRoi: franchiseItem.projectedRoi ?? '',
                        iamOffering: franchiseItem.iamOffering ?? '',
                        currentNumberOfOutlets:
                        franchiseItem.currentNumberOfOutlets ?? '',
                        franchiseTerms: franchiseItem.franchiseTerms ?? '',
                        locationsAvailable:
                        franchiseItem.locationsAvailable ?? '',
                        kindOfSupport: franchiseItem.kindOfSupport ?? '',
                        allProducts: franchiseItem.allProducts ?? '',
                        brandStartOperation:
                        franchiseItem.brandStartOperation ?? '',
                        spaceRequiredMin: franchiseItem.spaceRequiredMin ?? '',
                        spaceRequiredMax: franchiseItem.spaceRequiredMax ?? '',
                        totalInvestmentFrom:
                        franchiseItem.totalInvestmentFrom ?? '',
                        totalInvestmentTo: franchiseItem.totalInvestmentTo ?? '',
                        brandFee: franchiseItem.brandFee ?? '',
                        avgNoOfStaff: franchiseItem.avgNoOfStaff ?? '',
                        avgMonthlySales: franchiseItem.avgMonthlySales ?? '',
                        avgEBITDA: franchiseItem.avgEBITDA ?? '',
                        showEditOption: false,
                        // onRemoveFromWishlist: () async {
                        // await wishlistController.removeFromWishlist(franchiseItem.id);
                        // },
                      ),
                    ),
                  );

                  if (result == true) {
                    await wishlistController.fetchWishlistItems();
                  }
                }
              } else if (type == 'investor') {
                final investorItem = wishlistController.wishlistAllItems
                    .firstWhereOrNull((element) => element.id == item.id);

                if (investorItem != null) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvestorDetailPage(
                        investor: investorItem,
                        imageUrl: investorItem.imageUrl,
                        name: investorItem.name,
                        city: investorItem.city,
                        postedTime: investorItem.postedTime,
                        state: investorItem.state ?? '',
                        industry: investorItem.industry ?? '',
                        description: investorItem.description ?? '',
                        url: investorItem.url ?? '',
                        rangeStarting: investorItem.rangeStarting ?? '',
                        rangeEnding: investorItem.rangeEnding ?? '',
                        evaluatingAspects: investorItem.evaluatingAspects ?? '',
                        CompanyName: investorItem.companyName ?? '',
                        locationInterested: investorItem.locationIntrested ?? '',
                        id: investorItem.id,
                        showEditOption: false,
                        image2: investorItem.image2 ?? '',
                        image3: investorItem.image3 ?? '',
                        image4: investorItem.image4 ?? '',
                        // onRemoveFromWishlist: () async {
                        // await wishlistController.removeFromWishlist(investorItem.id);
                        // },
                      ),
                    ),
                  );

                  if (result == true) {
                    await wishlistController.fetchWishlistItems();
                  }
                }
              }
            },
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(item.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    item.city,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          },
        );
    }
}
