import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:project_emergio/models/all%20profile%20model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_list.dart';

class LatestTransactions {
  static var client = http.Client();

  // Method for fetching items
  static Future<List<LatestActivites>?> fetchLatestTransactions() async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'token');

      if (token == null) {
        log('Error: Token not found in secure storage');
        return null;
      }

      var response = await client.get(
        Uri.parse('${ApiList.latestTransactions}'),
        headers: {
          'Content-Type': 'application/json',
          'token': token, // Pass the token in the header
        },
      );
      print('Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        List<LatestActivites> wishlistItems =
        data.map((json) => LatestActivites.fromJson(json)).toList();
        return wishlistItems;
      } else {
        log('Failed to fetch latest transactions and activities data: ${response.statusCode}');
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

  // Method for recet posts in business
  static Future<Map<String, dynamic>?> fetchRecentPosts(String? profile) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'token');

      if (token == null) {
        log('Error: Token not found in secure storage');
        return null;
      }
      List<BusinessInvestorExplr> investors = [];
      List<BusinessInvestorExplr> businesses = [];
      List<FranchiseExplr> franchises = [];

      final Uri url;
      if (profile == "") {
        url = Uri.parse(ApiList.latestPost);
      } else {
        url = Uri.parse('${ApiList.latestPost}?type=$profile');
      }

      var response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': token, // Pass the token in the header
        },
      );
      print(
          'Response: fetch latest posts ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;

        if (profile == "") {
          for (var item in data) {
            switch (item['entity_type']) {
              case 'investor':
                investors.add(BusinessInvestorExplr.fromJson(item));
                break;
              case 'business':
                businesses.add(BusinessInvestorExplr.fromJson(item));
                break;
              case 'franchise':
                franchises.add(FranchiseExplr.fromJson(item));
                break;
            }
          }
          List<LatestActivites> homeRecents =
          data.map((json) => LatestActivites.fromJson(json)).toList();

          return {
            "business": businesses,
            "investors": investors,
            "franchises": franchises,
            "home_data": homeRecents,
          };
        } else {
          List<FranchiseExplr> franchisePosts =
          data.map((json) => FranchiseExplr.fromJson(json)).toList();
          List<BusinessInvestorExplr> investorPosts =
          data.map((json) => BusinessInvestorExplr.fromJson(json)).toList();
          List<BusinessInvestorExplr> businessPosts =
          data.map((json) => BusinessInvestorExplr.fromJson(json)).toList();

          List<LatestActivites> homeRecents =
          data.map((json) => LatestActivites.fromJson(json)).toList();

          List<AdvisorExplr> advisorPosts =
          data.map((json) => AdvisorExplr.fromJson(json)).toList();

          return {
            "business_data": businessPosts,
            "investor_data": investorPosts,
            "franchise_data": franchisePosts,
            "home_data": homeRecents,
            "advisor_data": advisorPosts
          };
        }
      } else {
        log('Failed to fetch latest transactions and activities data: ${response.statusCode}');
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

  // Method for recet posts in investor
  static Future<List<BusinessInvestorExplr>?> fetchRecentInvestors(
      String? profile) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'token');

      if (token == null) {
        log('Error: Token not found in secure storage');
        return null;
      }

      var response = await client.get(
        Uri.parse('${ApiList.latestPost}?type=business'),
        headers: {
          'Content-Type': 'application/json',
          'token': token, // Pass the token in the header
        },
      );
      print('Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        List<BusinessInvestorExplr> investorPosts =
        data.map((json) => BusinessInvestorExplr.fromJson(json)).toList();

        return investorPosts;
      } else {
        log('Failed to fetch latest transactions and activities data: ${response.statusCode}');
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

  // Method for fetching featured items
  static Future<Map<String, dynamic>?> fetchFeaturedLists(
      {required String profile}) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'token');

      if (token == null) {
        log('Error: Token not found in secure storage');
        return null;
      }

      final Uri url;
      if (profile == "") {
        url = Uri.parse(ApiList.featured!);
      } else {
        url = Uri.parse("${ApiList.featured}?type=$profile");
      }

      var response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': token, // Pass the token in the header
        },
      );
      print('Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;

        List<BusinessInvestorExplr> businessFeatured =
        data.map((json) => BusinessInvestorExplr.fromJson(json)).toList();
        List<BusinessInvestorExplr> investorFeatured =
        data.map((json) => BusinessInvestorExplr.fromJson(json)).toList();
        List<FranchiseExplr> franchiseFeatured =
        data.map((json) => FranchiseExplr.fromJson(json)).toList();

        return {
          "business_data": businessFeatured,
          "investor_data": investorFeatured,
          "franchise_data": franchiseFeatured
        };
      } else {
        log('Failed to fetch latest transactions and activities data: ${response.statusCode}');
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

class LatestActivites {
  final String title;
  final String username;
  final String imageUrl;
  final String user;
  final String description;
  final String postedTime;
  final String city;
  final String name;
  final String type;
  final String id;

  LatestActivites(
      {required this.title,
        required this.username,
        required this.imageUrl,
        required this.user,
        required this.description,
        required this.postedTime,
        required this.name,
        required this.type,
        required this.city,
        required this.id});

  factory LatestActivites.fromJson(Map<String, dynamic> json) {
    return LatestActivites(
        id: json["id"].toString(),
        type: json["entity_type"],
        title: json['title']?.toString() ?? 'NA',
        imageUrl: validateUrl(json['image1']) ??
            'https://via.placeholder.com/400x200',
        user: json['user']?.toString() ?? 'N/A',
        username: json['username']?.toString() ?? 'N/A',
        description: json['description']?.toString() ?? 'NA',
        postedTime: json['timestamp']?.toString() ?? 'N/A',
        city: json["city"] ?? "N/A",
        name: json["name"] ?? "N/A");
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
