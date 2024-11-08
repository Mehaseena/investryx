import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'api_list.dart';



class PlansGet {
  static var client = http.Client();
  static final storage = FlutterSecureStorage(); // Create a secure storage instance


  static Future<List<Map<String, dynamic>>?> fetchPlans() async {
    try {
      final token = await storage.read(key: 'token');

      if (token == null) {
        log('Error: Token not found in secure storage');
        return null;
      }

      var response = await client.get(
        Uri.parse(ApiList.pricing!),
        headers: {
          'Content-Type': 'application/json',
          'token' : token
        },
      );
      print('Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> responseBody = json.decode(response.body);
        List<Map<String, dynamic>> plans = responseBody.cast<Map<String, dynamic>>();
        return plans;
      } else {
        debugPrint('Failed to fetch plans: ${response.statusCode}');
        return null;
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: ${e.message}');
      return null;
    } on http.ClientException catch (e) {
      debugPrint('ClientException: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return null;
    }
  }
}
