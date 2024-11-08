// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class FeatureExpertList extends StatelessWidget {
//   final List<ExpertProfile> experts;
//
//   const FeatureExpertList({Key? key, required this.experts}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Feature Expert',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 'See all',
//                 style: TextStyle(
//                   color: Colors.amber,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           // height: 170, // Adjust this value as needed
//           height: 220, // Adjust this value as needed
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: experts.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: EdgeInsets.only(left: index == 0 ? 16 : 4, right: 6),
//                 child: ExpertCard(expert: experts[index]),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class ExpertCard extends StatelessWidget {
//   final ExpertProfile expert;
//
//   const ExpertCard({Key? key, required this.expert}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 178,
//       // width: 115,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.amber, width: 2),
//       ),
//       child: Stack(
//         // crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(10),bottom: Radius.circular(10)),
//             child: Image.asset(
//               expert.imageUrl,
//               height:  double.infinity,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding:  EdgeInsets.only(left: 8.0, top: 130.h, right: 8),  /// top : 80,  for 3 cards
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   expert.name,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color: Colors.white
//                   ),
//                 ),
//                 Text(
//                   expert.businessName,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Icon(Icons.star, color: Colors.amber, size: 16),
//                     SizedBox(width: 4),
//                     Text(
//                       expert.rating.toString(),
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         color: Colors.white
//                       ),
//                     ),
//                     Spacer(),
//                     Container(
//                       padding: EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: Colors.amber,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(Icons.chat_bubble, color: Colors.white, size: 16),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class ExpertProfile {
//   final String name;
//   final String businessName;
//   final String imageUrl;
//   final double rating;
//
//   ExpertProfile({
//     required this.name,
//     required this.businessName,
//     required this.imageUrl,
//     required this.rating,
//   });
// }
//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_emergio/Views/detail%20page/advisor%20detail%20page.dart';
import 'package:project_emergio/services/recent%20activities.dart';
import '../models/all profile model.dart';
import '../services/featured.dart';
import '../services/profile forms/advisor/advisor explore.dart';

class FeatureExpertList extends StatefulWidget {
  final bool? isType;
  final bool? isAdvisor;
  const FeatureExpertList({Key? key, this.isType, this.isAdvisor})
      : super(key: key);

  @override
  _FeatureExpertListState createState() => _FeatureExpertListState();
}

class _FeatureExpertListState extends State<FeatureExpertList> {
  List<AdvisorExplr>? _experts;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchExperts();
  }

  Future<void> _fetchExperts() async {
    try {
      if (widget.isType == true) {
        final experts = await Featured.fetchFeaturedAdvisorData();
        setState(() {
          _experts = experts;
          _isLoading = false;
        });
      } else {
        final experts = await Featured.fetchAllAdvisorData();
        setState(() {
          _experts = experts;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load experts';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.isType == true
                    ? "Featured List"
                    : widget.isAdvisor == true
                    ? 'Advisor Lists'
                    : "Featured Expert",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'See all',
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220, // Adjust this value as needed
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text(_error!))
              : _experts == null || _experts!.isEmpty
              ? Center(child: Text('No experts available'))
              : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _experts!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: index == 0 ? 16 : 4, right: 6),
                child: ExpertCard(expert: _experts![index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ExpertCard extends StatelessWidget {
  final AdvisorExplr expert;

  const ExpertCard({Key? key, required this.expert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("${expert.imageUrl}");
    return InkWell(
      onTap: ()async{
        Navigator.push(context, MaterialPageRoute(builder: (context) => AdvisorDetailPage(advisor: expert,)));
      },
      child: Container(
        width: 178,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.amber, width: 2),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10), bottom: Radius.circular(10)),
              child: Image.network(
                expert.imageUrl,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://via.placeholder.com/400x200', // Make sure you have a placeholder image
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, top: 130.h, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expert.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  Text(
                    expert.designation ?? 'Expert',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '4.5', // You might want to add a rating field to AdvisorExplr
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.chat_bubble,
                            color: Colors.white, size: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Keeping the original ExpertProfile class for reference
class ExpertProfile {
  final String name;
  final String businessName;
  final String imageUrl;
  final double rating;

  ExpertProfile({
  required this.name,
  required this.businessName,
  required this.imageUrl,
  required this.rating,
  });
}
