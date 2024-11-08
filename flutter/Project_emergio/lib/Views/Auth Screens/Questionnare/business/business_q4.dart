import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common_questionnare1.dart';

class BusinessQuestionnareScreen4 extends StatefulWidget {
  final String city;
  final String state;
  final String type;
  final String businessStage;
  final String businessGoal;
  final String operationDuration;

  const BusinessQuestionnareScreen4({
    super.key,
    required this.city,
    required this.state,
    required this.businessStage,
    required this.businessGoal,
    required this.operationDuration, required this.type,
  });

  @override
  State<BusinessQuestionnareScreen4> createState() => _BusinessQuestionnareScreen4State();
}

class _BusinessQuestionnareScreen4State extends State<BusinessQuestionnareScreen4> {
  final Color customYellow = const Color(0xffFFCC00);
  final TextEditingController _budgetController = TextEditingController();
  String? selectedRange;
  bool isCustomBudget = false;

  final List<Map<String, String>> budgetRanges = [
    {
      'range': 'Less than ₹10,00,000',
      'subtitle': 'Small projects and initial investments',
    },
    {
      'range': '₹10,00,000 - ₹50,00,000',
      'subtitle': 'Medium-sized business requirements',
    },
    {
      'range': '₹50,00,000 - ₹1,00,00,000',
      'subtitle': 'Large business expansions',
    },
    {
      'range': '₹1,00,00,000 - ₹3,00,00,000',
      'subtitle': 'Major business investments',
    },
    {
      'range': 'More than ₹3,00,00,000',
      'subtitle': 'Enterprise-level investments',
    },
    {
      'range': 'Custom Budget',
      'subtitle': 'Specify your exact budget',
    },
  ];

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  String? _validateBudget(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a budget';
    }
    final budget = int.tryParse(value.replaceAll(RegExp(r'[^\d]'), ''));
    if (budget == null) {
      return 'Please enter a valid amount';
    }
    if (budget <= 0) {
      return 'Budget must be greater than 0';
    }
    return null;
  }

  void _handleOptionSelect(String range) {
    HapticFeedback.selectionClick();
    setState(() {
      selectedRange = range;
      isCustomBudget = range == 'Custom Budget';
      if (!isCustomBudget) {
        _budgetController.clear();
      }
    });
  }

  String _formatCurrency(String value) {
    if (value.isEmpty) return '';
    final onlyNumbers = value.replaceAll(RegExp(r'[^\d]'), '');
    if (onlyNumbers.isEmpty) return '';
    final number = int.parse(onlyNumbers);

    // Convert to Indian numbering system (lakhs and crores)
    String result = number.toString();
    String formatted = '';

    // Handle numbers greater than or equal to 1000
    if (result.length > 3) {
      // Add last 3 digits
      formatted = result.substring(result.length - 3);
      result = result.substring(0, result.length - 3);

      // Add remaining digits in groups of 2
      while (result.isNotEmpty) {
        if (result.length >= 2) {
          formatted = '${result.substring(result.length - 2)},$formatted';
          result = result.substring(0, result.length - 2);
        } else {
          formatted = '$result,$formatted';
          result = '';
        }
      }
    } else {
      formatted = result;
    }

    return '₹$formatted';
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
    );

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            automaticallyImplyLeading: false,
            leadingWidth: 80.w,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                child: Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                      '05/',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '08',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: LinearProgressIndicator(
                  value: 0.625,
                  minHeight: 8.h,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(customYellow),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What is your budget range?',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Select a budget range or specify your exact budget',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: budgetRanges.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final range = budgetRanges[index];
                  final isSelected = selectedRange == range['range'];

                  return Column(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _handleOptionSelect(range['range']!),
                          borderRadius: BorderRadius.circular(8.r),
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected ? customYellow : Colors.grey[300]!,
                                width: isSelected ? 1.5 : 1,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                              color: isSelected ? customYellow.withOpacity(0.1) : Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        range['range']!,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                                          color: isSelected ? Colors.black87 : Colors.grey[800],
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        range['subtitle']!,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle,
                                    color: customYellow,
                                    size: 20.sp,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (isSelected && isCustomBudget)
                        Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: TextFormField(
                            controller: _budgetController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 15.sp),
                            decoration: InputDecoration(
                              hintText: 'Enter your budget',
                              prefixText: '₹ ',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TextInputFormatter.withFunction(
                                    (oldValue, newValue) => TextEditingValue(
                                  text: _formatCurrency(newValue.text),
                                  selection: TextSelection.collapsed(
                                    offset: _formatCurrency(newValue.text).length,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),

            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: (selectedRange != null &&
                        (!isCustomBudget || (isCustomBudget && _budgetController.text.isNotEmpty)))
                        ? () {
                      final budget = isCustomBudget ? _budgetController.text : selectedRange;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommonQuestionnareScreen1(
                            city: widget.city,
                            state: widget.state,
                            businessStage: widget.businessStage,
                            businessGoal: widget.businessGoal,
                            operationDuration: widget.operationDuration,
                            budget: selectedRange!,
                            type: widget.type,
                          ),
                        ),
                      );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: customYellow,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      disabledBackgroundColor: Colors.grey[300],
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}