import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBottomSheet extends StatefulWidget {
  final String query;
  final Map<String, dynamic> previousFilters;

  FilterBottomSheet({required this.query, required this.previousFilters});

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedLocation;
  String? selectedIndustry;
  String? selectedBusinessType;
  String? selectedOwnershipType;
  double? minInvestment;
  double? maxInvestment;
  int? minYearEstablished;
  int? maxYearEstablished;
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  List<String> locations = ['Kochi', 'Kakkanad', 'Palarivattom'];
  List<String> industries = [
    'Education',
    'Information Technology',
    'Healthcare',
    'Fashion',
    'Food',
    'Automobile',
    'Banking'
  ];
  List<String> businessTypes = ['franchise', 'business', 'investor', 'advisor'];
  List<String> ownershipTypes = [
    'Sole Proprietorship',
    'Partnership',
    'Corporation'
  ];

  @override
  void initState() {
    super.initState();
    initializeFilters();
  }

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  void initializeFilters() {
    String? selectedLocationPre = widget.previousFilters['city'] as String?;
    String? selectedIndustryPre = widget.previousFilters['industry'] as String?;
    String? selectedBusinessTypePre = widget.previousFilters['entity_type'] as String?;

    minInvestment = _parseDouble(widget.previousFilters['range_starting']);
    maxInvestment = _parseDouble(widget.previousFilters['range_ending']);
    minYearEstablished = _parseInt(widget.previousFilters['establish_from']);
    maxYearEstablished = _parseInt(widget.previousFilters['establish_to']);

    if (locations.contains(selectedLocationPre)) {
      selectedLocation = selectedLocationPre;
    }
    if (industries.contains(selectedIndustryPre)) {
      selectedIndustry = selectedIndustryPre;
    }
    if (businessTypes.contains(selectedBusinessTypePre)) {
      selectedBusinessType = selectedBusinessTypePre;
    }

    minController.text = minInvestment?.toString() ?? '';
    maxController.text = maxInvestment?.toString() ?? '';
    fromController.text = minYearEstablished?.toString() ?? '';
    toController.text = maxYearEstablished?.toString() ?? '';
  }

  double? _parseDouble(dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return null;
    }
    return double.tryParse(value.toString());
  }

  int? _parseInt(dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return null;
    }
    return int.tryParse(value.toString());
  }

  void _clearFilters() {
    setState(() {
      selectedLocation = null;
      selectedIndustry = null;
      selectedBusinessType = null;
      selectedOwnershipType = null;
      minInvestment = null;
      maxInvestment = null;
      minYearEstablished = null;
      maxYearEstablished = null;
      minController.clear();
      maxController.clear();
      fromController.clear();
      toController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: _clearFilters,
                    child: Text(
                      'Remove Filters',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              buildDropdownSection('Location', locations, selectedLocation, (value) {
                setState(() {
                  selectedLocation = value;
                });
              }),
              buildDropdownSection('Industry', industries, selectedIndustry, (value) {
                setState(() {
                  selectedIndustry = value;
                });
              }),
              buildDropdownSection('Business Type', businessTypes, selectedBusinessType, (value) {
                setState(() {
                  selectedBusinessType = value;
                });
              }),
              buildRangeSection(
                'Investment Range',
                'Min Investment',
                'Max Investment',
                    (value) {
                  setState(() {
                    minInvestment = value.isNotEmpty ? _parseDouble(value) : null;
                  });
                },
                    (value) {
                  setState(() {
                    maxInvestment = value.isNotEmpty ? _parseDouble(value) : null;
                  });
                },
                minController: minController,
                maxController: maxController,
              ),
              buildRangeYearSection(
                'Year Established',
                'From Year',
                'To Year',
                    (value) {
                  setState(() {
                    minYearEstablished = value.isNotEmpty ? _parseInt(value) : null;
                  });
                },
                    (value) {
                  setState(() {
                    maxYearEstablished = value.isNotEmpty ? _parseInt(value) : null;
                  });
                },
                fromController: fromController,
                toController: toController,
              ),
              SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'location': selectedLocation,
                      'industry': selectedIndustry,
                      'businessType': selectedBusinessType,
                      'ownershipType': selectedOwnershipType,
                      'minInvestment': minInvestment,
                      'maxInvestment': maxInvestment,
                      'minYearEstablished': minYearEstablished,
                      'maxYearEstablished': maxYearEstablished,
                      'filter': true,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    'Apply Filters',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdownSection(String title, List<String> items, String? selectedValue, Function(String?) onChanged) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              value: selectedValue,
              onChanged: onChanged,
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
              ),
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRangeSection(String title, String minLabel, String maxLabel, Function(String) onMinChanged, Function(String) onMaxChanged, { required TextEditingController minController, required TextEditingController maxController,}) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: minLabel,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: onMinChanged,
                    controller: minController,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: maxLabel,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: onMaxChanged,
                    controller: maxController,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRangeYearSection(String title, String minLabel, String maxLabel, Function(String) onMinChanged, Function(String) onMaxChanged, { required TextEditingController fromController, required TextEditingController toController,}) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: minLabel,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: onMinChanged,
                    controller: fromController,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: maxLabel,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: onMaxChanged,
                    controller: toController,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
