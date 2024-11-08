// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:project_emergio/Views/Profiles/business%20listing%20page.dart';
// import 'package:project_emergio/services/profile%20forms/business/BusinessAddPage.dart';
//
// class BusinessInfoPage extends StatefulWidget {
//   const BusinessInfoPage({Key? key}) : super(key: key);
//
//   @override
//   _BusinessInfoPageState createState() => _BusinessInfoPageState();
// }
//
// class _BusinessInfoPageState extends State<BusinessInfoPage> {
//   final _formKey = GlobalKey<FormState>();
//   final Map<String, TextEditingController> _controllers = {
//     'businessName': TextEditingController(),
//     'yearEstablished': TextEditingController(),
//     'description': TextEditingController(),
//     'address1': TextEditingController(),
//     'pin': TextEditingController(),
//     'address2': TextEditingController(),
//     'numberOfEmployees': TextEditingController(),
//     'averageMonthlySales': TextEditingController(),
//     'askingPrice': TextEditingController(),
//     'mostReportedYearlySales': TextEditingController(),
//     'ebitda': TextEditingController(),
//     'preferredType': TextEditingController(),
//     'businessWebsite': TextEditingController(),
//     'topOfferings': TextEditingController(),
//     'keyFeatures': TextEditingController(),
//     'facilityDetails': TextEditingController(),
//     'fundingDetails': TextEditingController(),
//     'reason': TextEditingController(),
//   };
//
//   String _selectedIndustry = 'Fashion';
//   String _selectedState = 'Kerala';
//   String _selectedCity = 'Kakkanad';
//   String _selectedBusinessEntityType = 'Entity Type 1';
//   List<PlatformFile>? _businessPhotos;
//   List<PlatformFile>? _businessDocuments;
//   PlatformFile? _businessProof;
//   bool _isSubmitting = false;
//
//   final List<Map<String, String>> _industries = [
//     {'value': 'Education', 'display': 'Education'},
//     {'value': 'Information Technology', 'display': 'IT'},
//     {'value': 'Healthcare', 'display': 'Healthcare'},
//     {'value': 'Fashion', 'display': 'Fashion'},
//     {'value': 'Food', 'display': 'Food'},
//     {'value': 'Automobile', 'display': 'Automobile'},
//     {'value': 'Banking', 'display': 'Banking'},
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _controllers['preferredType']!.text = 'Selling';
//   }
//
//   @override
//   void dispose() {
//     _controllers.forEach((_, controller) => controller.dispose());
//     super.dispose();
//   }
//
//   String? _validateUrl(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Company Website URL is required';
//     }
//     final urlPattern =
//         r'^(https?:\/\/)?([\w-]+\.)+[\w-]{2,4}(\.[\w-]{2,4})?(\/[\w-]*)*\/?$';
//     return RegExp(urlPattern).hasMatch(value)
//         ? null
//         : 'Please enter a valid URL';
//   }
//
//   Future<void> _pickFile(void Function(List<PlatformFile>?) setter,
//       {bool allowMultiple = true}) async {
//     final result =
//         await FilePicker.platform.pickFiles(allowMultiple: allowMultiple);
//     if (result != null) {
//       setState(
//           () => setter(allowMultiple ? result.files : [result.files.first]));
//     }
//   }
//
//   InputDecoration _inputDecoration() {
//     return InputDecoration(
//       border: OutlineInputBorder(),
//       enabledBorder:
//           OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//       focusedBorder:
//           OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
//       errorBorder:
//           OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
//       focusedErrorBorder:
//           OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
//     );
//   }
//
//   Widget _buildHintText(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Text(text, style: TextStyle(fontWeight: FontWeight.w500)),
//     );
//   }
//
//   Widget _buildTextFormField(String key,
//       {String? Function(String?)? validator,
//       int? maxLines,
//       TextInputType? keyboardType}) {
//     return TextFormField(
//       controller: _controllers[key],
//       decoration: _inputDecoration(),
//       validator: validator ??
//           (value) => value!.isEmpty ? 'This field is required' : null,
//       maxLines: maxLines,
//       keyboardType: keyboardType,
//     );
//   }
//
//   Widget _buildDropdownFormField(
//       String value, List<String> items, void Function(String?) onChanged) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       onChanged: onChanged,
//       items: items
//           .map((item) => DropdownMenuItem(
//               value: item, child: Text(item, style: TextStyle(fontSize: 12))))
//           .toList(),
//       decoration: _inputDecoration(),
//       validator: (value) =>
//           value == null || value.isEmpty ? 'Please select an option' : null,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(Icons.arrow_back_outlined),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Business Information',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w700, fontSize: h * 0.025)),
//                 SizedBox(height: h * .03),
//                 _buildHintText('Business Name'),
//                 _buildTextFormField('businessName'),
//                 SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('Industry'),
//                           _buildDropdownFormField(
//                               _selectedIndustry,
//                               _industries.map((i) => i['value']!).toList(),
//                               (value) =>
//                                   setState(() => _selectedIndustry = value!)),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 16.0),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('Year Established'),
//                           _buildTextFormField(
//                             'yearEstablished',
//                             keyboardType: TextInputType.number,
//                             validator: (value) {
//                               if (value == null || value.isEmpty)
//                                 return 'Please enter the year';
//                               if (int.tryParse(value) == null)
//                                 return 'Please enter a valid year';
//                               return null;
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 _buildHintText('Description of the Business'),
//                 _buildTextFormField('description', maxLines: null),
//                 SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('State'),
//                           _buildDropdownFormField(
//                               _selectedState,
//                               [
//                                 'Andhra Pradesh',
//                                 'Arunachal Pradesh',
//                                 'Assam',
//                                 'Bihar',
//                                 'Chhattisgarh',
//                                 'Goa',
//                                 'Gujarat',
//                                 'Haryana',
//                                 'Himachal Pradesh',
//                                 'Jharkhand',
//                                 'Karnataka',
//                                 'Kerala',
//                                 'Madhya Pradesh',
//                                 'Maharashtra',
//                                 'Manipur',
//                                 'Meghalaya',
//                                 'Mizoram',
//                                 'Nagaland',
//                                 'Odisha',
//                                 'Punjab',
//                                 'Rajasthan',
//                                 'Sikkim',
//                                 'Tamil Nadu',
//                                 'Telangana',
//                                 'Tripura',
//                                 'Uttar Pradesh',
//                                 'Uttarakhand',
//                                 'West Bengal'
//                               ],
//                               (value) =>
//                                   setState(() => _selectedState = value!)),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 16.0),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('City'),
//                           _buildDropdownFormField(
//                               _selectedCity,
//                               ['Kochi', 'Kakkanad', 'Palarivattom'],
//                               (value) =>
//                                   setState(() => _selectedCity = value!)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 _buildHintText('Pin Code'),
//                 _buildTextFormField(
//                   'pin',
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty)
//                       return 'Please enter a pin code';
//                     if (value.length != 6 || int.tryParse(value) == null)
//                       return 'Please enter a valid 6-digit pin code';
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 _buildHintText('Address 1'),
//                 _buildTextFormField('address1'),
//                 SizedBox(height: 16.0),
//                 _buildHintText('Address 2'),
//                 _buildTextFormField('address2', validator: null),
//                 SizedBox(height: 16.0),
//                 _buildHintText('Number of Employees'),
//                 _buildTextFormField(
//                   'numberOfEmployees',
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty)
//                       return 'Please enter the number of employees';
//                     if (int.tryParse(value) == null)
//                       return 'Please enter a valid number';
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 _buildHintText('Business Legal Entity Type'),
//                 _buildDropdownFormField(
//                     _selectedBusinessEntityType,
//                     ['Entity Type 1', 'Entity Type 2', 'Entity Type 3'],
//                     (value) =>
//                         setState(() => _selectedBusinessEntityType = value!)),
//                 SizedBox(height: 16.0),
//                 _buildHintText(
//                     'What is your average monthly sales figure at the moment?'),
//                 _buildTextFormField(
//                   'averageMonthlySales',
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty)
//                       return 'Please enter the average monthly sales';
//                     if (double.tryParse(value) == null)
//                       return 'Please enter a valid number';
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 _buildHintText('What was your most reported yearly sales?'),
//                 _buildTextFormField(
//                   'mostReportedYearlySales',
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty)
//                       return 'Please enter the most reported yearly sales';
//                     if (double.tryParse(value) == null)
//                       return 'Please enter a valid number';
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 _buildHintText('EBITDA / Operating Profit Margin Percentage'),
//                 _buildTextFormField(
//                   'ebitda',
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty)
//                       return 'Please enter the EBITDA percentage';
//                     if (double.tryParse(value) == null)
//                       return 'Please enter a valid number';
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildHintText('Asking Price'),
//                           _buildTextFormField(
//                             'askingPrice',
//                             keyboardType: TextInputType.number,
//                             validator: (value) {
//                               if (value == null || value.isEmpty)
//                                 return 'Please enter the asking price';
//                               if (double.tryParse(value) == null)
//                                 return 'Please enter a valid number';
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
//                           _buildHintText('Preferred Type of Selling'),
//                           _buildDropdownFormField(
//                               _controllers['preferredType']!.text,
//                               ['Franchise', 'Investment', 'Selling'],
//                               (value) => setState(() =>
//                                   _controllers['preferredType']!.text =
//                                       value!)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 _buildHintText('Business Website URL'),
//                 _buildTextFormField('businessWebsite', validator: _validateUrl),
//                 SizedBox(height: 16.0),
//                 _buildHintText(
//                     'What are the top selling offerings of the company, who are the customers?'),
//                 _buildTextFormField('topOfferings', maxLines: 4),
//                 SizedBox(height: 16.0),
//                 _buildHintText(
//                     'Outline the business\'s key features, including its client base, revenue structure, founder background, industry competition, revenues, etc.'),
//                 _buildTextFormField('keyFeatures', maxLines: 4),
//                 SizedBox(height: 16.0),
//                 _buildHintText(
//                     'Provide details about your facility, like its total floor area, number of levels, and leasing terms.'),
//                 _buildTextFormField('facilityDetails', maxLines: 4),
//                 SizedBox(height: 16.0),
//                 _buildHintText('What is the reason for selling this business'),
//                 _buildTextFormField('reason', maxLines: 4),
//                 SizedBox(height: 16.0),
//                 _buildHintText(
//                     'Detail the current funding sources for the business, including any outstanding debts or loans, as well as the total count of shareholders or owners, specifying their ownership percentages.'),
//                 _buildTextFormField('fundingDetails', maxLines: 4),
//                 SizedBox(height: 16.0),
//                 Text('Photos, Documents & Proof',
//                     style:
//                         TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 8.0),
//                 Text(
//                     'Please provide the names of documents for verification purposes. These names will be publicly visible but will only be accessible to introduced members.',
//                     style: TextStyle(fontSize: 12.0)),
//                 SizedBox(height: 16.0),
//                 Center(
//                   child: Container(
//                     height: 170,
//                     width: 360,
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black26)),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         _buildFileUploadRow(
//                             'Business Photos',
//                             () => _pickFile((files) => _businessPhotos = files),
//                             w),
//                         _buildFileUploadRow(
//                             'Business Documents',
//                             () => _pickFile(
//                                 (files) => _businessDocuments = files),
//                             w),
//                         _buildFileUploadRow(
//                             'Business Proof',
//                             () => _pickFile(
//                                 (files) => _businessProof = files?.first,
//                                 allowMultiple: false),
//                             w),
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
//                     onPressed: _submitForm,
//                     child: _isSubmitting
//                         ? CircularProgressIndicator(color: Colors.white)
//                         : Text('Verify Business',
//                             style: TextStyle(color: Colors.white)),
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
//   Widget _buildFileUploadRow(String label, VoidCallback onPressed, double w) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(label),
//         SizedBox(width: w * 0.17),
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
//       ],
//     );
//   }
//
//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       if (_businessPhotos == null ||
//           _businessDocuments == null ||
//           _businessProof == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please select all business files')),
//         );
//         return;
//       }
//
//       setState(() => _isSubmitting = true);
//
//       final response = await BusinessAddPage.businessAddPage(
//         name: _controllers['businessName']!.text,
//         industry: _selectedIndustry,
//         establish_yr: _controllers['yearEstablished']!.text,
//         description: _controllers['description']!.text,
//         address_1: _controllers['address1']!.text,
//         address_2: _controllers['address2']!.text,
//         state: _selectedState,
//         pin: _controllers['pin']!.text,
//         city: _selectedCity,
//         employees: _controllers['numberOfEmployees']!.text,
//         entity: _selectedBusinessEntityType,
//         avg_monthly: _controllers['averageMonthlySales']!.text,
//         latest_yearly: _controllers['mostReportedYearlySales']!.text,
//         ebitda: _controllers['ebitda']!.text,
//         rate: _controllers['askingPrice']!.text,
//         type_sale: _controllers['preferredType']!.text,
//         url: _controllers['businessWebsite']!.text,
//         top_selling: _controllers['topOfferings']!.text,
//         features: _controllers['keyFeatures']!.text,
//         facility: _controllers['facilityDetails']!.text,
//         reason: _controllers['reason']!.text,
//         income_source: _controllers['fundingDetails']!.text,
//         image1: File(_businessPhotos!.first.path!),
//         doc1: File(_businessDocuments!.first.path!),
//         proof1: File(_businessProof!.path!),
//       );
//
//       setState(() => _isSubmitting = false);
//
//       if (response == true) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => BusinessListingsScreen()),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             duration: Duration(milliseconds: 800),
//             content: Text('Failed to submit business information'),
//           ),
//         );
//       }
//     }
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_emergio/Views/Profiles/Business/business%20listing%20page.dart';
import 'package:project_emergio/services/profile%20forms/business/BusinessAddPage.dart';

class BusinessInfoPage extends StatefulWidget {
  const BusinessInfoPage({Key? key}) : super(key: key);

  @override
  _BusinessInfoPageState createState() => _BusinessInfoPageState();
}

class _BusinessInfoPageState extends State<BusinessInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'businessName': TextEditingController(),
    'yearEstablished': TextEditingController(),
    'description': TextEditingController(),
    'address1': TextEditingController(),
    'pin': TextEditingController(),
    'address2': TextEditingController(),
    'numberOfEmployees': TextEditingController(),
    'averageMonthlySales': TextEditingController(),
    'askingPrice': TextEditingController(),
    'mostReportedYearlySales': TextEditingController(),
    'ebitda': TextEditingController(),
    'preferredType': TextEditingController(),
    'businessWebsite': TextEditingController(),
    'topOfferings': TextEditingController(),
    'keyFeatures': TextEditingController(),
    'facilityDetails': TextEditingController(),
    'fundingDetails': TextEditingController(),
    'reason': TextEditingController(),
  };

  String _selectedIndustry = 'Fashion';
  String _selectedState = 'Kerala';
  String _selectedCity = 'Kakkanad';
  String _selectedBusinessEntityType = 'Entity Type 1';
  List<XFile>? _businessPhotos;
  List<PlatformFile>? _businessDocuments;
  PlatformFile? _businessProof;
  bool _isSubmitting = false;

  final List<Map<String, String>> _industries = [
    {'value': 'Education', 'display': 'Education'},
    {'value': 'Information Technology', 'display': 'IT'},
    {'value': 'Healthcare', 'display': 'Healthcare'},
    {'value': 'Fashion', 'display': 'Fashion'},
    {'value': 'Food', 'display': 'Food'},
    {'value': 'Automobile', 'display': 'Automobile'},
    {'value': 'Banking', 'display': 'Banking'},
  ];

  @override
  void initState() {
    super.initState();
    _controllers['preferredType']!.text = 'Selling';
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
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

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Investor Name is required';
    }
    final namePattern = r'^[a-zA-Z\s]+$'; // Allows only letters and spaces
    final regex = RegExp(namePattern);
    if (!regex.hasMatch(value)) {
      return 'Only letters and spaces are allowed';
    }
    if (value.length > 50) { // Limit for the name
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

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    if (value.length < 50) {
      return 'Description should be at least 50 characters long';
    }
    if (value.length > 1000) {
      return 'Description should not exceed 1000 characters';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    if (value.length > 200) {
      return 'Address should not exceed 200 characters';
    }
    return null;
  }

  String? _validatePinCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pin Code is required';
    }
    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'Pin Code should be exactly 6 digits';
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
      // 1 trillion limit
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

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      focusedErrorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    );
  }

  Widget _buildHintText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTextFormField(String key,
      {String? Function(String?)? validator,
      int? maxLines,
      TextInputType? keyboardType}) {
    return TextFormField(
      controller: _controllers[key],
      decoration: _inputDecoration(),
      validator: validator ??
          (value) => value!.isEmpty ? 'This field is required' : null,
      maxLines: maxLines,
      keyboardType: keyboardType,
    );
  }

  Widget _buildDropdownFormField(
      String value, List<String> items, void Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: items
          .map((item) => DropdownMenuItem(
              value: item, child: Text(item, style: TextStyle(fontSize: 12))))
          .toList(),
      decoration: _inputDecoration(),
      validator: (value) =>
          value == null || value.isEmpty ? 'Please select an option' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Business Information',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: h * 0.025)),
                SizedBox(height: h * .03),
                _buildHintText('Business Name'),
                _buildTextFormField('businessName',
                    validator: _validateName
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('Industry'),
                          _buildDropdownFormField(
                              _selectedIndustry,
                              _industries.map((i) => i['value']!).toList(),
                              (value) =>
                                  setState(() => _selectedIndustry = value!)),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('Year Established'),
                          _buildTextFormField('yearEstablished',
                              keyboardType: TextInputType.number,
                              validator: _validateYear),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                _buildHintText('Description of the Business'),
                _buildTextFormField('description',
                    maxLines: null, validator: _validateDescription),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('State'),
                          _buildDropdownFormField(
                              _selectedState,
                              [
                                'Andhra Pradesh',
                                'Arunachal Pradesh',
                                'Assam',
                                'Bihar',
                                'Chhattisgarh',
                                'Goa',
                                'Gujarat',
                                'Haryana',
                                'Himachal Pradesh',
                                'Jharkhand',
                                'Karnataka',
                                'Kerala',
                                'Madhya Pradesh',
                                'Maharashtra',
                                'Manipur',
                                'Meghalaya',
                                'Mizoram',
                                'Nagaland',
                                'Odisha',
                                'Punjab',
                                'Rajasthan',
                                'Sikkim',
                                'Tamil Nadu',
                                'Telangana',
                                'Tripura',
                                'Uttar Pradesh',
                                'Uttarakhand',
                                'West Bengal'
                              ],
                              (value) =>
                                  setState(() => _selectedState = value!)),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('City'),
                          _buildDropdownFormField(
                              _selectedCity,
                              ['Kochi', 'Kakkanad', 'Palarivattom'],
                              (value) =>
                                  setState(() => _selectedCity = value!)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                _buildHintText('Pin Code'),
                _buildTextFormField('pin',
                    keyboardType: TextInputType.number,
                    validator: _validatePinCode),
                SizedBox(height: 16.0),
                _buildHintText('Address 1'),
                _buildTextFormField('address1', validator: _validateAddress),
                SizedBox(height: 16.0),
                _buildHintText('Address 2'),
                _buildTextFormField('address2',
                    validator: (value) =>
                        value!.isNotEmpty ? _validateAddress(value) : null),
                SizedBox(height: 16.0),
                _buildHintText('Number of Employees'),
                _buildTextFormField('numberOfEmployees',
                    keyboardType: TextInputType.number,
                    validator: _validateEmployees),
                SizedBox(height: 16.0),
                _buildHintText('Business Legal Entity Type'),
                _buildDropdownFormField(
                    _selectedBusinessEntityType,
                    ['Entity Type 1', 'Entity Type 2', 'Entity Type 3'],
                    (value) =>
                        setState(() => _selectedBusinessEntityType = value!)),
                SizedBox(height: 16.0),
                _buildHintText(
                    'What is your average monthly sales figure at the moment?'),
                _buildTextFormField('averageMonthlySales',
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        _validateSales(value, 'Average Monthly Sales')),
                SizedBox(height: 16.0),
                _buildHintText('What was your most reported yearly sales?'),
                _buildTextFormField('mostReportedYearlySales',
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        _validateSales(value, 'Most Reported Yearly Sales')),
                SizedBox(height: 16.0),
                _buildHintText('EBITDA / Operating Profit Margin Percentage'),
                _buildTextFormField('ebitda',
                    keyboardType: TextInputType.number,
                    validator: _validateEbitda),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('Asking Price'),
                          _buildTextFormField('askingPrice',
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  _validateSales(value, 'Asking Price')),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHintText('Preferred Type of Selling'),
                          _buildDropdownFormField(
                              _controllers['preferredType']!.text,
                              ['Franchise', 'Investment', 'Selling'],
                              (value) => setState(() =>
                                  _controllers['preferredType']!.text =
                                      value!)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                _buildHintText('Business Website URL'),
                _buildTextFormField('businessWebsite', validator: _validateUrl),
                SizedBox(height: 16.0),
                _buildHintText(
                    'What are the top selling offerings of the company, who are the customers?'),
                _buildTextFormField('topOfferings',
                    maxLines: 4,
                    validator: (value) => _validateTextArea(
                        value, 'Top Offerings',
                        minLength: 50, maxLength: 500)),
                SizedBox(height: 16.0),
                _buildHintText(
                    'Outline the business\'s key features, including its client base, revenue structure, founder background, industry competition, revenues, etc.'),
                _buildTextFormField('keyFeatures',
                    maxLines: 4,
                    validator: (value) => _validateTextArea(
                        value, 'Key Features',
                        minLength: 100, maxLength: 1000)),
                SizedBox(height: 16.0),
                _buildHintText(
                    'Provide details about your facility, like its total floor area, number of levels, and leasing terms.'),
                _buildTextFormField('facilityDetails',
                    maxLines: 4,
                    validator: (value) => _validateTextArea(
                        value, 'Facility Details',
                        minLength: 50, maxLength: 500)),
                SizedBox(height: 16.0),
                _buildHintText('What is the reason for selling this business'),
                _buildTextFormField('reason',
                    maxLines: 4,
                    validator: (value) => _validateTextArea(
                        value, 'Reason for Selling',
                        minLength: 50, maxLength: 500)),
                SizedBox(height: 16.0),
                _buildHintText(
                    'Detail the current funding sources for the business, including any outstanding debts or loans, as well as the total count of shareholders or owners, specifying their ownership percentages.'),
                _buildTextFormField('fundingDetails',
                    maxLines: 4,
                    validator: (value) => _validateTextArea(
                        value, 'Funding Details',
                        minLength: 100, maxLength: 1000)),
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
                _buildFileUploadRow('Business Photos', _pickBusinessPhotos,_businessPhotos),
                _buildFileUploadRow(
                    'Business Documents',
                    _pickBusinessDocuments,_businessDocuments
                ),
                _buildFileUploadRow(
                  'Business Proof',
                  _pickBusinessProof,
                  _businessProof != null ? [_businessProof!] : null,
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
                    onPressed: submitForm,
                    child: _isSubmitting
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Verify Business',
                            style: TextStyle(color: Colors.white)),
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

  // Widget _buildFileUploadRow(String label, VoidCallback onPressed, List<PlatformFile>? files) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text(label),
  //       SizedBox(width: 17),
  //       ElevatedButton(
  //         onPressed: onPressed,
  //         child: Text('Upload file'),
  //         style: ElevatedButton.styleFrom(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(2),
  //             side: BorderSide(color: Colors.black),
  //           ),
  //         ),
  //       ),
  //       if (files != null && files.isNotEmpty)
  //         Expanded(
  //           child: SingleChildScrollView(
  //             scrollDirection: Axis.horizontal,
  //             child: Row(
  //               children: files.map((file) {
  //                 return Padding(
  //                   padding: const EdgeInsets.only(left: 8.0),
  //                   child: file.extension?.toLowerCase() == 'pdf'
  //                       ? Icon(Icons.picture_as_pdf, color: Colors.red)
  //                       : Image.file(
  //                     File(file.path!),
  //                     width: 50,
  //                     height: 40,
  //                     fit: BoxFit.cover,
  //                   ),
  //                 );
  //               }).toList(),
  //             ),
  //           ),
  //         ),
  //     ],
  //   );
  // }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_businessPhotos == null || _businessPhotos!.length < 4 || _businessDocuments == null || _businessProof == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select all required business files (4 photos, documents, and proof)')),
        );
        return;
      }

      setState(() => _isSubmitting = true);

      final response = await BusinessAddPage.businessAddPage(
        name: _controllers['businessName']!.text,
        industry: _selectedIndustry,
        establish_yr: _controllers['yearEstablished']!.text,
        description: _controllers['description']!.text,
        address_1: _controllers['address1']!.text,
        address_2: _controllers['address2']!.text,
        state: _selectedState,
        pin: _controllers['pin']!.text,
        city: _selectedCity,
        employees: _controllers['numberOfEmployees']!.text,
        entity: _selectedBusinessEntityType,
        avg_monthly: _controllers['averageMonthlySales']!.text,
        latest_yearly: _controllers['mostReportedYearlySales']!.text,
        ebitda: _controllers['ebitda']!.text,
        rate: _controllers['askingPrice']!.text,
        type_sale: _controllers['preferredType']!.text,
        url: _controllers['businessWebsite']!.text,
        top_selling: _controllers['topOfferings']!.text,
        features: _controllers['keyFeatures']!.text,
        facility: _controllers['facilityDetails']!.text,
        reason: _controllers['reason']!.text,
        income_source: _controllers['fundingDetails']!.text,
        image1: File(_businessPhotos![0].path!),
        image2: File(_businessPhotos![1].path!),
        image3: File(_businessPhotos![2].path!),
        image4: File(_businessPhotos![3].path!),
        doc1: File(_businessDocuments!.first.path!),
        proof1: File(_businessProof!.path!),
      );

      setState(() => _isSubmitting = false);

      if (response == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BusinessListingsScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 800),
            content: Text('Failed to submit business information'),
          ),
        );
      }
    }
  }
}
