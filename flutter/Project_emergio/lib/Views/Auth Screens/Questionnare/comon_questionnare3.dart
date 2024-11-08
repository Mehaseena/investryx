import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_emergio/Views/Auth%20Screens/Questionnare/reg_successfull.dart';

import '../../../services/Questionnaire.dart';

class CommonQuestionnaireScreen3 extends StatefulWidget {
  final String city;
  final String state;
  final String businessStage;
  final String businessGoal;
  final String operationDuration;
  final String budget;
  final String industry;
  final List<String> selectedStates;
  final Map<String, List<String>> selectedCities;
  /// Add new optional parameters for investor questionnaire
  final String? type;
  final String? investmentInterest;
  final String? investmentHorizon;
  final String? riskTolerance;
  final String? priorExperience;
  /// new optional parameters for franchise questionnaire
  final String? buyOrStart;
  final String? franchiseTypes;
  final String? brands;
  /// advisor
  final String? expertise;
  final String? clientType;
  final String? experience;
  final String? advisoryDuration;

  const CommonQuestionnaireScreen3({
    super.key,
    required this.city,
    required this.state,
    required this.businessStage,
    required this.businessGoal,
    required this.operationDuration,
    required this.budget,
    required this.industry,
    required this.selectedStates,
    required this.selectedCities,
    // Initialize new optional parameters
    this.type,
    this.investmentInterest,
    this.investmentHorizon,
    this.riskTolerance,
    this.priorExperience, this.buyOrStart, this.franchiseTypes, this.brands, this.expertise, this.clientType, this.experience, this.advisoryDuration,
  });

  @override
  State<CommonQuestionnaireScreen3> createState() => _CommonQuestionnaireScreen3State();
}

class _CommonQuestionnaireScreen3State extends State<CommonQuestionnaireScreen3> {
  final Color customYellow = const Color(0xffFFCC00);
  String? selectedFrequency;
  final List<String> frequencies = ['Daily', 'Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    '08/',
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
          // Progress Bar
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                value: 1.0,
                minHeight: 8.h,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(customYellow),
              ),
            ),
          ),

          // Title Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How often would you like to receive updates?',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Select your preferred frequency for updates and recommendations',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Frequency Options
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  children: frequencies.map((frequency) {
                    final bool isSelected = selectedFrequency == frequency;
                    final bool isLast = frequency == frequencies.last;

                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedFrequency = frequency;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                            child: Row(
                              children: [
                                Container(
                                  width: 24.w,
                                  height: 24.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected ? customYellow : Colors.grey[400]!,
                                      width: 2.w,
                                    ),
                                  ),
                                  child: isSelected
                                      ? Center(
                                    child: Container(
                                      width: 12.w,
                                      height: 12.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: customYellow,
                                      ),
                                    ),
                                  )
                                      : null,
                                ),
                                SizedBox(width: 16.w),
                                Text(
                                  frequency,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black87,
                                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (!isLast)
                          Divider(
                            height: 1,
                            indent: 56.w,
                            color: Colors.grey[200],
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          // Continue Button
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
                  onPressed: selectedFrequency != null
                      ? () {
                   _handleQuestionnaireSubmission();
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
    );
  }
  Future<void> _handleQuestionnaireSubmission() async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(customYellow),
            ),
          );
        },
      );

      // Get userId from secure storage (now optional)
      final storage = FlutterSecureStorage();
      final userId = await storage.read(key: 'userId');

      final result = await QuestionnairePost.questionnairePost(
        userId: userId, // Now optional
        city: widget.city,
        state: widget.state,
        businessStage: widget.businessStage,
        businessGoal: widget.businessGoal,
        operationDuration: widget.operationDuration,
        budget: widget.budget,
        industry: widget.industry,
        selectedStates: widget.selectedStates,
        selectedCities: widget.selectedCities,
        frequency: selectedFrequency,
        // Optional parameters
        type: widget.type,
        investmentInterest: widget.investmentInterest,
        investmentHorizon: widget.investmentHorizon,
        riskTolerance: widget.riskTolerance,
        priorExperience: widget.priorExperience,
        buyOrStart: widget.buyOrStart,
        franchiseTypes: widget.franchiseTypes,
        brands: widget.brands,
        expertise: widget.expertise,
        clientType: widget.clientType,
        experience: widget.experience,
        advisoryDuration: widget.advisoryDuration,
      );

      // Remove loading indicator
      if (context.mounted) {
        Navigator.pop(context);
      }

      if (result == true) {
        // Navigate to success screen
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CustomRegistrationSuccessScreen(),
            ),
          );
        }
      } else {
        // Show error message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to submit questionnaire. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      // Remove loading indicator
      if (context.mounted) {
        Navigator.pop(context);

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      log('Error submitting questionnaire: $e');
    }
  }
}