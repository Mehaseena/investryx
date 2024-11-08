// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../api_list.dart';
//
// class InvestorFetchPage {
//   static var client = http.Client();
//
//   static Future<List<Investor>?> fetchInvestorData() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userId = prefs.getInt('userId');
//       if (userId == null) {
//         log('Error: userId not found in SharedPreferences');
//         return null;
//       }
//
//       var response = await client.get(Uri.parse('${ApiList.investorAddPage!}$userId'));
//
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body) as List;
//         List<Investor> investors = data.map((json) => Investor.fromJson(json)).toList();
//         return investors;
//       } else {
//         log('Failed to fetch investor data: ${response.statusCode}');
//         return null;
//       }
//     } on SocketException catch (e) {
//       log('SocketException: ${e.message}');
//       return null;
//     } on http.ClientException catch (e) {
//       log('ClientException: ${e.message}');
//       return null;
//     } catch (e) {
//       log('Unexpected error: $e');
//       return null;
//     }
//   }
// }
//
// class Investor {
//   final String imageUrl;
//   final String name;
//   final String location;
//   final String postedTime;
//   final String? state;
//   final String? industry;
//   final String? description;
//   final String? url;
//   final String? rangeStarting;
//   final String? rangeEnding;
//   final String? evaluatingAspects;
//   final String? companyName; // Added companyName field
//
//   Investor({
//     required this.imageUrl,
//     required this.name,
//     required this.location,
//     required this.postedTime,
//     this.state,
//     this.industry,
//     this.description,
//     this.url,
//     this.rangeStarting,
//     this.rangeEnding,
//     this.evaluatingAspects,
//     this.companyName,
//   });
//
//   factory Investor.fromJson(Map<String, dynamic> json) {
//     return Investor(
//       imageUrl: validateUrl(json['image1']) ?? 'https://via.placeholder.com/400x200',
//       name: json['name'] ?? 'N/A',
//       location: json['city'] ?? 'N/A',
//       postedTime: json['listed_on'] ?? 'N/A',
//       state: json['state'],
//       industry: json['industry'],
//       description: json['description'],
//       url: json['url'],
//       rangeStarting: json['range_starting']?.toString(),
//       rangeEnding: json['range_ending']?.toString(),
//       evaluatingAspects: json['evaluating_aspects'],
//       companyName: json['company'],
//     );
//   }
//
//   static String? validateUrl(String? url) {
//     const String baseUrl = 'https://suhail101.pythonanywhere.com/';
//
//     if (url == null || url.isEmpty) {
//       return null;
//     }
//
//     Uri? uri;
//     try {
//       uri = Uri.parse(url);
//       if (!uri.hasScheme) {
//         // If the URL doesn't have a scheme, assume it's a relative path and append the base URL.
//         url = url.startsWith('/') ? url.substring(1) : url;
//         url = baseUrl + url;
//         uri = Uri.parse(url);
//       }
//       if (uri.hasScheme && (uri.hasAuthority || uri.host.isNotEmpty)) {
//         return url;
//       }
//     } catch (e) {
//       return null;
//     }
//     return null;
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';  // Import Flutter Secure Storage
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_list.dart';

class InvestorFetchPage {
  static var client = http.Client();
  static final storage = FlutterSecureStorage();  // Initialize Flutter Secure Storage

  static Future<List<Investor>?> fetchInvestorData() async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        log('Error: token not found in Flutter Secure Storage');
        return null;
      }

      final response = await client.get(
        Uri.parse('${ApiList.investorAddPage!}${1}'),
        headers: {
          'token': token,  // Add token to request headers
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        List<Investor> investors = data.map((json) => Investor.fromJson(json)).toList();
        return investors;
      } else {
        log('Failed to fetch investor data: ${response.statusCode}');
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

  static Future<void> deleteInvestor(String investorId) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        log('Error: token not found in Flutter Secure Storage');
        throw Exception('Token not found');
      }

      var response = await client.delete(
        Uri.parse('${ApiList.investorAddPage!}$investorId'),
        headers: {
          'token': token,  // Add token to request headers
        },
      );

      if (response.statusCode == 200) {
        log('Investor deleted successfully');
      } else {
        log('Failed to delete investor: ${response.statusCode}');
        throw Exception('Failed to delete investor');
      }
    } on SocketException catch (e) {
      log('SocketException: ${e.message}');
      throw Exception('No Internet connection');
    } on http.ClientException catch (e) {
      log('ClientException: ${e.message}');
      throw Exception('Client error');
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('Unexpected error');
    }
  }

  static Future<void> deleteInvestorProfile() async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        log('Error: token not found in Flutter Secure Storage');
        throw Exception('Token not found');
      }

      var response = await client.delete(
        Uri.parse('${ApiList.investorAddPage!}${0}'),
        headers: {
          'token': token,  // Add token to request headers
        },
      );

      if (response.statusCode == 200) {
        log('Investor deleted successfully');
      } else {
        log('Failed to delete investor: ${response.statusCode}');
        throw Exception('Failed to delete investor');
      }
    } on SocketException catch (e) {
      log('SocketException: ${e.message}');
      throw Exception('No Internet connection');
    } on http.ClientException catch (e) {
      log('ClientException: ${e.message}');
      throw Exception('Client error');
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('Unexpected error');
    }
  }
}

class Investor {
  final String id; // Add an id field
  final String imageUrl;
  final String image2;
  final String image3;
  final String image4;
  final String name;
  final String city;
  final String postedTime;
  final String? state;
  final String? industry;
  final String? description;
  final String? url;
  final String? rangeStarting;
  final String? locationIntrested;
  final String? rangeEnding;
  final String? evaluatingAspects;
  final String? companyName; // Added companyName field
  final String? businessDocument;
  final String? businessProof;


  Investor({
    required this.id, // Initialize the id field
    required this.imageUrl,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.name,
    required this.city,
    required this.postedTime,
    this.state,
    this.industry,
    this.description,
    this.url,
    this.rangeStarting,
    this.rangeEnding,
    this.evaluatingAspects,
    this.companyName,
    this.locationIntrested,
    this.businessDocument,
    this.businessProof,

  });

  factory Investor.fromJson(Map<String, dynamic> json) {
    return Investor(
      id: json['id'].toString(), // Convert id to string
      imageUrl: validateUrl(json['image1']) ?? 'https://via.placeholder.com/400x200',
      image2: validateUrl(json['image2']) ?? 'https://via.placeholder.com/400x200',
      image3: validateUrl(json['image3']) ?? 'https://via.placeholder.com/400x200',
      image4: validateUrl(json['image4']) ?? 'https://via.placeholder.com/400x200',
      name: json['name'] ?? 'N/A',
      city: json['city'] ?? 'N/A',
      postedTime: json['listed_on'] ?? 'N/A',
      state: json['state'],
      industry: json['industry'],
      description: json['description'],
      url: json['url'],
      rangeStarting: json['range_starting']?.toString(),
      rangeEnding: json['range_ending']?.toString(),
      evaluatingAspects: json['evaluating_aspects'],
      companyName: json['company'],
      locationIntrested: json['location_interested'],
      businessDocument: validateUrl(json['doc1']) ?? 'https://via.placeholder.com/400x200',
      businessProof: validateUrl(json['proof1']) ?? 'https://via.placeholder.com/400x200',


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
        // If the URL doesn't have a scheme, assume it's a relative path and append the base URL.
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
