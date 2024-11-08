import 'package:get/get.dart';
// bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:flutter/services.dart';
import '../Views/Home/business_home.dart';
import '../Views/Home/franchise_home_screen.dart';
import '../Views/Home/home_screen.dart';
import '../Views/Home/investor_home_screen.dart';
import '../Views/profile page.dart';
import '../Views/search page.dart';
import '../Views/wishlist page.dart';
// bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
// navigation_controller.dart
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final _currentIndex = 0.obs;
  final _userType = 'normal'.obs;
  final _showBusinessIcon = false.obs;

  int get currentIndex => _currentIndex.value;
  String get userType => _userType.value;
  bool get showBusinessIcon => _showBusinessIcon.value;

  void changeIndex(int index) {
    _currentIndex.value = index;
  }

  void changeUserType(String type) {
    _userType.value = type;
    _showBusinessIcon.value = type != 'normal';
    // If switching to a business type screen, set index to business icon
    if (type != 'normal') {
      _currentIndex.value = 2;
    }
  }

  void resetToNormal() {
    _userType.value = 'normal';
    _showBusinessIcon.value = false;
    _currentIndex.value = 0;
  }
}



class BottomNavBar extends StatelessWidget {
  final NavigationController controller = Get.find<NavigationController>();

  BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Base navigation items
      List<BottomBarItem> navItems = [
        BottomBarItem(
          icon: ImageIcon(
            const AssetImage('assets/home_icon.png'),
            size: 24,
            color: controller.currentIndex == 0 ? const Color(0xFFFFCC00) : const Color(0xff939393),
          ),
          title: const Text('Home'),
          backgroundColor: const Color(0xFFFFCC00),
          selectedIcon: const ImageIcon(
            AssetImage('assets/home_icon.png'),
            size: 24,
            color: Color(0xFFFFCC00),
          ),
        ),
        BottomBarItem(
          icon: ImageIcon(
            const AssetImage('assets/search_icon.png'),
            size: 28,
            color: controller.currentIndex == 1 ? const Color(0xFFFFCC00) : const Color(0xff939393),
          ),
          title: const Text('Search'),
          backgroundColor: const Color(0xFFFFCC00),
          selectedIcon: const ImageIcon(
            AssetImage('assets/search_icon.png'),
            size: 28,
            color: Color(0xFFFFCC00),
          ),
        ),
      ];

      // Add business icon if showing business screens
      if (controller.showBusinessIcon) {
        String assetName;
        String typeLabel;

        switch (controller.userType) {
          case 'business':
            assetName = 'assets/business_icon.png';
            typeLabel = 'Business';
            break;
          case 'investor':
            assetName = 'assets/investor_icon.png';
            typeLabel = 'Investor';
            break;
          case 'franchise':
            assetName = 'assets/franchise_icon.png';
            typeLabel = 'Franchise';
            break;
          default:
            assetName = 'assets/business_icon.png';
            typeLabel = 'Business';
        }

        navItems.add(
          BottomBarItem(
            icon: ImageIcon(
              AssetImage(assetName),
              size: 24,
              color: controller.currentIndex == 2 ? const Color(0xFFFFCC00) : const Color(0xff939393),
            ),
            title: Text(typeLabel),
            backgroundColor: const Color(0xFFFFCC00),
            selectedIcon: ImageIcon(
              AssetImage(assetName),
              size: 24,
              color: const Color(0xFFFFCC00),
            ),
          ),
        );
      }

      // Calculate correct indices for favorites and profile
      final bool hasBusinessIcon = controller.showBusinessIcon;
      final int favoritesIndex = hasBusinessIcon ? 3 : 2;
      final int profileIndex = hasBusinessIcon ? 4 : 3;

