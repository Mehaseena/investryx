import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:project_emergio/services/profile%20forms/investor/investor%20add.dart';
import 'investment listing.dart';

class InvestorFormScreen extends StatefulWidget {
  const InvestorFormScreen({super.key});

  @override
  State<InvestorFormScreen> createState() => _InvestorFormScreenState();
}

class _InvestorFormScreenState extends State<InvestorFormScreen> {
  final _formKey = GlobalKey<FormState>(); // Add GlobalKey for the form

  final _investorNameController = TextEditingController();
  String _selectedIndustry = '';
  String _selectedState = '';
  String _selectedCity = '';
  final _locationsIntrestedController = TextEditingController();
  final _InvestmentRangefromController = TextEditingController();
  final _InvestmentRangeToController = TextEditingController();
  final _aspectsEvaluatingController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _businessWebsiteController = TextEditingController();
  final _aboutCompanyController = TextEditingController();

  List<XFile>? _businessPhotos;
  List<PlatformFile>? _businessDocuments;
  PlatformFile? _businessProof;

  bool _isSubmitting = false;

  @override
  void dispose() {
    _investorNameController.dispose();
    _locationsIntrestedController.dispose();
    _InvestmentRangefromController.dispose();
    _InvestmentRangeToController.dispose();
    _aspectsEvaluatingController.dispose();
    _companyNameController.dispose();
    _businessWebsiteController.dispose();
    _aboutCompanyController.dispose();

    super.dispose();
  }

// Add a new validation method for names
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

// Similarly update other validation methods
  String? _validateLimitedLength(String? value, String fieldName, int maxLength) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    if (value.length > maxLength) {
      return '$fieldName cannot exceed $maxLength characters';
    }
    return null;
  }

  String? _validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Company Website URL is required';
    }
    final urlPattern = r'^(https?:\/\/)?([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,6}(\/[^\s]*)?$'; // Updated regex
    final regex = RegExp(urlPattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid URL (e.g., http://example.com or https://www.example.com)';
    }
    if (value.length > 100) { // Limit for the URL
      return 'URL cannot exceed 100 characters';
    }
    return null;
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

  @override
  void initState() {
    super.initState();
    _selectedIndustry = 'Fashion';
    _selectedState = 'Kerala';
    _selectedCity = 'Kakkanad';
  }

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateNumber(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number for $fieldName';
    }
    return null;
  }

  Widget _buildSelectedImages() {
    if (_businessPhotos == null || _businessPhotos!.isEmpty) {
      return Text('');
    }
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(8.0),
      itemCount: _businessPhotos!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) {
        final file = _businessPhotos![index];
        return Image.file(
          File(file.path!),
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _buildSelectedDocuments() {
    if (_businessDocuments == null || _businessDocuments!.isEmpty) {
      return Text('');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _businessDocuments!.map((file) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(file.name),
        );
      }).toList(),
    );
  }

  Widget _buildSelectedProof() {
    if (_businessProof == null) {
      return Text('');
    }
    return Text(_businessProof!.name);
  }


  @override
  Widget build(BuildContext context) {
    final h = MediaQuery
        .of(context)
        .size
        .height;
    final w = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey, // Assign the form key
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Investor Information',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: h * 0.025),
                    ),
                    SizedBox(height: h * .03),
                    _buildHintText('Investor Name'),
                    TextFormField(
                      controller: _investorNameController,
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
                                items: ['Education', 'Information Technology', 'Healthcare','Fashion','Food','Automobile','Banking']

                                    .map((industry) =>
                                    DropdownMenuItem(
                                      value: industry,
                                      child: Text(industry),
                                    ))
                                    .toList(),
                                decoration: _inputDecoration(),
                                validator: (value) =>
                                    _validateNotEmpty(value, 'Industry'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.0),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHintText('State'),
                              DropdownButtonFormField<String>(
                                value: _selectedState,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedState = value!;
                                  });
                                },
                                items: ['AndhraPradesh', 'ArunachalPradesh', 'Assam', 'Bihar', 'Chhattisgarh', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand', 'Karnataka', 'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'Odisha', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'UttarPradesh', 'Uttarakhand', 'WestBengal']
                                    .map((state) =>
                                    DropdownMenuItem(
                                      value: state,
                                      child: Text(state),
                                    ))
                                    .toList(),
                                decoration: _inputDecoration(),
                                validator: (value) =>
                                    _validateNotEmpty(value, 'State'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHintText('City'),
                              DropdownButtonFormField<String>(
                                value: _selectedCity,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCity = value!;
                                  });
                                },
                                items: ['Kochi', 'Kakkanad', 'Palarivattom']
                                    .map((city) =>
                                    DropdownMenuItem(
                                      value: city,
                                      child: Text(city),
                                    ))
                                    .toList(),
                                decoration: _inputDecoration(),
                                validator: (value) =>
                                    _validateNotEmpty(value, 'City'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    _buildHintText('Select location you are interested in'),
                    TextFormField(
                      controller: _locationsIntrestedController,
                      maxLines: null,
                      decoration: _inputDecoration(),
                      validator: (value) => _validateLimitedLength(value, 'Location Interested', 100), // Set limit as needed
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHintText('Investment Range From'),
                              TextFormField(
                                controller: _InvestmentRangefromController,
                                keyboardType: TextInputType.number,
                                decoration: _inputDecoration(),
                                validator: (value) => _validateNumber(value, 'Investment Range From'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHintText('Investment Range To'),
                              TextFormField(
                                controller: _InvestmentRangeToController,
                                keyboardType: TextInputType.number,
                                decoration: _inputDecoration(),
                                validator: (value) => _validateNumber(value, 'Investment Range To'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    _buildHintText(
                        'Aspects you consider when evaluating a business'),
                    TextFormField(
                      controller: _aspectsEvaluatingController,
                      decoration: _inputDecoration(),
                      validator: (value) => _validateLimitedLength(value, 'Aspects Evaluating', 150), // Limit as needed
                    ),
                    SizedBox(height: 16.0),
                    _buildHintText('Your Company Name'),
                    TextFormField(
                      controller: _companyNameController,
                      decoration: _inputDecoration(),
                      validator: (value) => _validateLimitedLength(value, 'Company Name', 50), // Limit as needed
                    ),
                    SizedBox(height: 16.0),
                    _buildHintText('Company Website URL'),
                    TextFormField(
                      controller: _businessWebsiteController,
                      decoration: _inputDecoration(),
                      validator: _validateUrl,
                    ),

                    SizedBox(height: 16.0),
                    _buildHintText('About Your Company'),
                    TextFormField(
                      maxLines: 5,
                      controller: _aboutCompanyController,
                      decoration: _inputDecoration(),
                      validator: (value) => _validateLimitedLength(value, 'About Company', 250), // Limit as needed
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
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (_businessPhotos == null || _businessPhotos!.length < 4 || _businessDocuments == null || _businessProof == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Please select all required business files (4 photos, 1 document, and 1 proof)')),
                              );
                              return;
                            }

                            setState(() {
                              _isSubmitting = true;
                            });

                            final File imageFile1 = File(_businessPhotos![0].path!);
                            final File imageFile2 = File(_businessPhotos![1].path!);
                            final File imageFile3 = File(_businessPhotos![2].path!);
                            final File imageFile4 = File(_businessPhotos![3].path!);
                            final File docFile = File(_businessDocuments!.first.path!);
                            final File proofFile = File(_businessProof!.path!);

                            final response = await InvestorAddPage.investorAddPage(
                              name: _investorNameController.text,
                              companyName: _companyNameController.text,
                              industry: _selectedIndustry,
                              description: _aboutCompanyController.text,
                              state: _selectedState,
                              city: _selectedCity,
                              url: _businessWebsiteController.text,
                              rangeStarting: _InvestmentRangefromController.text,
                              rangeEnding: _InvestmentRangeToController.text,
                              evaluatingAspects: _aspectsEvaluatingController.text,
                              locationInterested: _locationsIntrestedController.text,
                              image1: imageFile1,
                              image2: imageFile2,
                              image3: imageFile3,
                              image4: imageFile4,
                              doc1: docFile,
                              proof1: proofFile,
                            );

                            setState(() {
                              _isSubmitting = false;
                            });

                            if (response == true) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InvestorListingsScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(milliseconds: 800),
                                  content: Text('All Fields Required'),
                                ),
                              );
                            }
                          }
                        },                        child: Text(
                          'Verify',
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
          if (_isSubmitting)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                    child: Lottie.asset(
                      'assets/loading.json',
                      height: 80.h,
                      width: 120.w,
                      fit: BoxFit.cover,
                    ),
                  )
            ),
        ],
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

}

