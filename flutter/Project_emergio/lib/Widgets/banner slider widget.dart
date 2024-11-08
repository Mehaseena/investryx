// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:lottie/lottie.dart';
// import '../services/banners.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class BannerSlider extends StatefulWidget {
//   const BannerSlider({Key? key}) : super(key: key);
//
//   @override
//   _BannerSliderState createState() => _BannerSliderState();
// }
//
// class _BannerSliderState extends State<BannerSlider> {
//   List<String> _imageUrls = [];
//   bool _isLoading = true;
//   bool _hasError = false;
//   bool _noData = false;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchImages();
//   }
//
//   Future<void> fetchImages() async {
//     try {
//       List<Map<String, dynamic>>? banners = await BannerGet.fetchBanners();
//       print('Fetched banners: $banners');
//
//       if (banners != null && banners.isNotEmpty) {
//         List<String> validImageUrls = [];
//         for (var banner in banners) {
//           var imageUrl = banner['img'];
//           print('Image URL: $imageUrl');
//           if (imageUrl != null) {
//             String? validatedUrl = _validateUrl(imageUrl);
//             if (validatedUrl != null) {
//               validImageUrls.add(validatedUrl);
//             } else {
//               print('Warning: Invalid or null image URL');
//             }
//           } else {
//             print('Warning: Image URL is null');
//           }
//         }
//
//         setState(() {
//           _imageUrls = validImageUrls;
//           _isLoading = false;
//           _hasError = false;
//           _noData = validImageUrls.isEmpty;
//         });
//       } else {
//         setState(() {
//           _isLoading = false;
//           _hasError = false;
//           _noData = true;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _hasError = true;
//         _noData = false;
//       });
//     }
//   }
//
//   static String? _validateUrl(String? url) {
//     const String baseUrl = 'https://suhail101.pythonanywhere.com/';
//     if (url == null || url.isEmpty) {
//       return null;
//     }
//     Uri? uri;
//     try {
//       uri = Uri.parse(url);
//       if (!uri.hasScheme) {
//         url = url.startsWith('/') ? url.substring(1) : url;
//         url = baseUrl + url;
//         uri = Uri.parse(url);
//       }
//       if (uri.hasScheme && (uri.hasAuthority || uri.host.isNotEmpty)) {
//         return url;
//       }
//     } catch (e) {
//       return null;
//     }
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//
//     if (_isLoading) {
//       return _buildLoadingIndicator(h);
//     } else if (_hasError) {
//       return _buildErrorMessage(h);
//     } else if (_noData) {
//       return _buildNoDataMessage(h);
//     } else {
//       return _buildCarousel(w);
//     }
//   }
//
//   Widget _buildLoadingIndicator(double h) {
//     return SizedBox(
//       height: h * 0.3,
//       child: Center(child: CircularProgressIndicator()),
//     );
//   }
//
//   Widget _buildErrorMessage(double h) {
//     return SizedBox(
//       height: h * .3,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, size: 40, color: Colors.red),
//             SizedBox(height: 12),
//             Text(
//               "Oops! Something went wrong.",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 6),
//             Text(
//               "Please try again later.",
//               style: TextStyle(fontSize: 14),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNoDataMessage(double h) {
//     return SizedBox(
//       height: h * .3,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Lottie.asset(
//               'assets/nodata.json',
//               height: 80.h,
//               width: 90.w,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(height: 12),
//             Text(
//               "No banners available",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 6),
//             Text(
//               "Check back soon for exciting offers!",
//               style: TextStyle(fontSize: 12.sp),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCarousel(double w) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 250.0,
//         autoPlay: true,
//         enlargeCenterPage: true,
//         aspectRatio: 16 / 9,
//         viewportFraction: 1.0,
//       ),
//       items: _imageUrls.map((url) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Container(
//               width: w,
//               margin: EdgeInsets.symmetric(horizontal: 0.0),
//               child: Image.network(
//                 url,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Center(child: Text('Image not available'));
//                 },
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lottie/lottie.dart';
import '../services/banners.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({Key? key}) : super(key: key);

  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  List<String> _imageUrls = [];
  bool _isLoading = true;
  bool _hasError = false;
  bool _noData = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    try {
      List<Map<String, dynamic>>? banners = await BannerGet.fetchBanners();
      if (banners != null && banners.isNotEmpty) {
        List<String> validImageUrls = banners
            .map((banner) => banner['img'] as String?)
            .where((url) => url != null)
            .map((url) => _validateUrl(url!))
            .where((url) => url != null)
            .cast<String>()
            .toList();

        setState(() {
          _imageUrls = validImageUrls;
          _isLoading = false;
          _hasError = false;
          _noData = validImageUrls.isEmpty;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = false;
          _noData = true;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _noData = false;
      });
    }
  }

  static String? _validateUrl(String url) {
    const String baseUrl = 'https://investryx.com/';
    if (url.isEmpty) return null;

    try {
      Uri uri = Uri.parse(url);
      if (!uri.hasScheme) {
        url = url.startsWith('/') ? url.substring(1) : url;
        url = baseUrl + url;
        uri = Uri.parse(url);
      }
      return uri.hasScheme && (uri.hasAuthority || uri.host.isNotEmpty) ? url : null;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_isLoading) return _buildLoadingIndicator();
    if (_hasError) return _buildErrorMessage();
    if (_noData) return _buildNoDataMessage();
    return _buildCarousel();
  }

  Widget _buildLoadingIndicator() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 165.h,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
    );
  }

  Widget _buildImageLoadingIndicator() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      height: 250.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 40.sp, color: Colors.red),
            SizedBox(height: 12.h),
            Text(
              "Oops! Something went wrong.",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6.h),
            Text(
              "Please try again later.",
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 12.h),
            ElevatedButton(
              onPressed: fetchImages,
              child: Text("Retry"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataMessage() {
    return Container(
      height: 250.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/nodata.json',
              height: 80.h,
              width: 90.w,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 12.h),
            Text(
              "No banners available",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6.h),
            Text(
              "Check back soon for exciting offers!",
              style: TextStyle(fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 165.h,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: .97,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: _imageUrls.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildImageLoadingIndicator(),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.error, color: Colors.red, size: 40.sp),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 10.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _imageUrls.asMap().entries.map((entry) {
              return Container(
                width: 8.w,
                height: 8.h,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).cardColor.withOpacity(
                    _currentIndex == entry.key ? 0.9 : 0.4,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}