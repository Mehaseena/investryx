//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class FilterWidget extends StatefulWidget {
//   const FilterWidget({super.key});
//
//   @override
//   State<FilterWidget> createState() => _FilterWidgetState();
// }
//
// class _FilterWidgetState extends State<FilterWidget> {
//   final List<String> _filters = ['Business', 'Franchise', 'Advisor', 'Investor'];
//   int _selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Card(
//           elevation: 2,
//           child: Container(
//             height: 36.h,
//             width: 210.w,
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.all(Radius.circular(5.r)), // Added border radius
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(5.r)), // Ensure inner radius is the same
//               child: Row(
//                 children: _buildFilterItems(),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   List<Widget> _buildFilterItems() {
//     List<Widget> items = [];
//     for (int i = 0; i < _filters.length; i++) {
//       items.add(_buildFilterItem(i));
//     }
//     return items;
//   }
//
//   Widget _buildFilterItem(int index) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         child: Container(
//           height: 36.h,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.white70),
//             color: _selectedIndex == index ? Colors.white : Colors.transparent,
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Text(
//             _filters[index],
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: _selectedIndex == index ? 11 : 11,
//               color: _selectedIndex == index ? Colors.black : Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterWidget extends StatefulWidget {
  final ValueNotifier<String> selectedFilterNotifier;

  const FilterWidget({super.key, required this.selectedFilterNotifier});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final List<String> _filters = [
    'Business',
    'Franchise',
    'Investor',
    'Advisor'
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 2,
          child: Container(
            height: 36.h,
            width: 210.w,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(5.r)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.r)),
              child: Row(
                children: _buildFilterItems(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFilterItems() {
    List<Widget> items = [];
    for (int i = 0; i < _filters.length; i++) {
      items.add(_buildFilterItem(i));
    }
    return items;
  }

  Widget _buildFilterItem(int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
          widget.selectedFilterNotifier.value = _filters[index];
        },
        child: Container(
          height: 36.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white70),
            color: _selectedIndex == index ? Colors.white : Colors.transparent,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            _filters[index],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: _selectedIndex == index ? 11.sp : 11.sp,
              color: _selectedIndex == index ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
