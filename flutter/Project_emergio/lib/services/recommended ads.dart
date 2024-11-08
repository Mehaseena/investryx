import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/all profile model.dart';
import 'api_list.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RecommendedAds {
  static var client = http.Client();
  static final storage =
  FlutterSecureStorage(); // Create a secure storage instance

  // Method for fetching recommended items
  static Future<Map<String, dynamic>?> fetchRecommended() async {
    try {
      // Retrieve the token from Flutter secure storage
      String? token = await storage.read(key: 'token');

      if (token == null) {
        log('Error: Token not found in secure storage');
        return {
          "status": "loggedout"
        }; // Handle the case where the token is missing
      }

      var response = await client.get(
        Uri.parse('${ApiList.recommended}'),
        headers: {
          'Content-Type': 'application/json',
          'token': token,
        },
      );

      print(
          'Response: fetching recommended  ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        if (decodedResponse is Map<String, dynamic> &&
            decodedResponse.containsKey('status') &&
            decodedResponse['status'] == false) {
          if (decodedResponse['message'] == "User doesnot exist") {
            return {"status": "loggedout"};
          }

          return {"error": decodedResponse['message']};
        } else {
          var data = jsonDecode(response.body) as List;
          List<ProductDetails> recommendedItems =
          data.map((json) => ProductDetails.fromJson(json)).toList();
          List<BusinessInvestorExplr> recommendedAllItems =
          data.map((json) => BusinessInvestorExplr.fromJson(json)).toList();
          List<FranchiseExplr> recommendedFranchiseItems =
          data.map((json) => FranchiseExplr.fromJson(json)).toList();

          List<AdvisorExplr> allAdvisors =
          data.map((json) => AdvisorExplr.fromJson(json)).toList();

          List<ProductDetails> businessRecommended = recommendedItems
              .where((product) => product.type == "business")
              .toList();
          List<ProductDetails> investorRecommended = recommendedItems
              .where((product) => product.type == "investor")
              .toList();
          List<ProductDetails> franchiseRecommended = recommendedItems
              .where((product) => product.type == "franchise")
              .toList();

          List<BusinessInvestorExplr> businessData = recommendedAllItems
              .where((data) => data.entityType == "business")
              .toList();
          List<BusinessInvestorExplr> investorData = recommendedAllItems
              .where((data) => data.entityType == "investor")
              .toList();
          List<FranchiseExplr> franchiseData = recommendedFranchiseItems
              .where((data) => data.entityType == "franchise")
              .toList();

          List<FranchiseExplr> advisorData = recommendedFranchiseItems
              .where((data) => data.entityType == "advisor")
              .toList();


          return {
            "recommended": recommendedItems,
            "recommendedAll": recommendedAllItems,
            "recommendedFranchiseItems": recommendedFranchiseItems,
            "business_recommended": businessRecommended,
            "investor_recommended": investorRecommended,
            "franchise_recommended": franchiseRecommended,
            "business_data": businessData,
            "investor_data": investorData,
            "franchise_data": franchiseData,
            "advisor_data": advisorData
          };
        }
      } else {
        log('Failed to fetch recommended data: ${response.statusCode}');
        return null;
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

class ProductDetails {
  final String id;
  final String imageUrl;
  final String name;
  final String city;
  final String postedTime;
  final String type;

  ProductDetails({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.type,
    required this.city,
    required this.postedTime,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      type: json['entity_type'].toString(),
      id: json['id'].toString(),
      imageUrl:
      validateUrl(json['image1']) ?? 'https://via.placeholder.com/400x200',
      name: json['name'] ?? 'N/A',
      city: json['city'] ?? json['locations_available'],
      postedTime: json['listed_on'] ?? 'N/A',
    );
  }

  static String? validateUrl(String? url) {
    const String baseUrl = 'https://investryx.com/';

    if (url == null || url.isEmpty) {
      return null;
    }

    Uri? uri;
    try {
      uri = Uri.parse(url);
      if (!uri.hasScheme) {
        url = url.startsWith('/') ? url.substring(1) : url;
        url = baseUrl + url;
        uri = Uri.parse(url);
      }
      if (uri.hasScheme && (uri.hasAuthority || uri.host.isNotEmpty)) {
        return url;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}