      // Add favorites and profile icons
      navItems.addAll([
        BottomBarItem(
          icon: ImageIcon(
            const AssetImage('assets/fav_icon.png'),
            size: 24,
            color: controller.currentIndex == favoritesIndex ? const Color(0xFFFFCC00) : const Color(0xff939393),
          ),
          title: const Text('Favorites'),
          backgroundColor: const Color(0xFFFFCC00),
          selectedIcon: const ImageIcon(
            AssetImage('assets/fav_icon.png'),
            size: 24,
            color: Color(0xFFFFCC00),
          ),
        ),
        BottomBarItem(
          icon: Icon(
            Icons.person_outline,
            size: 24,
            color: controller.currentIndex == profileIndex ? const Color(0xFFFFCC00) : const Color(0xff939393),
          ),
          title: const Text('Profile'),
          backgroundColor: const Color(0xFFFFCC00),
          selectedIcon: const Icon(
            Icons.person,
            size: 24,
            color: Color(0xFFFFCC00),
          ),
        ),
      ]);

      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: StylishBottomBar(
          option:  DotBarOptions(
            dotStyle: DotStyle.tile,
            inkColor: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          ),
          items: navItems,
          fabLocation: StylishBarFabLocation.center,
          hasNotch: true,
          currentIndex: controller.currentIndex,
          onTap: (index) async {
            await HapticUtils.navigationFeedback();
            // Adjust index based on business icon visibility
            controller.changeIndex(index);
            _handleNavigation(context, index);
          },
          borderRadius: BorderRadius.circular(20),
        ),
      );
    });
  }

  void _handleNavigation(BuildContext context, int index) {
    // Handle navigation based on current state
    if (controller.showBusinessIcon) {
      switch (index) {
        case 0:
          Get.offAll(() => const CustomBottomNavBar(userType: 'normal', initialIndex: 0));
          break;
        case 1:
          Get.offAll(() => const CustomBottomNavBar(userType: 'normal', initialIndex: 1));
          break;
        case 2:
        // Stay on current business/investor/franchise screen
          break;
        case 3:
          Get.offAll(() => const CustomBottomNavBar(userType: 'normal', initialIndex: 2));
          break;
        case 4:
          Get.offAll(() => const CustomBottomNavBar(userType: 'normal', initialIndex: 3));
          break;
      }
    } else {
      // Normal navigation
      Get.offAll(() => CustomBottomNavBar(initialIndex: index));
    }
  }
}

// custom_bottom_nav_bar.dart
class CustomBottomNavBar extends StatefulWidget {
  final String userType;
  final int initialIndex;

