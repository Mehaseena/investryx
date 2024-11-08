// import 'package:flutter/material.dart';
// import 'package:timeago/timeago.dart' as timeago;
// import 'dart:async';
// import '../services/search.dart';
// import 'detail page/advisor detail page.dart';
// import 'detail page/business deatil page.dart';
// import 'detail page/franchise detail page.dart';
// import 'detail page/invester detail page.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController textController = TextEditingController();
//   final SearchServices _searchServices = SearchServices();
//   List<SearchResult> searchResults = [];
//   List<String> recentSearches = [];
//   bool isLoading = false;
//   Timer? _debounce;
//   String? errorMessage;
//   bool hasSearched = false;
//
//   // Filter variables
//   String city = '';
//   String state = '';
//   String industry = '';
//   String entityType = '';
//   String establishFrom = '';
//   String establishTo = '';
//   String rangeStarting = '';
//   String rangeEnding = '';
//   bool filter = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadRecentSearches();
//   }
//
//   Future<void> _loadRecentSearches() async {
//     final searches = await _searchServices.loadRecentSearches();
//     setState(() {
//       recentSearches = searches;
//     });
//   }
//
//   Future<void> _clearRecentSearches() async {
//     await _searchServices.clearRecentSearches();
//     setState(() {
//       recentSearches = [];
//     });
//   }
//
//   String formatDateTime(String dateTimeStr) {
//     DateTime dateTime = DateTime.parse(dateTimeStr);
//     return timeago.format(dateTime, allowFromNow: true);
//   }
//
//   String toStringValue(dynamic value) {
//     if (value == null) return '';
//     if (value is int || value is double) return value.toString();
//     if (value is List) return value.join(', ');
//     return value.toString();
//   }
//
//   Future<void> search(String query) async {
//     if (query.isEmpty) {
//       setState(() {
//         searchResults = [];
//         errorMessage = null;
//         hasSearched = false;
//       });
//       return;
//     }
//
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//       hasSearched = true;
//     });
//
//     final result = await _searchServices.performSearch(
//       query: query,
//       city: city,
//       state: state,
//       industry: industry,
//       entityType: entityType,
//       establishFrom: establishFrom,
//       establishTo: establishTo,
//       rangeStarting: rangeStarting,
//       rangeEnding: rangeEnding,
//       filter: filter,
//     );
//
//     setState(() {
//       isLoading = false;
//       if (result['success']) {
//         searchResults = result['results'];
//         errorMessage = null;
//       } else {
//         searchResults = [];
//         errorMessage = result['error'];
//       }
//     });
//
//     if (result['success']) {
//       await _searchServices.saveRecentSearch(query, recentSearches);
//       await _loadRecentSearches();
//     }
//   }
//
//   void _onTextChanged(String query) {
//     if (_debounce?.isActive ?? false) {
//       _debounce?.cancel();
//     }
//     _debounce = Timer(const Duration(milliseconds: 500), () {
//       if (query.isNotEmpty) {
//         search(query);
//       } else {
//         setState(() {
//           searchResults = [];
//           errorMessage = null;
//           hasSearched = false;
//         });
//       }
//     });
//   }
//
//   void _navigateToDetail(SearchResult result) {
//     switch (result.type.toLowerCase()) {
//       case 'business':
//         final businessData = {
//           ...result.rawData,
//           'employees': toStringValue(result.rawData['employees']),
//           'avg_monthly': toStringValue(result.rawData['avg_monthly']),
//           'latest_yearly': toStringValue(result.rawData['latest_yearly']),
//           'ebitda': toStringValue(result.rawData['ebitda']),
//           'rate': toStringValue(result.rawData['rate']),
//           'postedTime': result.rawData['listed_on'],
//           'establish_yr': toStringValue(result.rawData['establish_yr']),
//         };
//
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BusinessDetailPage(
//               imageUrl: result.imageUrl,
//               image2: toStringValue(businessData['image2']),
//               image3: toStringValue(businessData['image3']),
//               image4: toStringValue(businessData['image4']),
//               name: result.name,
//               industry: toStringValue(businessData['industry']),
//               establish_yr: businessData['establish_yr'],
//               description: result.description,
//               address_1: toStringValue(businessData['address_1']),
//               address_2: toStringValue(businessData['address_2']),
//               pin: toStringValue(businessData['pin']),
//               city: result.location,
//               state: toStringValue(businessData['state']),
//               employees: businessData['employees'],
//               entity: toStringValue(businessData['entity']),
//               avg_monthly: businessData['avg_monthly'],
//               latest_yearly: businessData['latest_yearly'],
//               ebitda: businessData['ebitda'],
//               rate: businessData['rate'],
//               type_sale: toStringValue(businessData['type_sale']),
//               url: toStringValue(businessData['url']),
//               features: toStringValue(businessData['features']),
//               facility: toStringValue(businessData['facility']),
//               income_source: toStringValue(businessData['income_source']),
//               reason: toStringValue(businessData['reason']),
//               postedTime: businessData['postedTime'],
//               topSelling: toStringValue(businessData['topSelling']),
//               id: result.id,
//               showEditOption: false,
//             ),
//           ),
//         );
//         break;
//
//       case 'investor':
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => InvestorDetailPage(
//               imageUrl: result.imageUrl,
//               image2: toStringValue(result.rawData['image2']),
//               image3: toStringValue(result.rawData['image3']),
//               image4: toStringValue(result.rawData['image4']),
//               name: result.name,
//               city: result.location,
//               postedTime: result.rawData['listed_on'],
//               state: toStringValue(result.rawData['state']),
//               industry: toStringValue(result.rawData['industry']),
//               description: result.description,
//               url: toStringValue(result.rawData['url']),
//               rangeStarting: toStringValue(result.rawData['rangeStarting']),
//               rangeEnding: toStringValue(result.rawData['rangeEnding']),
//               evaluatingAspects:
//               toStringValue(result.rawData['evaluatingAspects']),
//               CompanyName:
//               toStringValue(result.rawData['company'] ?? result.name),
//               locationInterested:
//               toStringValue(result.rawData['locationIntrested']),
//               id: result.id,
//               showEditOption: false,
//             ),
//           ),
//         );
//         break;
//
//       case 'franchise':
//         final franchiseData = {
//           ...result.rawData,
//           'postedTime': formatDateTime(result.rawData['listed_on']),
//           'currentNumberOfOutlets':
//           toStringValue(result.rawData['currentNumberOfOutlets']),
//           'spaceRequiredMin': toStringValue(result.rawData['spaceRequiredMin']),
//           'spaceRequiredMax': toStringValue(result.rawData['spaceRequiredMax']),
//           'totalInvestmentFrom':
//           toStringValue(result.rawData['totalInvestmentFrom']),
//           'totalInvestmentTo':
//           toStringValue(result.rawData['totalInvestmentTo']),
//           'brandFee': toStringValue(result.rawData['brandFee']),
//           'avgNoOfStaff': toStringValue(result.rawData['avgNoOfStaff']),
//           'avgMonthlySales': toStringValue(result.rawData['avgMonthlySales']),
//           'avgEBITDA': toStringValue(result.rawData['avgEBITDA']),
//           'brandStartOperation':
//           toStringValue(result.rawData['brandStartOperation']),
//         };
//
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => FranchiseDetailPage(
//               id: result.id,
//               imageUrl: result.imageUrl,
//               image2: toStringValue(franchiseData['image2']),
//               image3: toStringValue(franchiseData['image3']),
//               image4: toStringValue(franchiseData['image4']),
//               brandName: result.name,
//               city: result.location,
//               postedTime: franchiseData['postedTime'],
//               state: toStringValue(franchiseData['state']),
//               industry: toStringValue(franchiseData['industry']),
//               description: result.description,
//               url: toStringValue(franchiseData['url']),
//               initialInvestment:
//               toStringValue(franchiseData['initialInvestment']),
//               projectedRoi: toStringValue(franchiseData['projectedRoi']),
//               iamOffering: toStringValue(franchiseData['iamOffering']),
//               currentNumberOfOutlets: franchiseData['currentNumberOfOutlets'],
//               franchiseTerms: toStringValue(franchiseData['franchiseTerms']),
//               locationsAvailable:
//               toStringValue(franchiseData['locationsAvailable']),
//               kindOfSupport: toStringValue(franchiseData['kindOfSupport']),
//               allProducts: toStringValue(franchiseData['allProducts']),
//               brandStartOperation: franchiseData['brandStartOperation'],
//               spaceRequiredMin: franchiseData['spaceRequiredMin'],
//               spaceRequiredMax: franchiseData['spaceRequiredMax'],
//               totalInvestmentFrom: franchiseData['totalInvestmentFrom'],
//               totalInvestmentTo: franchiseData['totalInvestmentTo'],
//               brandFee: franchiseData['brandFee'],
//               avgNoOfStaff: franchiseData['avgNoOfStaff'],
//               avgMonthlySales: franchiseData['avgMonthlySales'],
//               avgEBITDA: franchiseData['avgEBITDA'],
//               showEditOption: false,
//             ),
//           ),
//         );
//         break;
//
//       case 'advisor':
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => AdvisorDetailPage(
//               imageUrl: result.imageUrl,
//               name: result.name,
//               interest: toStringValue(result.rawData['interest']),
//               designation: result.rawData['designation'] ?? '',
//               contactNumber: result.rawData['contactNumber'] ?? '',
//               state: result.rawData['state'] ?? '',
//               url: result.rawData['url'] ?? '',
//               description: result.description,
//               location: result.location,
//               userId: result.rawData['user']?.toString() ?? '',
//             ),
//           ),
//         );
//         break;
//     }
//   }
//
//   Widget _buildStyledChip(String label) {
//     return GestureDetector(
//       onTap: () {
//         textController.text = label;
//         search(label);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.8),
//               spreadRadius: 1,
//               blurRadius: 3,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Chip(
//           label: Text(
//             label,
//             style: const TextStyle(color: Colors.black),
//           ),
//           backgroundColor: Colors.white,
//           deleteIcon: const Icon(
//             Icons.close,
//             size: 18,
//             color: Color(0xffFFCC00),
//           ),
//           onDeleted: () async {
//             setState(() {
//               recentSearches.remove(label);
//             });
//             final searches = await _searchServices.loadRecentSearches();
//             searches.remove(label);
//             await _searchServices.saveRecentSearch('', searches);
//           },
//           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
//           visualDensity: VisualDensity.compact,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//             side: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }
//
//   void showCustomBottomSheet(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: SingleChildScrollView(
//                 child: SizedBox(
//                   height: h * 0.7,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Filters',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               setState(() {
//                                 city = '';
//                                 state = '';
//                                 industry = '';
//                                 entityType = '';
//                                 establishFrom = '';
//                                 establishTo = '';
//                                 rangeStarting = '';
//                                 rangeEnding = '';
//                                 filter = false;
//                               });
//                               Navigator.pop(context);
//                               search(textController.text);
//                             },
//                             child: const Text(
//                               'Remove',
//                               style: TextStyle(color: Colors.red),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 30),
//                       Center(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             filter = true;
//                             Navigator.pop(context);
//                             search(textController.text);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xffFFCC00),
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 32,
//                               vertical: 12,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: const Text(
//                             'Apply Filter',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 25),
//                       // Location Filter
//                       DropdownButtonFormField<String>(
//                         decoration: const InputDecoration(
//                           labelText: 'Location',
//                           border: OutlineInputBorder(),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xffFFCC00)),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xffFFCC00)),
//                           ),
//                         ),
//                         value: city.isEmpty ? null : city,
//                         items: const [
//                           DropdownMenuItem(
//                               value: 'New York', child: Text('New York')),
//                           DropdownMenuItem(
//                               value: 'Los Angeles', child: Text('Los Angeles')),
//                           DropdownMenuItem(
//                               value: 'Chicago', child: Text('Chicago')),
//                         ],
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             city = newValue ?? '';
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 25),
//                       // Industry Filter
//                       DropdownButtonFormField<String>(
//                         decoration: const InputDecoration(
//                           labelText: 'Industry',
//                           border: OutlineInputBorder(),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xffFFCC00)),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xffFFCC00)),
//                           ),
//                         ),
//                         value: industry.isEmpty ? null : industry,
//                         items: const [
//                           DropdownMenuItem(
//                               value: 'Technology', child: Text('Technology')),
//                           DropdownMenuItem(
//                               value: 'Healthcare', child: Text('Healthcare')),
//                           DropdownMenuItem(
//                               value: 'Retail', child: Text('Retail')),
//                         ],
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             industry = newValue ?? '';
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 25),
//                       // Business Type Filter
//                       DropdownButtonFormField<String>(
//                         decoration: const InputDecoration(
//                           labelText: 'Business Type',
//                           border: OutlineInputBorder(),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xffFFCC00)),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xffFFCC00)),
//                           ),
//                         ),
//                         value: entityType.isEmpty ? null : entityType,
//                         items: const [
//                           DropdownMenuItem(
//                               value: 'business', child: Text('Business')),
//                           DropdownMenuItem(
//                               value: 'investor', child: Text('Investor')),
//                           DropdownMenuItem(
//                               value: 'franchise', child: Text('Franchise')),
//                           DropdownMenuItem(
//                               value: 'advisor', child: Text('Advisor')),
//                         ],
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             entityType = newValue ?? '';
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 25),
//                       // Investment Range
//                       const Text(
//                         'Investment Range',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextFormField(
//                               decoration: const InputDecoration(
//                                 labelText: 'Min Investment',
//                                 border: OutlineInputBorder(),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide:
//                                   BorderSide(color: Color(0xffFFCC00)),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide:
//                                   BorderSide(color: Color(0xffFFCC00)),
//                                 ),
//                               ),
//                               keyboardType: TextInputType.number,
//                               onChanged: (value) {
//                                 setState(() {
//                                   rangeStarting = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: TextFormField(
//                               decoration: const InputDecoration(
//                                 labelText: 'Max Investment',
//                                 border: OutlineInputBorder(),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide:
//                                   BorderSide(color: Color(0xffFFCC00)),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide:
//                                   BorderSide(color: Color(0xffFFCC00)),
//                                 ),
//                               ),
//                               keyboardType: TextInputType.number,
//                               onChanged: (value) {
//                                 setState(() {
//                                   rangeEnding = value;
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 25),
//                       // Year Established Range
//                       const Text(
//                         'Year Established',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextFormField(
//                               decoration: const InputDecoration(
//                                 labelText: 'From Year',
//                                 border: OutlineInputBorder(),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide:
//                                   BorderSide(color: Color(0xffFFCC00)),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide:
//                                   BorderSide(color: Color(0xffFFCC00)),
//                                 ),
//                               ),
//                               keyboardType: TextInputType.number,
//                               onChanged: (value) {
//                                 setState(() {
//                                   establishFrom = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: TextFormField(
//                               decoration: const InputDecoration(
//                                 labelText: 'To Year',
//                                 border: OutlineInputBorder(),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide:
//                                   BorderSide(color: Color(0xffFFCC00)),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide:
//                                   BorderSide(color: Color(0xffFFCC00)),
//                                 ),
//                               ),
//                               keyboardType: TextInputType.number,
//                               onChanged: (value) {
//                                 setState(() {
//                                   establishTo = value;
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 25),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//         title: const Center(
//           child: Text(
//             'Search',
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//         ),
//         elevation: 0,
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 16.0),
//             child: Icon(Icons.notifications, color: Colors.black),
//           ),
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: textController,
//                   onChanged: _onTextChanged,
//                   decoration: InputDecoration(
//                     hintText: 'Search...',
//                     filled: true,
//                     fillColor: const Color(0xffF3F8FE),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide.none,
//                     ),
//                     suffixIcon: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         if (textController.text.isNotEmpty)
//                           IconButton(
//                             icon: const Icon(Icons.clear),
//                             onPressed: () {
//                               textController.clear();
//                               setState(() {
//                                 searchResults = [];
//                                 errorMessage = null;
//                                 hasSearched = false;
//                               });
//                             },
//                           ),
//                         CircleAvatar(
//                           backgroundColor: const Color(0xffFFCC00),
//                           child: IconButton(
//                             icon: const Icon(Icons.search, color: Colors.white),
//                             onPressed: () => search(textController.text),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               CircleAvatar(
//                 backgroundColor: const Color(0xffFFCC00),
//                 child: IconButton(
//                   icon: const Icon(Icons.sort_sharp, color: Colors.white),
//                   onPressed: () {
//                     showCustomBottomSheet(context);
//                   },
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           if (recentSearches.isNotEmpty && !hasSearched)
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Previous Searches',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 const SizedBox(height: 8),
//                 Wrap(
//                   spacing: 25,
//                   runSpacing: 15,
//                   children: recentSearches
//                       .map((search) => _buildStyledChip(search))
//                       .toList(),
//                 ),
//               ],
//             ),
//           const SizedBox(height: 16),
//           if (isLoading)
//             const Center(
//               child: Column(
//                 children: [
//                   CircularProgressIndicator(
//                     valueColor:
//                     AlwaysStoppedAnimation<Color>(Color(0xffFFCC00)),
//                   ),
//                   SizedBox(height: 16),
//                   Text('Searching...'),
//                 ],
//               ),
//             )
//           else if (errorMessage != null && hasSearched)
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.search_off,
//                     size: 64,
//                     color: Colors.grey,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     errorMessage!,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       color: Colors.grey,
//                       fontSize: 16,
//                     ),
//                   ),
//                   if (filter) ...[
//                     const SizedBox(height: 16),
//                     TextButton(
//                       onPressed: () {
//                         setState(() {
//                           city = '';
//                           state = '';
//                           industry = '';
//                           entityType = '';
//                           establishFrom = '';
//                           establishTo = '';
//                           rangeStarting = '';
//                           rangeEnding = '';
//                           filter = false;
//                         });
//                         search(textController.text);
//                       },
//                       child: const Text(
//                         'Clear filters and try again',
//                         style: TextStyle(color: Color(0xffFFCC00)),
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             )
//           else if (searchResults.isNotEmpty)
//               Column(
//                 children: searchResults.map((result) {
//                   return GestureDetector(
//                     onTap: () => _navigateToDetail(result),
//                     child: Container(
//                       margin: const EdgeInsets.only(bottom: 16),
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2),
//                             spreadRadius: 1,
//                             blurRadius: 5,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.network(
//                               result.imageUrl,
//                               width: 100,
//                               height: 100,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) =>
//                                   Container(
//                                     width: 100,
//                                     height: 100,
//                                     color: Colors.grey[300],
//                                     child: const Icon(Icons.error),
//                                   ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   result.name,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Row(
//                                   children: [
//                                     Icon(Icons.location_on,
//                                         size: 16, color: Colors.grey[600]),
//                                     const SizedBox(width: 4),
//                                     Text(
//                                       result.location,
//                                       style: TextStyle(
//                                         color: Colors.grey[600],
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   result.description,
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                     color: Colors.grey[800],
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 8, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color:
//                                     const Color(0xffFFCC00).withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Text(
//                                     result.type,
//                                     style: const TextStyle(
//                                       color: Color(0xffFFCC00),
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//         ],
//       ),
//       floatingActionButton: recentSearches.isNotEmpty
//           ? Padding(
//         padding: const EdgeInsets.only(bottom: 20),
//         child: SizedBox(
//           width: 220,
//           height: 40,
//           child: FloatingActionButton(
//             onPressed: () async {
//               await _clearRecentSearches();
//             },
//             backgroundColor: const Color(0xffFFCC00),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.close, color: Colors.white),
//                 SizedBox(width: 10),
//                 Text(
//                   'Clear Search History',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       )
//           : null,
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
//
//   @override
//   void dispose() {
//     _debounce?.cancel();
//     textController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';
import '../services/search.dart';
import 'detail page/advisor detail page.dart';
import 'detail page/business deatil page.dart';
import 'detail page/franchise detail page.dart';
import 'detail page/invester detail page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController textController = TextEditingController();
  final SearchServices _searchServices = SearchServices();
  List<SearchResult> searchResults = [];
  List<SearchResult> recentResults = [];
  List<String> recentSearches = [];
  bool isLoading = false;
  Timer? _debounce;
  String? errorMessage;
  bool hasSearched = false;

  // Filter variables
  String city = '';
  String state = '';
  String industry = '';
  String entityType = '';
  String establishFrom = '';
  String establishTo = '';
  String rangeStarting = '';
  String rangeEnding = '';
  bool filter = false;

  final CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
    _loadRecentResults();
  }

  // Future<void> _loadRecentResults() async {
  //   final results = await _searchServices.getRecentResults();
  //   setState(() {
  //     recentResults = results;
  //   });
  // }

  Future<void> _loadRecentSearches() async {
    final searches = await _searchServices.loadRecentSearches();
    setState(() {
      recentSearches = searches;
    });
  }

  Future<void> _clearRecentSearches() async {
    await _searchServices.clearRecentSearches();
    setState(() {
      recentSearches = [];
    });
  }

  String formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    return timeago.format(dateTime, allowFromNow: true);
  }

  String toStringValue(dynamic value) {
    if (value == null) return '';
    if (value is int || value is double) return value.toString();
    if (value is List) return value.join(', ');
    return value.toString();
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
        errorMessage = null;
        hasSearched = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
      hasSearched = true;
    });

    final result = await _searchServices.performSearch(
      query: query,
      city: city,
      state: state,
      industry: industry,
      entityType: entityType,
      establishFrom: establishFrom,
      establishTo: establishTo,
      rangeStarting: rangeStarting,
      rangeEnding: rangeEnding,
      filter: filter,
    );

    setState(() {
      isLoading = false;
      if (result['success']) {
        searchResults = result['results'];
        errorMessage = null;
      } else {
        searchResults = [];
        errorMessage = result['error'];
      }
    });

    if (result['success']) {
      await _searchServices.saveRecentSearch(query, recentSearches);
      await _loadRecentSearches();
    }
  }

  void _onTextChanged(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        search(query);
      } else {
        setState(() {
          searchResults = [];
          errorMessage = null;
          hasSearched = false;
        });
      }
    });
  }

  void _navigateToDetail(SearchResult result) {
    switch (result.type.toLowerCase()) {
      case 'business':
        final businessData = {
          ...result.rawData,
          'employees': toStringValue(result.rawData['employees']),
          'avg_monthly': toStringValue(result.rawData['avg_monthly']),
          'latest_yearly': toStringValue(result.rawData['latest_yearly']),
          'ebitda': toStringValue(result.rawData['ebitda']),
          'rate': toStringValue(result.rawData['rate']),
          'postedTime': result.rawData['listed_on'],
          'establish_yr': toStringValue(result.rawData['establish_yr']),
        };

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BusinessDetailPage(
              imageUrl: result.imageUrl,
              image2: toStringValue(businessData['image2']),
              image3: toStringValue(businessData['image3']),
              image4: toStringValue(businessData['image4']),
              name: result.name,
              industry: toStringValue(businessData['industry']),
              establish_yr: businessData['establish_yr'],
              description: result.description,
              address_1: toStringValue(businessData['address_1']),
              address_2: toStringValue(businessData['address_2']),
              pin: toStringValue(businessData['pin']),
              city: result.location,
              state: toStringValue(businessData['state']),
              employees: businessData['employees'],
              entity: toStringValue(businessData['entity']),
              avg_monthly: businessData['avg_monthly'],
              latest_yearly: businessData['latest_yearly'],
              ebitda: businessData['ebitda'],
              rate: businessData['rate'],
              type_sale: toStringValue(businessData['type_sale']),
              url: toStringValue(businessData['url']),
              features: toStringValue(businessData['features']),
              facility: toStringValue(businessData['facility']),
              income_source: toStringValue(businessData['income_source']),
              reason: toStringValue(businessData['reason']),
              postedTime: businessData['postedTime'],
              topSelling: toStringValue(businessData['topSelling']),
              id: result.id,
              showEditOption: false,
            ),
          ),
        );
        break;

      case 'investor':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InvestorDetailPage(
              imageUrl: result.imageUrl,
              image2: toStringValue(result.rawData['image2']),
              image3: toStringValue(result.rawData['image3']),
              image4: toStringValue(result.rawData['image4']),
              name: result.name,
              city: result.location,
              postedTime: result.rawData['listed_on'],
              state: toStringValue(result.rawData['state']),
              industry: toStringValue(result.rawData['industry']),
              description: result.description,
              url: toStringValue(result.rawData['url']),
              rangeStarting: toStringValue(result.rawData['rangeStarting']),
              rangeEnding: toStringValue(result.rawData['rangeEnding']),
              evaluatingAspects:
                  toStringValue(result.rawData['evaluatingAspects']),
              CompanyName:
                  toStringValue(result.rawData['company'] ?? result.name),
              locationInterested:
                  toStringValue(result.rawData['locationIntrested']),
              id: result.id,
              showEditOption: false,
            ),
          ),
        );
        break;

      case 'franchise':
        final franchiseData = {
          ...result.rawData,
          'postedTime': formatDateTime(result.rawData['listed_on']),
          'currentNumberOfOutlets':
              toStringValue(result.rawData['currentNumberOfOutlets']),
          'spaceRequiredMin': toStringValue(result.rawData['spaceRequiredMin']),
          'spaceRequiredMax': toStringValue(result.rawData['spaceRequiredMax']),
          'totalInvestmentFrom':
              toStringValue(result.rawData['totalInvestmentFrom']),
          'totalInvestmentTo':
              toStringValue(result.rawData['totalInvestmentTo']),
          'brandFee': toStringValue(result.rawData['brandFee']),
          'avgNoOfStaff': toStringValue(result.rawData['avgNoOfStaff']),
          'avgMonthlySales': toStringValue(result.rawData['avgMonthlySales']),
          'avgEBITDA': toStringValue(result.rawData['avgEBITDA']),
          'brandStartOperation':
              toStringValue(result.rawData['brandStartOperation']),
        };

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FranchiseDetailPage(
              id: result.id,
              imageUrl: result.imageUrl,
              image2: toStringValue(franchiseData['image2']),
              image3: toStringValue(franchiseData['image3']),
              image4: toStringValue(franchiseData['image4']),
              brandName: result.name,
              city: result.location,
              postedTime: franchiseData['postedTime'],
              state: toStringValue(franchiseData['state']),
              industry: toStringValue(franchiseData['industry']),
              description: result.description,
              url: toStringValue(franchiseData['url']),
              initialInvestment:
                  toStringValue(franchiseData['initialInvestment']),
              projectedRoi: toStringValue(franchiseData['projectedRoi']),
              iamOffering: toStringValue(franchiseData['iamOffering']),
              currentNumberOfOutlets: franchiseData['currentNumberOfOutlets'],
              franchiseTerms: toStringValue(franchiseData['franchiseTerms']),
              locationsAvailable:
                  toStringValue(franchiseData['locationsAvailable']),
              kindOfSupport: toStringValue(franchiseData['kindOfSupport']),
              allProducts: toStringValue(franchiseData['allProducts']),
              brandStartOperation: franchiseData['brandStartOperation'],
              spaceRequiredMin: franchiseData['spaceRequiredMin'],
              spaceRequiredMax: franchiseData['spaceRequiredMax'],
              totalInvestmentFrom: franchiseData['totalInvestmentFrom'],
              totalInvestmentTo: franchiseData['totalInvestmentTo'],
              brandFee: franchiseData['brandFee'],
              avgNoOfStaff: franchiseData['avgNoOfStaff'],
              avgMonthlySales: franchiseData['avgMonthlySales'],
              avgEBITDA: franchiseData['avgEBITDA'],
              showEditOption: false,
            ),
          ),
        );
        break;

      case 'advisor':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdvisorDetailPage(
              // imageUrl: result.imageUrl,
              // name: result.name,
              // interest: toStringValue(result.rawData['interest']),
              // designation: result.rawData['designation'] ?? '',
              // contactNumber: result.rawData['contactNumber'] ?? '',
              // state: result.rawData['state'] ?? '',
              // url: result.rawData['url'] ?? '',
              // description: result.description,
              // location: result.location,
              // userId: result.rawData['user']?.toString() ?? '',
            ),
          ),
        );
        break;
    }
  }

  Widget _buildStyledChip(String label) {
    return GestureDetector(
      onTap: () {
        textController.text = label;
        search(label);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Chip(
          label: Text(
            label,
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          deleteIcon: const Icon(
            Icons.close,
            size: 18,
            color: Color(0xffFFCC00),
          ),
          onDeleted: () async {
            setState(() {
              recentSearches.remove(label);
            });
            final searches = await _searchServices.loadRecentSearches();
            searches.remove(label);
            await _searchServices.saveRecentSearch('', searches);
          },
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          visualDensity: VisualDensity.compact,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void showCustomBottomSheet(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: h * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Filters',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                city = '';
                                state = '';
                                industry = '';
                                entityType = '';
                                establishFrom = '';
                                establishTo = '';
                                rangeStarting = '';
                                rangeEnding = '';
                                filter = false;
                              });
                              Navigator.pop(context);
                              search(textController.text);
                            },
                            child: const Text(
                              'Remove',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            filter = true;
                            Navigator.pop(context);
                            search(textController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFFCC00),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Apply Filter',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      // Location Filter
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffFFCC00)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffFFCC00)),
                          ),
                        ),
                        value: city.isEmpty ? null : city,
                        items: const [
                          DropdownMenuItem(
                              value: 'New York', child: Text('New York')),
                          DropdownMenuItem(
                              value: 'Los Angeles', child: Text('Los Angeles')),
                          DropdownMenuItem(
                              value: 'Chicago', child: Text('Chicago')),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            city = newValue ?? '';
                          });
                        },
                      ),
                      const SizedBox(height: 25),
                      // Industry Filter
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Industry',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffFFCC00)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffFFCC00)),
                          ),
                        ),
                        value: industry.isEmpty ? null : industry,
                        items: const [
                          DropdownMenuItem(
                              value: 'Technology', child: Text('Technology')),
                          DropdownMenuItem(
                              value: 'Healthcare', child: Text('Healthcare')),
                          DropdownMenuItem(
                              value: 'Retail', child: Text('Retail')),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            industry = newValue ?? '';
                          });
                        },
                      ),
                      const SizedBox(height: 25),
                      // Business Type Filter
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Business Type',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffFFCC00)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffFFCC00)),
                          ),
                        ),
                        value: entityType.isEmpty ? null : entityType,
                        items: const [
                          DropdownMenuItem(
                              value: 'business', child: Text('Business')),
                          DropdownMenuItem(
                              value: 'investor', child: Text('Investor')),
                          DropdownMenuItem(
                              value: 'franchise', child: Text('Franchise')),
                          DropdownMenuItem(
                              value: 'advisor', child: Text('Advisor')),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            entityType = newValue ?? '';
                          });
                        },
                      ),
                      const SizedBox(height: 25),
                      // Investment Range
                      const Text(
                        'Investment Range',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Min Investment',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffFFCC00)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffFFCC00)),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  rangeStarting = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Max Investment',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffFFCC00)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffFFCC00)),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  rangeEnding = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      // Year Established Range
                      const Text(
                        'Year Established',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'From Year',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffFFCC00)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffFFCC00)),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  establishFrom = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'To Year',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffFFCC00)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffFFCC00)),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  establishTo = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _loadRecentResults() async {
    // Simulated data for testing
    setState(() {
      recentResults = [
        SearchResult(
          name: "Demo Business 1",
          description: "Description 1",
          imageUrl: "https://picsum.photos/200/300", // placeholder image
          location: "New York",
          type: "Business",
          id: "1",
          rawData: {},
        ),
        SearchResult(
          name: "Demo Business 2",
          description: "Description 2",
          imageUrl: "https://picsum.photos/200/301", // placeholder image
          location: "Los Angeles",
          type: "Business",
          id: "2",
          rawData: {},
        ),
        SearchResult(
          name: "Demo Business 3",
          description: "Description 3",
          imageUrl: "https://picsum.photos/200/302", // placeholder image
          location: "Chicago",
          type: "Business",
          id: "3",
          rawData: {},
        ),
      ];
    });
  }

  Widget _buildRecentResults() {
    if (recentResults.isEmpty || hasSearched) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Post',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Implement see all functionality
                },
                child: const Text(
                  'See all',
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        CarouselSlider.builder(
          itemCount: recentResults.length,
          itemBuilder: (context, index, realIndex) {
            final result = recentResults[index];
            return GestureDetector(
              onTap: () => _navigateToDetail(result),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(result.imageUrl),
                    fit: BoxFit.cover,
                    onError: (error, stackTrace) {
                      print('Error loading image: $error');
                    },
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 150.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    result.name,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: Colors.amber,
                                          size: 18.h
                                      ),
                                      const SizedBox(width: 5),
                                      Flexible(
                                        child: Text(
                                          result.location,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 270.h,
            viewportFraction: 0.65,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Center(
          child: Text(
            'Search',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  onChanged: _onTextChanged,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    filled: true,
                    fillColor: const Color(0xffF3F8FE),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (textController.text.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              textController.clear();
                              setState(() {
                                searchResults = [];
                                errorMessage = null;
                                hasSearched = false;
                              });
                            },
                          ),
                        CircleAvatar(
                          backgroundColor: const Color(0xffFFCC00),
                          child: IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: () => search(textController.text),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: const Color(0xffFFCC00),
                child: IconButton(
                  icon: const Icon(Icons.sort_sharp, color: Colors.white),
                  onPressed: () {
                    showCustomBottomSheet(context);
                  },
                ),
              ),
            ],
          ),
          // Previous Searches Section
          if (recentSearches.isNotEmpty && !hasSearched) ...[
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Previous Searches',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: _clearRecentSearches,
                      child: const Text(
                        'Clear All',
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: recentSearches
                      .map((search) => _buildStyledChip(search))
                      .toList(),
                ),
              ],
            ),
          ],

          // Recent Posts Section
          const SizedBox(height: 20),
          _buildRecentResults(),

          // Search Results or Loading/Error States
          if (isLoading)
            const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFFCC00)),
                  ),
                  SizedBox(height: 16),
                  Text('Searching...'),
                ],
              ),
            )
          else if (errorMessage != null && hasSearched)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search_off,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  if (filter) ...[
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          city = '';
                          state = '';
                          industry = '';
                          entityType = '';
                          establishFrom = '';
                          establishTo = '';
                          rangeStarting = '';
                          rangeEnding = '';
                          filter = false;
                        });
                        search(textController.text);
                      },
                      child: const Text(
                        'Clear filters and try again',
                        style: TextStyle(color: Color(0xffFFCC00)),
                      ),
                    ),
                  ],
                ],
              ),
            )
          else if (searchResults.isNotEmpty)
            Column(
              children: searchResults.map((result) {
                return GestureDetector(
                  onTap: () => _navigateToDetail(result),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            result.imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: const Icon(Icons.error),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                result.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: 16, color: Colors.grey[600]),
                                  const SizedBox(width: 4),
                                  Text(
                                    result.location,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                result.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xffFFCC00).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  result.type,
                                  style: const TextStyle(
                                    color: Color(0xffFFCC00),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
      floatingActionButton: recentSearches.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: 220,
                height: 40,
                child: FloatingActionButton(
                  onPressed: _clearRecentSearches,
                  backgroundColor: const Color(0xffFFCC00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.close, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Clear Search History',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    textController.dispose();
    super.dispose();
  }
}
