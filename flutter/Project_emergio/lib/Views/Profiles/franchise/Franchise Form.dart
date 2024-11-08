// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
// import '../../services/profile forms/franchise/franchise add.dart';
// import 'franchise listing page.dart';
//
// class FranchiseFormScreen extends StatefulWidget {
//   const FranchiseFormScreen({Key? key}) : super(key: key);
//
//   @override
//   State<FranchiseFormScreen> createState() => _FranchiseFormScreenState();
// }
//
// class _FranchiseFormScreenState extends State<FranchiseFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   final _brandNameController = TextEditingController();
//   String _selectedIndustry = 'Fashion';
//   final _businessWebsiteController = TextEditingController();
//   final _initialInvestmentController = TextEditingController();
//   final _projectedRoiController = TextEditingController();
//   String _iamOffering = 'offer 1';
//   final _currentNumberOfOutletsController = TextEditingController();
//   final _franchiseTermsController = TextEditingController();
//   final _aboutYourBrandController = TextEditingController();
//   final _locationsAvailableController = TextEditingController();
//   final _kindOfSupportController = TextEditingController();
//   final _allProductsController = TextEditingController();
//   final _brandStartOperationController = TextEditingController();
//   final _spaceRequiredMinController = TextEditingController();
//   final _spaceRequiredMaxController = TextEditingController();
//   final _totalInvestmentFromController = TextEditingController();
//   final _totalInvestmentToController = TextEditingController();
//   final _brandFeeController = TextEditingController();
//   final _avgNoOfStaffController = TextEditingController();
//   final _avgMonthlySalesController = TextEditingController();
//   final _avgEBITDAController = TextEditingController();
//
//   List<PlatformFile>? _brandLogo;
//   List<PlatformFile>? _businessPhotos;
//   List<PlatformFile>? _businessDocuments;
//   PlatformFile? _businessProof;
//
//   @override
//   void dispose() {
//     _brandNameController.dispose();
//     _businessWebsiteController.dispose();
//     _initialInvestmentController.dispose();
//     _projectedRoiController.dispose();
//     _currentNumberOfOutletsController.dispose();
//     _franchiseTermsController.dispose();
//     _aboutYourBrandController.dispose();
//     _locationsAvailableController.dispose();
//     _kindOfSupportController.dispose();
//     _allProductsController.dispose();
//     _brandStartOperationController.dispose();
//     _spaceRequiredMinController.dispose();
//     _spaceRequiredMaxController.dispose();
//     _totalInvestmentFromController.dispose();
//     _totalInvestmentToController.dispose();
//     _brandFeeController.dispose();
//     _avgNoOfStaffController.dispose();
//     _avgMonthlySalesController.dispose();
//     _avgEBITDAController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _pickBrandLogo() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: true);
//     if (result != null) {
//       setState(() {
//         _brandLogo = result.files;
//       });
//     }
//   }
//
//   Future<void> pickBusinessPhotos() async {
//     final result = await ImagePicker().pickMultiImage();
//     if (result != null) {
//       setState(() {
//         _businessPhotos = result;
//       });
//     }
//   }
//
//   Future<void> _pickBusinessDocuments() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: true);
//     if (result != null) {
//       setState(() {
//         _businessDocuments = result.files;
//       });
//     }
//   }
//
//   Future<void> _pickBusinessProof() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: false);
//     if (result != null) {
//       setState(() {
//         _businessProof = result.files.single;
//       });
//     }
//   }
//
//   InputDecoration _inputDecoration() {
//     return InputDecoration(
//       border: OutlineInputBorder(),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.grey),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.blue),
//       ),
//     );
//   }
//
//   Widget _buildHintText(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Text(
//         text,
//         style: TextStyle(fontWeight: FontWeight.w500),
//       ),
//     );
//   }
//
//   String? _validateName(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Brand Name is required';
//     }
//     final namePattern = r'^[a-zA-Z\s]+$';
//     final regex = RegExp(namePattern);
//     if (!regex.hasMatch(value)) {
//       return 'Only letters and spaces are allowed';
//     }
//     if (value.length > 50) {
//       return 'Name cannot exceed 50 characters';
//     }
//     return null;
//   }
//
//   String? _validateYear(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Year is required';
//     }
//     if (!RegExp(r'^\d{4}$').hasMatch(value)) {
//       return 'Year should be exactly 4 digits';
//     }
//     int year = int.parse(value);
//     int currentYear = DateTime.now().year;
//     if (year < 1800 || year > currentYear) {
//       return 'Please enter a valid year between 1800 and $currentYear';
//     }
//     return null;
//   }
//
//   String? _validateTextArea(String? value, String fieldName,
//       {int minLength = 50, int maxLength = 1000}) {
//     if (value == null || value.isEmpty) {
//       return '$fieldName is required';
//     }
//     if (value.length < minLength) {
//       return '$fieldName should be at least $minLength characters long';
//     }
//     if (value.length > maxLength) {
//       return '$fieldName should not exceed $maxLength characters';
//     }
//     return null;
//   }
//
//   String? _validateEmployees(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Number of Employees is required';
//     }
//     int? employees = int.tryParse(value);
//     if (employees == null || employees < 1) {
//       return 'Please enter a valid number of employees';
//     }
//     if (employees > 1000000) {
//       return 'Number of employees should not exceed 1,000,000';
//     }
//     return null;
//   }
//
//   String? _validateSales(String? value, String fieldName) {
//     if (value == null || value.isEmpty) {
//       return '$fieldName is required';
//     }
//     double? sales = double.tryParse(value);
//     if (sales == null || sales < 0) {
//       return 'Please enter a valid number for $fieldName';
//     }
//     if (sales > 1000000000000) {
//       return '$fieldName should not exceed 1 trillion';
//     }
//     return null;
//   }
//
//   String? _validateEbitda(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'EBITDA is required';
//     }
//     double? ebitda = double.tryParse(value);
//     if (ebitda == null) {
//       return 'Please enter a valid number for EBITDA';
//     }
//     if (ebitda < 0 || ebitda > 100) {
//       return 'EBITDA should be between 0 and 100';
//     }
//     return null;
//   }
//
//   String? _validateUrl(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Company Website URL is required';
//     }
//     final urlPattern =
//         r'^(https?:\/\/)?([\w-]+\.)+[\w-]{2,4}(\.[\w-]{2,4})?(\/[\w-]*)*\/?$';
//     if (!RegExp(urlPattern).hasMatch(value)) {
//       return 'Please enter a valid URL';
//     }
//     if (value.length > 200) {
//       return 'URL should not exceed 200 characters';
//     }
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_outlined),
//         ),
//       ),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Franchise Information',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w700, fontSize: h * 0.025),
//                 ),
//                 SizedBox(height: h * .03),
//                 _buildHintText('Brand Name'),
//                 TextFormField(
//                   controller: _brandNameController,
//                   decoration: _inputDecoration(),
//                   validator: _validateName,
//                 ),
//                 SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('Industry'),
//                           DropdownButtonFormField<String>(
//                             value: _selectedIndustry,
//                             onChanged: (value) {
//                               setState(() {
//                                 _selectedIndustry = value!;
//                               });
//                             },
//                             items: [
//                               'Education',
//                               'Information Technology',
//                               'Healthcare',
//                               'Fashion',
//                               'Food',
//                               'Automobile',
//                               'Banking'
//                             ]
//                                 .map((industry) => DropdownMenuItem(
//                                       value: industry,
//                                       child: Text(industry),
//                                     ))
//                                 .toList(),
//                             decoration: _inputDecoration(),
//                             validator: (value) => value == null || value.isEmpty
//                                 ? 'Industry is required'
//                                 : null,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 _buildHintText('Business Website URL'),
//                 TextFormField(
//                   controller: _businessWebsiteController,
//                   decoration: _inputDecoration(),
//                   validator: _validateUrl,
//                 ),
//                 SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('Initial Investment'),
//                           TextFormField(
//                             controller: _initialInvestmentController,
//                             keyboardType: TextInputType.number,
//                             decoration: _inputDecoration(),
//                             validator: (value) =>
//                                 _validateSales(value, 'Initial Investment'),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 16.0),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('Projected ROI'),
//                           TextFormField(
//                             controller: _projectedRoiController,
//                             keyboardType: TextInputType.number,
//                             decoration: _inputDecoration(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Projected ROI is required';
//                               }
//                               double? roi = double.tryParse(value);
//                               if (roi == null || roi < 0 || roi > 100) {
//                                 return 'Projected ROI should be between 0 and 100';
//                               }
//                               return null;
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('I am offering'),
//                           DropdownButtonFormField<String>(
//                             value: _iamOffering,
//                             onChanged: (value) {
//                               setState(() {
//                                 _iamOffering = value!;
//                               });
//                             },
//                             items: ['offer 1', 'offer 2', 'offer 3']
//                                 .map((industry) => DropdownMenuItem(
//                                       value: industry,
//                                       child: Text(industry),
//                                     ))
//                                 .toList(),
//                             decoration: _inputDecoration(),
//                             validator: (value) => value == null || value.isEmpty
//                                 ? 'Offering is required'
//                                 : null,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('Current number of\noutlets'),
//                           TextFormField(
//                             controller: _currentNumberOfOutletsController,
//                             keyboardType: TextInputType.number,
//                             decoration: _inputDecoration(),
//                             validator: _validateEmployees,
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 16.0),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('Franchise terms\n(Year period)'),
//                           TextFormField(
//                             controller: _franchiseTermsController,
//                             keyboardType: TextInputType.number,
//                             decoration: _inputDecoration(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Franchise terms are required';
//                               }
//                               int? terms = int.tryParse(value);
//                               if (terms == null || terms <= 0) {
//                                 return 'Please enter a valid number of years';
//                               }
//                               if (terms > 100) {
//                                 return 'Franchise terms should not exceed 100 years';
//                               }
//                               return null;
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 _buildHintText('About your brand'),
//                 TextFormField(
//                   controller: _aboutYourBrandController,
//                   maxLines: 4,
//                   decoration: _inputDecoration(),
//                   validator: (value) =>
//                       _validateTextArea(value, 'About your brand'),
//                 ),
//                 SizedBox(height: 16.0),
//                 _buildHintText('Locations available for franchises'),
//                 TextFormField(
//                   controller: _locationsAvailableController,
//                   maxLines: null,
//                   decoration: _inputDecoration(),
//                   validator: (value) => _validateTextArea(
//                       value, 'Locations available',
//                       minLength: 10, maxLength: 500),
//                 ),
//                 SizedBox(height: 16.0),
//                 _buildHintText(
//                     'What kind of support can the franchisee expect from you?'),
//                 TextFormField(
//                   controller: _kindOfSupportController,
//                   maxLines: 4,
//                   decoration: _inputDecoration(),
//                   validator: (value) =>
//                       _validateTextArea(value, 'Kind of support'),
//                 ),
//                 SizedBox(height: 16.0),
//                 _buildHintText(
//                     'Mention all products/services your brand provides'),
//                 TextFormField(
//                   controller: _allProductsController,
//                   maxLines: 4,
//                   decoration: _inputDecoration(),
//                   validator: (value) => _validateTextArea(
//                       value, 'Products/services',
//                       minLength: 10, maxLength: 500),
//                 ),
//                 SizedBox(height: 16.0),
//                 _buildHintText('When did your brand start operations?'),
//                 TextFormField(
//                   controller: _brandStartOperationController,
//                   decoration: _inputDecoration(),
//                   validator: _validateYear,
//                 ),
//                 SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('Space Required\n(min)'),
//                           TextFormField(
//                             controller: _spaceRequiredMinController,
//                             keyboardType: TextInputType.number,
//                             decoration: _inputDecoration(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Minimum space is required';
//                               }
//                               int? space = int.tryParse(value);
//                               if (space == null || space <= 0) {
//                                 return 'Please enter a valid space requirement';
//                               }
//                               if (space > 1000000) {
//                                 return 'Minimum space should not exceed 1,000,000 sq ft';
//                               }
//                               return null;
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 16.0),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('(max)'),
//                           TextFormField(
//                             controller: _spaceRequiredMaxController,
//                             keyboardType: TextInputType.number,
//                             decoration: _inputDecoration(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Maximum space is required';
//                               }
//                               int? space = int.tryParse(value);
//                               if (space == null || space <= 0) {
//                                 return 'Please enter a valid space requirement';
//                               }
//                               if (space > 1000000) {
//                                 return 'Maximum space should not exceed 1,000,000 sq ft';
//                               }
//                               return null;
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('Total Investment Needed\n(INR)'),
//                           TextFormField(
//                             controller: _totalInvestmentFromController,
//                             keyboardType: TextInputType.number,
//                             decoration: _inputDecoration(),
//                             validator: (value) =>
//                                 _validateSales(value, 'Minimum investment'),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 16.0),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('(TO)'),
//                           TextFormField(
//                             controller: _totalInvestmentToController,
//                             keyboardType: TextInputType.number,
//                             decoration: _inputDecoration(),
//                             validator: (value) =>
//                                 _validateSales(value, 'Maximum investment'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('\nBrand fee'),
//                           TextFormField(
//                             controller: _brandFeeController,
//                             keyboardType: TextInputType.number,
//                             decoration: _inputDecoration(),
//                             validator: (value) =>
//                                 _validateSales(value, 'Brand fee'),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 16.0),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('Average number of staff required'),
//                           TextFormField(
//                             controller: _avgNoOfStaffController,
//                             keyboardType: TextInputType.number,
//                             decoration: _inputDecoration(),
//                             validator: _validateEmployees,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText(
//                               'Average Monthly Sales per franchisee'),
//                           TextFormField(
//                             controller: _avgMonthlySalesController,
//                             keyboardType: TextInputType.number,
//                             decoration: _inputDecoration(),
//                             validator: (value) =>
//                                 _validateSales(value, 'Average Monthly Sales'),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 16.0),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('Average EBITDA per franchise'),
//                           TextFormField(
//                             controller: _avgEBITDAController,
//                             keyboardType: TextInputType.number,
//                             decoration: _inputDecoration(),
//                             validator: _validateEbitda,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 Text(
//                   'Photos, Documents & Proof',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 8.0),
//                 Text(
//                   'Please provide the names of documents for verification purposes. These names will be publicly visible but will only be accessible to introduced members.',
//                   style: TextStyle(fontSize: 12.0),
//                 ),
//                 SizedBox(height: 16.0),
//                 Center(
//                   child: Container(
//                     height: 200,
//                     width: 360,
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black26)),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         _buildFileUploadRow(
//                             'Brand Logo', _pickBrandLogo, _brandLogo),
//                         _buildFileUploadRow('Business Photos',
//                             _pickBusinessPhotos, _businessPhotos),
//                         _buildFileUploadRow(
//                             'Business Proof',
//                             _pickBusinessProof,
//                             _businessProof != null ? [_businessProof!] : null),
//                         _buildFileUploadRow('Brochures and\ndocuments',
//                             _pickBusinessDocuments, _businessDocuments),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 32.0),
//                 SizedBox(
//                   height: 50,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                       backgroundColor: Color(0xff003C82),
//                     ),
//                     onPressed: () {
//                       _submitForm();
//                     },
//                     child: Text(
//                       'Verify Business',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 32.0),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFileUploadRow(
//       String label, VoidCallback onPressed, List<PlatformFile>? files) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(label),
//         SizedBox(width: MediaQuery.of(context).size.width * 0.17),
//         ElevatedButton(
//           onPressed: onPressed,
//           child: Text('Upload file'),
//           style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(2),
//               side: BorderSide(color: Colors.black),
//             ),
//           ),
//         ),
//         if (files != null && files.isNotEmpty)
//           Expanded(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: files.map((file) {
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: file.extension?.toLowerCase() == 'pdf'
//                         ? Icon(Icons.picture_as_pdf, color: Colors.red)
//                         : Image.file(
//                             File(file.path!),
//                             width: 50,
//                             height: 40,
//                             fit: BoxFit.cover,
//                           ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       if (_brandLogo == null || _businessProof == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text('Please select brand logo and business proof')),
//         );
//         return;
//       }
//
//       var success = await FranchiseAddPage.franchiseAddPage(
//         brandName: _brandNameController.text,
//         industry: _selectedIndustry,
//         businessWebsite: _businessWebsiteController.text,
//         initialInvestment: _initialInvestmentController.text,
//         projectedRoi: _projectedRoiController.text,
//         iamOffering: _iamOffering,
//         currentNumberOfOutlets: _currentNumberOfOutletsController.text,
//         franchiseTerms: _franchiseTermsController.text,
//         aboutYourBrand: _aboutYourBrandController.text,
//         locationsAvailable: _locationsAvailableController.text,
//         kindOfSupport: _kindOfSupportController.text,
//         allProducts: _allProductsController.text,
//         brandStartOperation: _brandStartOperationController.text,
//         spaceRequiredMin: _spaceRequiredMinController.text,
//         spaceRequiredMax: _spaceRequiredMaxController.text,
//         totalInvestmentFrom: _totalInvestmentFromController.text,
//         totalInvestmentTo: _totalInvestmentToController.text,
//         brandFee: _brandFeeController.text,
//         avgNoOfStaff: _avgNoOfStaffController.text,
//         avgMonthlySales: _avgMonthlySalesController.text,
//         avgEBITDA: _avgEBITDAController.text,
//         brandLogo: File(_brandLogo!.first.path!),
//         businessPhoto: File(_businessPhotos![0].path!),
//         image2: File(_businessPhotos![1].path!),
//         image3: File(_businessPhotos![2].path!),
//         image4: File(_businessPhotos![3].path!),
//         businessDocuments: _businessDocuments?.map((file) => File(file.path!)).toList() ?? [],
//         businessProof: File(_businessProof!.path!),
//       );
//
//       if (success == true) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Form submitted successfully!')),
//         );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => FranchiseListingsScreen(),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to submit form. Please try again.')),
//         );
//       }
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../../services/profile forms/franchise/franchise add.dart';
import 'franchise listing page.dart';

class FranchiseFormScreen extends StatefulWidget {
  const FranchiseFormScreen({Key? key}) : super(key: key);

  @override
  State<FranchiseFormScreen> createState() => _FranchiseFormScreenState();
}

class _FranchiseFormScreenState extends State<FranchiseFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _brandNameController = TextEditingController();
  String _selectedIndustry = 'Fashion';
  final _businessWebsiteController = TextEditingController();
  final _initialInvestmentController = TextEditingController();
  final _projectedRoiController = TextEditingController();
  String _iamOffering = 'offer 1';
  final _currentNumberOfOutletsController = TextEditingController();
  final _franchiseTermsController = TextEditingController();
  final _aboutYourBrandController = TextEditingController();
  final _locationsAvailableController = TextEditingController();
  final _kindOfSupportController = TextEditingController();
  final _allProductsController = TextEditingController();
  final _brandStartOperationController = TextEditingController();
  final _spaceRequiredMinController = TextEditingController();
  final _spaceRequiredMaxController = TextEditingController();
  final _totalInvestmentFromController = TextEditingController();
  final _totalInvestmentToController = TextEditingController();
  final _brandFeeController = TextEditingController();
  final _avgNoOfStaffController = TextEditingController();
  final _avgMonthlySalesController = TextEditingController();
  final _avgEBITDAController = TextEditingController();

  List<PlatformFile>? _brandLogo;
  List<XFile>? _businessPhotos;
  List<PlatformFile>? _businessDocuments;
  PlatformFile? _businessProof;

  @override
  void dispose() {
    _brandNameController.dispose();
    _businessWebsiteController.dispose();
    _initialInvestmentController.dispose();
    _projectedRoiController.dispose();
    _currentNumberOfOutletsController.dispose();
    _franchiseTermsController.dispose();
    _aboutYourBrandController.dispose();
    _locationsAvailableController.dispose();
    _kindOfSupportController.dispose();
    _allProductsController.dispose();
    _brandStartOperationController.dispose();
    _spaceRequiredMinController.dispose();
    _spaceRequiredMaxController.dispose();
    _totalInvestmentFromController.dispose();
    _totalInvestmentToController.dispose();
    _brandFeeController.dispose();
    _avgNoOfStaffController.dispose();
    _avgMonthlySalesController.dispose();
    _avgEBITDAController.dispose();
    super.dispose();
  }

  Future<void> _pickBrandLogo() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _brandLogo = result.files;
      });
    }
  }

  Future<void> _pickBusinessPhotos() async {
    final result = await ImagePicker().pickMultiImage();
    if (result != null) {
      setState(() {
        _businessPhotos = result;
      });
    }
  }

  Future<void> _pickBusinessDocuments() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _businessDocuments = result.files;
      });
    }
  }

  Future<void> _pickBusinessProof() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      setState(() {
        _businessProof = result.files.single;
      });
    }
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
    );
  }

  Widget _buildHintText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Brand Name is required';
    }
    final namePattern = r'^[a-zA-Z\s]+$';
    final regex = RegExp(namePattern);
    if (!regex.hasMatch(value)) {
      return 'Only letters and spaces are allowed';
    }
    if (value.length > 50) {
      return 'Name cannot exceed 50 characters';
    }
    return null;
  }

  String? _validateYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'Year is required';
    }
    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'Year should be exactly 4 digits';
    }
    int year = int.parse(value);
    int currentYear = DateTime.now().year;
    if (year < 1800 || year > currentYear) {
      return 'Please enter a valid year between 1800 and $currentYear';
    }
    return null;
  }

  String? _validateTextArea(String? value, String fieldName,
      {int minLength = 50, int maxLength = 1000}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (value.length < minLength) {
      return '$fieldName should be at least $minLength characters long';
    }
    if (value.length > maxLength) {
      return '$fieldName should not exceed $maxLength characters';
    }
    return null;
  }

  String? _validateEmployees(String? value) {
    if (value == null || value.isEmpty) {
      return 'Number of Employees is required';
    }
    int? employees = int.tryParse(value);
    if (employees == null || employees < 1) {
      return 'Please enter a valid number of employees';
    }
    if (employees > 1000000) {
      return 'Number of employees should not exceed 1,000,000';
    }
    return null;
  }

  String? _validateSales(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    double? sales = double.tryParse(value);
    if (sales == null || sales < 0) {
      return 'Please enter a valid number for $fieldName';
    }
    if (sales > 1000000000000) {
      return '$fieldName should not exceed 1 trillion';
    }
    return null;
  }

  String? _validateEbitda(String? value) {
    if (value == null || value.isEmpty) {
      return 'EBITDA is required';
    }
    double? ebitda = double.tryParse(value);
    if (ebitda == null) {
      return 'Please enter a valid number for EBITDA';
    }
    if (ebitda < 0 || ebitda > 100) {
      return 'EBITDA should be between 0 and 100';
    }
    return null;
  }

  String? _validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'Company Website URL is required';
    }
    final urlPattern =
        r'^(https?:\/\/)?([\w-]+\.)+[\w-]{2,4}(\.[\w-]{2,4})?(\/[\w-]*)*\/?$';
    if (!RegExp(urlPattern).hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    if (value.length > 200) {
      return 'URL should not exceed 200 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Franchise Information',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: h * 0.025),
                ),
                SizedBox(height: h * .03),
                _buildHintText('Brand Name'),
                TextFormField(
                  controller: _brandNameController,
                  decoration: _inputDecoration(),
                  validator: _validateName,
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('Industry'),
                          DropdownButtonFormField<String>(
                            value: _selectedIndustry,
                            onChanged: (value) {
                              setState(() {
                                _selectedIndustry = value!;
                              });
                            },
                            items: [
                              'Education',
                              'Information Technology',
                              'Healthcare',
                              'Fashion',
                              'Food',
                              'Automobile',
                              'Banking'
                            ]
                                .map((industry) => DropdownMenuItem(
                                      value: industry,
                                      child: Text(industry),
                                    ))
                                .toList(),
                            decoration: _inputDecoration(),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Industry is required'
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                _buildHintText('Business Website URL'),
                TextFormField(
                  controller: _businessWebsiteController,
                  decoration: _inputDecoration(),
                  validator: _validateUrl,
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('Initial Investment'),
                          TextFormField(
                            controller: _initialInvestmentController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration(),
                            validator: (value) =>
                                _validateSales(value, 'Initial Investment'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('Projected ROI'),
                          TextFormField(
                            controller: _projectedRoiController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Projected ROI is required';
                              }
                              double? roi = double.tryParse(value);
                              if (roi == null || roi < 0 || roi > 100) {
                                return 'Projected ROI should be between 0 and 100';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('I am offering'),
                          DropdownButtonFormField<String>(
                            value: _iamOffering,
                            onChanged: (value) {
                              setState(() {
                                _iamOffering = value!;
                              });
                            },
                            items: ['offer 1', 'offer 2', 'offer 3']
                                .map((industry) => DropdownMenuItem(
                                      value: industry,
                                      child: Text(industry),
                                    ))
                                .toList(),
                            decoration: _inputDecoration(),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Offering is required'
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('Current number of\noutlets'),
                          TextFormField(
                            controller: _currentNumberOfOutletsController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration(),
                            validator: _validateEmployees,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('Franchise terms\n(Year period)'),
                          TextFormField(
                            controller: _franchiseTermsController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Franchise terms are required';
                              }
                              int? terms = int.tryParse(value);
                              if (terms == null || terms <= 0) {
                                return 'Please enter a valid number of years';
                              }
                              if (terms > 100) {
                                return 'Franchise terms should not exceed 100 years';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                _buildHintText('About your brand'),
                TextFormField(
                  controller: _aboutYourBrandController,
                  maxLines: 4,
                  decoration: _inputDecoration(),
                  validator: (value) =>
                      _validateTextArea(value, 'About your brand'),
                ),
                SizedBox(height: 16.0),
                _buildHintText('Locations available for franchises'),
                TextFormField(
                  controller: _locationsAvailableController,
                  maxLines: null,
                  decoration: _inputDecoration(),
                  validator: (value) => _validateTextArea(
                      value, 'Locations available',
                      minLength: 10, maxLength: 500),
                ),
                SizedBox(height: 16.0),
                _buildHintText(
                    'What kind of support can the franchisee expect from you?'),
                TextFormField(
                  controller: _kindOfSupportController,
                  maxLines: 4,
                  decoration: _inputDecoration(),
                  validator: (value) =>
                      _validateTextArea(value, 'Kind of support'),
                ),
                SizedBox(height: 16.0),
                _buildHintText(
                    'Mention all products/services your brand provides'),
                TextFormField(
                  controller: _allProductsController,
                  maxLines: 4,
                  decoration: _inputDecoration(),
                  validator: (value) => _validateTextArea(
                      value, 'Products/services',
                      minLength: 10, maxLength: 500),
                ),
                SizedBox(height: 16.0),
                _buildHintText('When did your brand start operations?'),
                TextFormField(
                  controller: _brandStartOperationController,
                  decoration: _inputDecoration(),
                  validator: _validateYear,
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('Space Required\n(min)'),
                          TextFormField(
                            controller: _spaceRequiredMinController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Minimum space is required';
                              }
                              int? space = int.tryParse(value);
                              if (space == null || space <= 0) {
                                return 'Please enter a valid space requirement';
                              }
                              if (space > 1000000) {
                                return 'Minimum space should not exceed 1,000,000 sq ft';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('(max)'),
                          TextFormField(
                            controller: _spaceRequiredMaxController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Maximum space is required';
                              }
                              int? space = int.tryParse(value);
                              if (space == null || space <= 0) {
                                return 'Please enter a valid space requirement';
                              }
                              if (space > 1000000) {
                                return 'Maximum space should not exceed 1,000,000 sq ft';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('Total Investment Needed\n(INR)'),
                          TextFormField(
                            controller: _totalInvestmentFromController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration(),
                            validator: (value) =>
                                _validateSales(value, 'Minimum investment'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('(TO)'),
                          TextFormField(
                            controller: _totalInvestmentToController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration(),
                            validator: (value) =>
                                _validateSales(value, 'Maximum investment'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('\nBrand fee'),
                          TextFormField(
                            controller: _brandFeeController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration(),
                            validator: (value) =>
                                _validateSales(value, 'Brand fee'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('Average number of staff required'),
                          TextFormField(
                            controller: _avgNoOfStaffController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration(),
                            validator: _validateEmployees,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText(
                              'Average Monthly Sales per franchisee'),
                          TextFormField(
                            controller: _avgMonthlySalesController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration(),
                            validator: (value) =>
                                _validateSales(value, 'Average Monthly Sales'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('Average EBITDA per franchise'),
                          TextFormField(
                            controller: _avgEBITDAController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration(),
                            validator: _validateEbitda,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Photos, Documents & Proof',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Please provide the names of documents for verification purposes. These names will be publicly visible but will only be accessible to introduced members.',
                  style: TextStyle(fontSize: 12.0),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: Container(
                    height: 200,
                    width: 360,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFileUploadRow(
                            'Brand Logo', _pickBrandLogo, _brandLogo),
                        _buildFileUploadRow('Business Photos',
                            _pickBusinessPhotos, _businessPhotos),
                        _buildFileUploadRow(
                            'Business Proof',
                            _pickBusinessProof,
                            _businessProof != null ? [_businessProof!] : null),
                        _buildFileUploadRow('Brochures and\ndocuments',
                            _pickBusinessDocuments, _businessDocuments),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32.0),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Color(0xff003C82),
                    ),
                    onPressed: () {
                      _submitForm();
                    },
                    child: Text(
                      'Verify Business',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileUploadRow(
      String label, VoidCallback onPressed, List<dynamic>? files) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        SizedBox(width: MediaQuery.of(context).size.width * 0.17),
        ElevatedButton(
          onPressed: onPressed,
          child: Text('Upload file'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
              side: BorderSide(color: Colors.black),
            ),
          ),
        ),
        if (files != null && files.isNotEmpty)
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: files.map((file) {
                  if (file is PlatformFile) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: file.extension?.toLowerCase() == 'pdf'
                          ? Icon(Icons.picture_as_pdf, color: Colors.red)
                          : Image.file(
                              File(file.path!),
                              width: 50,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                    );
                  } else if (file is XFile) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.file(
                        File(file.path),
                        width: 50,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    );
                  }
                  return SizedBox(); // Return an empty widget if the file type is unknown
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_brandLogo == null || _businessProof == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Please select brand logo and business proof')),
        );
        return;
      }

      if (_businessPhotos == null || _businessPhotos!.length < 4) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select at least 4 business photos')),
        );
        return;
      }

      var success = await FranchiseAddPage.franchiseAddPage(
        brandName: _brandNameController.text,
        industry: _selectedIndustry,
        businessWebsite: _businessWebsiteController.text,
        initialInvestment: _initialInvestmentController.text,
        projectedRoi: _projectedRoiController.text,
        iamOffering: _iamOffering,
        currentNumberOfOutlets: _currentNumberOfOutletsController.text,
        franchiseTerms: _franchiseTermsController.text,
        aboutYourBrand: _aboutYourBrandController.text,
        locationsAvailable: _locationsAvailableController.text,
        kindOfSupport: _kindOfSupportController.text,
        allProducts: _allProductsController.text,
        brandStartOperation: _brandStartOperationController.text,
        spaceRequiredMin: _spaceRequiredMinController.text,
        spaceRequiredMax: _spaceRequiredMaxController.text,
        totalInvestmentFrom: _totalInvestmentFromController.text,
        totalInvestmentTo: _totalInvestmentToController.text,
        brandFee: _brandFeeController.text,
        avgNoOfStaff: _avgNoOfStaffController.text,
        avgMonthlySales: _avgMonthlySalesController.text,
        avgEBITDA: _avgEBITDAController.text,
        brandLogo: File(_brandLogo!.first.path!),
        businessPhoto: File(_businessPhotos![0].path),
        image2: File(_businessPhotos![1].path),
        image3: File(_businessPhotos![2].path),
        image4: File(_businessPhotos![3].path),
        businessDocuments:
            _businessDocuments?.map((file) => File(file.path!)).toList() ?? [],
        businessProof: File(_businessProof!.path!),
      );

      if (success == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Form submitted successfully!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FranchiseListingsScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit form. Please try again.')),
        );
      }
    }
  }
}
