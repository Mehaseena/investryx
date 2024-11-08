import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_list.dart';

class QuestionnairePost {
  static var client = http.Client();
  static final storage = FlutterSecureStorage();

  static Future<bool?> questionnairePost({
    String? userId,
    String? city,
    String? state,
    String? businessStage,
    String? businessGoal,
    String? operationDuration,
    String? budget,
    String? industry,
    List<String>? selectedStates,
    Map<String, List<String>>? selectedCities,
    String? frequency,
    // Optional parameters for investor
    String? type,
    String? investmentInterest,
    String? investmentHorizon,
    String? riskTolerance,
    String? priorExperience,
    // Optional parameters for franchise
    String? buyOrStart,
    String? franchiseTypes,
    String? brands,
    // Optional parameters for advisor
    String? expertise,
    String? clientType,
    String? experience,
    String? advisoryDuration,
  }) async {
    // Retrieve the token from Flutter secure storage
    String? token = await storage.read(key: 'token');
    if (token == null) {
      log('Token is missing');
      return null;
    }

    // Create base request body with non-null values only
    Map<String, dynamic> requestBody = {};

    // Helper function to add non-null values to request body
    void addIfNotNull(String key, dynamic value) {
      if (value != null) {
        requestBody[key] = value;
      }
    }

    // Add all parameters if they are not null
    addIfNotNull("userId", userId);
    addIfNotNull("city", city);
    addIfNotNull("state", state);
    addIfNotNull("businessStage", businessStage);
    addIfNotNull("businessGoal", businessGoal);
    addIfNotNull("operationDuration", operationDuration);
    addIfNotNull("budget", budget);
    addIfNotNull("industry", industry);
    addIfNotNull("selectedStates", selectedStates);
    addIfNotNull("selectedCities", selectedCities);
    addIfNotNull("frequency", frequency);

    // Investor parameters
    addIfNotNull("profile", type);
    addIfNotNull("investmentInterest", investmentInterest);
    addIfNotNull("investmentHorizon", investmentHorizon);
    addIfNotNull("riskTolerance", riskTolerance);
    addIfNotNull("priorExperience", priorExperience);

    // Franchise parameters
    addIfNotNull("buyOrStart", buyOrStart);
    addIfNotNull("franchiseTypes", franchiseTypes);
    addIfNotNull("brands", brands);

    // Advisor parameters
    addIfNotNull("expertise", expertise);
    addIfNotNull("clientType", clientType);
    addIfNotNull("experience", experience);
    addIfNotNull("advisoryDuration", advisoryDuration);

    try {
      var response = await client.post(
        Uri.parse(ApiList.questionnaire!),
        headers: {
          'Content-Type': 'application/json',
          'token': token,
        },
        body: jsonEncode(requestBody),
      );

      log('Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        return responseBody['status'] ?? false;
      } else {
        log('Failed to submit questionnaire: ${response.statusCode}');
        return false;
      }
    } on SocketException catch (e) {
      log('SocketException: ${e.message}');
      return null;
    } on http.ClientException catch (e) {
      log('ClientException: ${e.message}');
      return null;
    } catch (e) {
      log('Unexpected error: $e');
      return null;
    }
  }
}