  const CustomBottomNavBar({
    Key? key,
    this.userType = 'normal',
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final NavigationController controller = Get.put(NavigationController());
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    controller.changeUserType(widget.userType);
    controller.changeIndex(widget.initialIndex);
    _pageController = PageController(initialPage: widget.initialIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.userType != 'normal') {
        _pageController.jumpToPage(2); // Jump to business icon position
      }
    });
  }

  List<Widget> _getScreenList() {
    List<Widget> screens = [
       InveStryxHomePage(),
      const SearchScreen(),
    ];

    if (controller.showBusinessIcon) {
      screens.add(_getTypeSpecificScreen());
    }

    screens.addAll([
      WishlistScreen(),
       ProfileScreen(),
    ]);

    return screens;
  }

  Widget _getTypeSpecificScreen() {
    switch (controller.userType) {
      case 'business':
        return const BusinessHomeScreen();
      case 'investor':
        return const InvestorHomeScreen();
      case 'franchise':
        return const FranchiseHomeScreen();
      default:
        return const BusinessHomeScreen();
    }
  }

  Future<bool> _onWillPop() async {
    if (controller.showBusinessIcon) {
      controller.resetToNormal();
      Get.offAll(() => const CustomBottomNavBar());
      return false;
    }
    if (controller.currentIndex != 0) {
      controller.changeIndex(0);
      _pageController.jumpToPage(0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Obx(() => PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: _getScreenList(),
          onPageChanged: (index) {
            controller.changeIndex(index);
          },
        )),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
class HapticUtils {
  static Future<void> navigationFeedback() async {
    await HapticFeedback.selectionClick();
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../Views/Home/business_home.dart';
// import '../Views/Home/franchise_home_screen.dart';
// import '../Views/Home/home_screen.dart';
// import '../Views/Home/investor_home_screen.dart';
// import '../Views/profile page.dart';
// import '../Views/search page.dart';
// import '../Views/wishlist page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
//
// class CustomBottomNavBar extends StatefulWidget {
//   final String userType;
//   final int initialIndex;
//
//   const CustomBottomNavBar({
//     Key? key,
//     this.userType = 'normal',
//     this.initialIndex = 0,
//   }) : super(key: key);
//
//   @override
//   State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
// }
//
// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   final NavigationController controller = Get.put(NavigationController());
//   late PageController _pageController;
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.userType != 'normal') {
//       controller.showTypeSpecificIcon(widget.userType);
//     } else {
//       controller.hideTypeSpecificIcon();
//     }
//     _pageController = PageController(initialPage: widget.initialIndex);
//   }
//
//   List<Widget> _getScreenList() {
//     List<Widget> screens = [
//        InveStryxHomePage(),
//       const SearchScreen(),
//     ];
//
//     if (controller.showBusinessIcon) {
//       Widget typeSpecificScreen;
//       switch (controller.userType) {
//         case 'business':
//           typeSpecificScreen = const BusinessHomeScreen();
//           break;
//         case 'investor':
//           typeSpecificScreen = const InvestorHomeScreen();
//           break;
//         case 'franchise':
//           typeSpecificScreen = const FranchiseHomeScreen();
//           break;
//         default:
//           typeSpecificScreen = const BusinessHomeScreen();
//       }
//       screens.add(typeSpecificScreen);
//     }
//
//     screens.addAll([
//        WishListScreen(),
//        ProfileScreen(),
//     ]);
//
//     return screens;
//   }
//
//   Future<bool> _onWillPop() async {
//     if (controller.showBusinessIcon) {
//       controller.hideTypeSpecificIcon();
//       Get.offAll(() => const CustomBottomNavBar());
//       return false;
//     }
//     if (controller.currentIndex != 0) {
//       controller.changeIndex(0);
//       _pageController.jumpToPage(0);
//       return false;
//     }
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         body: Obx(() => PageView(
//           physics: const NeverScrollableScrollPhysics(),
//           controller: _pageController,
//           children: _getScreenList(),
//           onPageChanged: (index) {
//             controller.changeIndex(index);
//           },
//         )),
//         bottomNavigationBar: BottomNavBar(),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
// }
//
//
//
//
// class BottomNavBar extends StatelessWidget {
//   BottomNavBar({Key? key}) : super(key: key);
//
//   final NavigationController controller = Get.find<NavigationController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       List<BottomBarItem> navItems = [
//         BottomBarItem(
//           icon: ImageIcon(
//             const AssetImage('assets/home_icon.png'),
//             size: 24,
//             color: controller.currentIndex == 0 ? const Color(0xFFFFCC00) : const Color(0xff939393),
//           ),
//           title: const Text('Home'),
//           backgroundColor: const Color(0xFFFFCC00),
//           selectedIcon: const ImageIcon(
//             AssetImage('assets/home_icon.png'),
//             size: 24,
//             color: Color(0xFFFFCC00),
//           ),
//         ),
//         BottomBarItem(
//           icon: ImageIcon(
//             const AssetImage('assets/search_icon.png'),
//             size: 28,
//             color: controller.currentIndex == 1 ? const Color(0xFFFFCC00) : const Color(0xff939393),
//           ),
//           title: const Text('Search'),
//           backgroundColor: const Color(0xFFFFCC00),
//           selectedIcon: const ImageIcon(
//             AssetImage('assets/search_icon.png'),
//             size: 28,
//             color: Color(0xFFFFCC00),
//           ),
//         ),
//       ];
//
//       if (controller.showBusinessIcon) {
//         String assetName;
//         String typeLabel;
//
//         switch (controller.userType) {
//           case 'business':
//             assetName = 'assets/business_icon.png';
//             typeLabel = 'Business';
//             break;
//           case 'investor':
//             assetName = 'assets/investor_icon.png';
//             typeLabel = 'Investor';
//             break;
//           case 'franchise':
//             assetName = 'assets/franchise_icon.png';
//             typeLabel = 'Franchise';
//             break;
//           default:
//             assetName = 'assets/business_icon.png';
//             typeLabel = 'Business';
//         }
//
//         navItems.add(
//           BottomBarItem(
//             icon: ImageIcon(
//               AssetImage(assetName),
//               size: 24,
//               color: controller.currentIndex == 2 ? const Color(0xFFFFCC00) : const Color(0xff939393),
//             ),
//             title: Text(typeLabel),
//             backgroundColor: const Color(0xFFFFCC00),
//             selectedIcon: ImageIcon(
//               AssetImage(assetName),
//               size: 24,
//               color: const Color(0xFFFFCC00),
//             ),
//           ),
//         );
//       }
//
//       final bool hasBusinessIcon = controller.showBusinessIcon;
//       final int favoritesIndex = hasBusinessIcon ? 3 : 2;
//       final int profileIndex = hasBusinessIcon ? 4 : 3;
//
//       navItems.addAll([
//         BottomBarItem(
//           icon: ImageIcon(
//             const AssetImage('assets/fav_icon.png'),
//             size: 24,
//             color: controller.currentIndex == favoritesIndex ? const Color(0xFFFFCC00) : const Color(0xff939393),
//           ),
//           title: const Text('Favorites'),
//           backgroundColor: const Color(0xFFFFCC00),
//           selectedIcon: const ImageIcon(
//             AssetImage('assets/fav_icon.png'),
//             size: 24,
//             color: Color(0xFFFFCC00),
//           ),
//         ),
//         BottomBarItem(
//           icon: Icon(
//             Icons.person_outline,
//             size: 24,
//             color: controller.currentIndex == profileIndex ? const Color(0xFFFFCC00) : const Color(0xff939393),
//           ),
//           title: const Text('Profile'),
//           backgroundColor: const Color(0xFFFFCC00),
//           selectedIcon: const Icon(
//             Icons.person,
//             size: 24,
//             color: Color(0xFFFFCC00),
//           ),
//         ),
//       ]);
//
//       return ClipRRect(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         child: StylishBottomBar(
//           option:  DotBarOptions(
//             dotStyle: DotStyle.tile,
//             inkColor: Colors.transparent,
//             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//           ),
//           items: navItems,
//           fabLocation: StylishBarFabLocation.center,
//           hasNotch: true,
//           currentIndex: controller.currentIndex,
//           onTap: (index) async {
//             await HapticUtils.navigationFeedback();
//             _handleNavigation(context, index);
//           },
//           borderRadius: BorderRadius.circular(20),
//         ),
//       );
//     });
//   }
//
//   void _handleNavigation(BuildContext context, int index) {
//     if (controller.showBusinessIcon) {
//       if (index < 2) {
//         // Going to Home or Search
//         controller.hideTypeSpecificIcon();
//         Get.offAll(() => CustomBottomNavBar(initialIndex: index));
//       } else if (index > 2) {
//         // Going to Favorites or Profile
//         controller.hideTypeSpecificIcon();
//         Get.offAll(() => CustomBottomNavBar(initialIndex: index - 1));
//       } else {
//         // Clicking on business icon
//         controller.changeIndex(index);
//       }
//     } else {
//       // Normal navigation
//       controller.changeIndex(index);
//     }
//   }
// }
//
// class NavigationController extends GetxController {
//   final _currentIndex = 0.obs;
//   final _userType = 'normal'.obs;
//   final _showBusinessIcon = false.obs;
//
//   int get currentIndex => _currentIndex.value;
//   String get userType => _userType.value;
//   bool get showBusinessIcon => _showBusinessIcon.value;
//
//   void changeIndex(int index) {
//     _currentIndex.value = index;
//   }
//
//   void showTypeSpecificIcon(String type) {
//     _userType.value = type;
//     _showBusinessIcon.value = true;
//     _currentIndex.value = 2; // Set to business icon position
//   }
//
//   void hideTypeSpecificIcon() {
//     _userType.value = 'normal';
//     _showBusinessIcon.value = false;
//     _currentIndex.value = 0;
//   }
// }
//
// // lib/utils/haptic_utils.dart
//
// class HapticUtils {
//   static Future<void> navigationFeedback() async {
//     await HapticFeedback.selectionClick();
//   }
// }