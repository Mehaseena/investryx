// import 'dart:developer';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../api_list.dart';
// import 'package:path/path.dart';
// class BusinessGet {
//   static var client = http.Client();
//
//   static Future<List<Business>?> fetchBusinessListings() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userId = prefs.getInt('userId');
//       if (userId == null) {
//         log('Error: userId not found in SharedPreferences');
//         return null;
//       }
//
//       var response =
//           await client.get(Uri.parse('${ApiList.businessAddPage!}$userId'));
//       log('Response: ${response.statusCode} - ${response.body}');
//
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body) as List;
//         List<Business> businesses =
//             data.map((json) => Business.fromJson(json)).toList();
//         return businesses;
//       } else {
//         log('Failed to fetch business listings: ${response.statusCode}');
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
//
//   static Future<void> deleteBusiness(String businessId) async {
//     try {
//       var response = await client
//           .delete(Uri.parse('${ApiList.businessAddPage!}$businessId?'));
//
//       if (response.statusCode == 200) {
//         log('Business deleted successfully');
//       } else {
//         log('Failed to delete Business: ${response.statusCode}');
//         throw Exception('Failed to delete Business');
//       }
//     } on SocketException catch (e) {
//       log('SocketException: ${e.message}');
//       throw Exception('No Internet connection');
//     } on http.ClientException catch (e) {
//       log('ClientException: ${e.message}');
//       throw Exception('Client error');
//     } catch (e) {
//       log('Unexpected error: $e');
//       throw Exception('Unexpected error');
//     }
//   }
//
//   static Future<void> deleteBusinessProfile(String businessId) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userId = prefs.getInt('userId');
//       if (userId == null) {
//         log('Error: userId not found in SharedPreferences');
//         return null;
//       }
//       var businessId = 0;
//       var response = await client.delete(
//           Uri.parse('${ApiList.businessAddPage!}$businessId?userId=$userId'));
//       print('Response: ${response.statusCode} - ${response.body}');
//
//       if (response.statusCode == 200) {
//         log('Business deleted successfully');
//       } else {
//         log('Failed to delete Business: ${response.statusCode}');
//         throw Exception('Failed to delete Business');
//       }
//     } on SocketException catch (e) {
//       log('SocketException: ${e.message}');
//       throw Exception('No Internet connection');
//     } on http.ClientException catch (e) {
//       log('ClientException: ${e.message}');
//       throw Exception('Client error');
//     } catch (e) {
//       log('Unexpected error: $e');
//       throw Exception('Unexpected error');
//     }
//   }
//
// // New method for updating a business
//   static Future<void> updateBusiness({
//     required String id,
//     required String imageUrl,
//     required String name,
//     String? industry,
//     String? establish_yr,
//     String? description,
//     String? address_1,
//     String? address_2,
//     String? pin,
//     required String city,
//     String? state,
//     String? employees,
//     String? entity,
//     String? avg_monthly,
//     String? latest_yearly,
//     String? ebitda,
//     String? rate,
//     String? type_sale,
//     String? url,
//     String? features,
//     String? facility,
//     String? income_source,
//     String? reason,
//     required String postedTime,
//     required String topSelling,
//     required File image1,
//     required File doc1,
//     required File proof1,
//   }) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userId = prefs.getInt('userId');
//       if (userId == null) {
//         log('Error: userId not found in SharedPreferences');
//         return;
//       }
//
//       // Prepare multipart request
//       var request = http.MultipartRequest(
//         'PUT',
//         Uri.parse('${ApiList.businessAddPage!}$id'),
//       );
//
//
//       // Add fields to the request
//       request.fields['name'] = name;
//       request.fields['industry'] = industry ?? '';
//       request.fields['establish_yr'] = establish_yr ?? '';
//       request.fields['description'] = description ?? '';
//       request.fields['address_1'] = address_1 ?? '';
//       request.fields['address_2'] = address_2 ?? '';
//       request.fields['pin'] = pin ?? '';
//       request.fields['city'] = city;
//       request.fields['state'] = state ?? '';
//       request.fields['employees'] = employees ?? '';
//       request.fields['entity'] = entity ?? '';
//       request.fields['avg_monthly'] = avg_monthly ?? '';
//       request.fields['latest_yearly'] = latest_yearly ?? '';
//       request.fields['ebitda'] = ebitda ?? '';
//       request.fields['rate'] = rate ?? '';
//       request.fields['type_sale'] = type_sale ?? '';
//       request.fields['url'] = url ?? '';
//       request.fields['features'] = features ?? '';
//       request.fields['facility'] = facility ?? '';
//       request.fields['income_source'] = income_source ?? '';
//       request.fields['reason'] = reason ?? '';
//       request.fields['listed_on'] = postedTime;
//       request.fields['top_selling'] = topSelling;
//       request.fields['userId'] = userId.toString();
//
//       // Add files to the request
//
//       if (image1 != null && image1.existsSync()) {
//         request.files.add(await http.MultipartFile.fromPath(
//           'image1',
//           image1.path,
//           filename: basename(image1.path),
//         ));
//       }
//       if (doc1 != null && doc1.existsSync()) {
//         request.files.add(await http.MultipartFile.fromPath(
//           'doc1',
//           doc1.path,
//           filename: basename(doc1.path),
//         ));
//       }
//       if (proof1 != null && proof1.existsSync()) {
//         request.files.add(await http.MultipartFile.fromPath(
//           'proof1',
//           proof1.path,
//           filename: basename(proof1.path),
//         ));
//       }
//       // Send the request
//       var response = await request.send();
//       print('Response: ${response.statusCode}');
//       // Handle the response
//       if (response.statusCode == 200) {
//         log('Business updated successfully!');
//         var responseString = await response.stream.bytesToString();
//         log('Response: $responseString');
//       } else {
//         log('Failed to update Business: ${response.statusCode}');
//         throw Exception('Failed to update Business');
//       }
//     } on SocketException catch (e) {
//       log('SocketException: ${e.message}');
//       throw Exception('No Internet connection');
//     } on http.ClientException catch (e) {
//       log('ClientException: ${e.message}');
//       throw Exception('Client error');
//     } catch (e) {
//       log('Unexpected error: $e');
//       throw Exception('Unexpected error');
//     }
//   }
// }
//
// class Business {
//   final String id;
//   final String imageUrl;
//   final String name;
//   final String? industry;
//   final String? establish_yr;
//   final String? description;
//   final String? address_1;
//   final String? address_2;
//   final String? pin;
//   final String city;
//   final String? state;
//   final String? employees;
//   final String? entity;
//   final String? avg_monthly;
//   final String? latest_yearly;
//   final String? ebitda;
//   final String? rate;
//   final String? type_sale;
//   final String? url;
//   final String? features;
//   final String? facility;
//   final String? income_source;
//   final String? reason;
//   final String postedTime;
//   final String topSelling;
//
//   Business({
//     required this.imageUrl,
//     required this.name,
//     this.industry,
//     required this.id,
//     this.establish_yr,
//     this.description,
//     this.address_1,
//     this.address_2,
//     this.pin,
//     required this.city,
//     this.state,
//     this.employees,
//     this.entity,
//     this.avg_monthly,
//     this.latest_yearly,
//     this.ebitda,
//     this.rate,
//     this.type_sale,
//     this.url,
//     this.features,
//     this.facility,
//     this.income_source,
//     this.reason,
//     required this.postedTime,
//     required this.topSelling,
//   });
//
//   factory Business.fromJson(Map<String, dynamic> json) {
//     return Business(
//       imageUrl:
//           validateUrl(json['image1']) ?? 'https://via.placeholder.com/400x200',
//       name: json['name']?.toString() ?? 'N/A',
//       id: json['id']?.toString() ?? 'N/A',
//       industry: json['industry']?.toString() ?? 'N/A',
//       establish_yr: json['establish_yr']?.toString() ?? 'N/A',
//       description: json['description']?.toString() ?? 'N/A',
//       address_1: json['address_1']?.toString() ?? 'N/A',
//       address_2: json['address_2']?.toString() ?? 'N/A',
//       pin: json['pin']?.toString() ?? 'N/A',
//       city: json['city']?.toString() ?? 'N/A',
//       state: json['state']?.toString() ?? 'N/A',
//       employees: json['employees']?.toString() ?? 'N/A',
//       entity: json['entity']?.toString() ?? 'N/A',
//       avg_monthly: json['avg_monthly']?.toString() ?? 'N/A',
//       latest_yearly: json['latest_yearly']?.toString() ?? 'N/A',
//       ebitda: json['ebitda']?.toString() ?? 'N/A',
//       rate: json['range_starting']?.toString() ?? 'N/A',
//       type_sale: json['type_sale']?.toString() ?? 'N/A',
//       url: json['url']?.toString() ?? 'N/A',
//       features: json['features']?.toString() ?? 'N/A',
//       facility: json['facility']?.toString() ?? 'N/A',
//       income_source: json['income_source']?.toString() ?? 'N/A',
//       reason: json['reason']?.toString() ?? 'N/A',
//       postedTime: json['listed_on']?.toString() ?? 'N/A',
//       topSelling: json['top_selling']?.toString() ?? 'N/A',
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'image1': imageUrl,
//       'name': name,
//       'industry': industry,
//       'establish_yr': establish_yr,
//       'description': description,
//       'address_1': address_1,
//       'address_2': address_2,
//       'pin': pin,
//       'city': city,
//       'state': state,
//       'employees': employees,
//       'entity': entity,
//       'avg_monthly': avg_monthly,
//       'latest_yearly': latest_yearly,
//       'ebitda': ebitda,
//       'range_starting': rate,
//       'type_sale': type_sale,
//       'url': url,
//       'features': features,
//       'facility': facility,
//       'income_source': income_source,
//       'reason': reason,
//       'listed_on': postedTime,
//       'top_selling': topSelling,
//     };
//   }
//
//   // Define the validateUrl method
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
//
// }


import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import for secure storage
import '../../api_list.dart';
import 'package:path/path.dart';

class BusinessGet {
  static var client = http.Client();
  static final storage = FlutterSecureStorage(); // Initialize secure storage

  static Future<List<Business>?> fetchBusinessListings() async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        log('Error: Token not found in secure storage');
        return null;
      }

      var response = await client.get(
        Uri.parse('${ApiList.businessAddPage!}${1}'),
        headers: {
          'token': token,
        },
      );
      log('Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        List<Business> businesses =
        data.map((json) => Business.fromJson(json)).toList();
        return businesses;
      } else {
        log('Failed to fetch business listings: ${response.statusCode}');
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

  static Future<Business?> fetchSingleBusiness(String businessId) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        log('Error: Token not found in secure storage');
        return null;
      }

      var response = await client.get(
        Uri.parse('${ApiList.businessAddPage!}$businessId'),
        headers: {
          'token': token,
        },
      );
      log('Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data is List) {
          // If the response is a list, find the business with the matching ID
          var businessData = data.firstWhere(
                  (item) => item['id'].toString() == businessId,
              orElse: () => null
          );
          if (businessData != null) {
            return Business.fromJson(businessData);
          } else {
            log('Business not found in the response list');
            return null;
          }
        } else if (data is Map<String, dynamic>) {
          // If the response is a single object, use it directly
          return Business.fromJson(data);
        } else {
          log('Unexpected response format');
          return null;
        }
      } else {
        log('Failed to fetch business: ${response.statusCode}');
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
  static Future<void> deleteBusiness(String businessId) async {
    try {
      final token = await storage.read(key: 'token'); // Read token from secure storage
      if (token == null) {
        log('Error: Token not found in secure storage');
        return;
      }

      var response = await client.delete(
        Uri.parse('${ApiList.businessAddPage!}$businessId?'),
        headers: {
          'token': token,
        },
      );

      if (response.statusCode == 200) {
        log('Business deleted successfully');
      } else {
        log('Failed to delete Business: ${response.statusCode}');
        throw Exception('Failed to delete Business');
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

  static Future<void> deleteBusinessProfile(String businessId) async {
    try {
      final token = await storage.read(key: 'token'); // Read token from secure storage
      if (token == null) {
        log('Error: Token not found in secure storage');
        return;
      }

      var response = await client.delete(
        Uri.parse('${ApiList.businessAddPage!}${0}'),
        headers: {
          'token': token,
        },
      );
      log('Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        log('Business deleted successfully');
      } else {
        log('Failed to delete Business: ${response.statusCode}');
        throw Exception('Failed to delete Business');
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

  static Future<void> updateBusiness({
    required String id,
    required String name,
    String? industry,
    String? establish_yr,
    String? description,
    String? address_1,
    String? address_2,
    String? pin,
    required String city,
    String? state,
    String? employees,
    String? entity,
    String? avg_monthly,
    String? latest_yearly,
    String? ebitda,
    String? rate,
    String? type_sale,
    String? url,
    String? features,
    String? facility,
    String? income_source,
    String? reason,
    required String topSelling,
    required File image1,
    File? image2,
    File? image3,
    File? image4,
    required File doc1,
    required File proof1,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        log('Error: Token not found in secure storage');
        return;
      }

      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('${ApiList.businessAddPage!}$id'),
      );

      // Add all the text fields
      request.fields['name'] = name;
      request.fields['industry'] = industry ?? '';
      request.fields['establish_yr'] = establish_yr ?? '';
      request.fields['description'] = description ?? '';
      request.fields['address_1'] = address_1 ?? '';
      request.fields['address_2'] = address_2 ?? '';
      request.fields['pin'] = pin ?? '';
      request.fields['city'] = city;
      request.fields['state'] = state ?? '';
      request.fields['employees'] = employees ?? '';
      request.fields['entity'] = entity ?? '';
      request.fields['avg_monthly'] = avg_monthly ?? '';
      request.fields['latest_yearly'] = latest_yearly ?? '';
      request.fields['ebitda'] = ebitda ?? '';
      request.fields['rate'] = rate ?? '';
      request.fields['type_sale'] = type_sale ?? '';
      request.fields['url'] = url ?? '';
      request.fields['features'] = features ?? '';
      request.fields['facility'] = facility ?? '';
      request.fields['income_source'] = income_source ?? '';
      request.fields['reason'] = reason ?? '';
      request.fields['top_selling'] = topSelling;

      // Add image files to the request
      if (image1.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'image1',
          image1.path,
          filename: basename(image1.path),
        ));
      }
      if (image2 != null && image2.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'image2',
          image2.path,
          filename: basename(image2.path),
        ));
      }
      if (image3 != null && image3.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'image3',
          image3.path,
          filename: basename(image3.path),
        ));
      }
      if (image4 != null && image4.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'image4',
          image4.path,
          filename: basename(image4.path),
        ));
      }

      // Add document and proof files
      if (doc1.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'doc1',
          doc1.path,
          filename: basename(doc1.path),
        ));
      }
      if (proof1.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'proof1',
          proof1.path,
          filename: basename(proof1.path),
        ));
      }

      request.headers['token'] = token;

      var response = await request.send();
      log('Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        log('Business updated successfully!');
        var responseString = await response.stream.bytesToString();
        log('Response: $responseString');
      } else {
        log('Failed to update Business: ${response.statusCode}');
        throw Exception('Failed to update Business');
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

class Business {
  final String id;
  final String imageUrl;
  final String image2;
  final String image3;
  final String image4;
  final String name;
  final String? industry;
  final String? establish_yr;
  final String? description;
  final String? address_1;
  final String? address_2;
  final String? pin;
  final String city;
  final String? state;
  final String? employees;
  final String? entity;
  final String? avg_monthly;
  final String? latest_yearly;
  final String? ebitda;
  final String? rate;
  final String? type_sale;
  final String? url;
  final String? features;
  final String? facility;
  final String? income_source;
  final String? reason;
  final String postedTime;
  final String topSelling;
  final String? businessDocument;
  final String? businessProof;
  // final String? user;

  Business({
    required this.imageUrl,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.name,
    this.industry,
    required this.id,
    this.establish_yr,
    this.description,
    this.address_1,
    this.address_2,
    this.pin,
    required this.city,
    this.state,
    this.employees,
    this.entity,
    this.avg_monthly,
    this.latest_yearly,
    this.ebitda,
    this.rate,
    this.type_sale,
    this.url,
    this.features,
    this.facility,
    this.income_source,
    this.reason,
    required this.postedTime,
    required this.topSelling,
    this.businessDocument,
    this.businessProof,
    // this.user,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      imageUrl: validateUrl(json['image1']) ?? 'https://via.placeholder.com/400x200',
      image2: validateUrl(json['image2']) ?? 'https://via.placeholder.com/400x200',
      image3: validateUrl(json['image3']) ?? 'https://via.placeholder.com/400x200',
      image4: validateUrl(json['image4']) ?? 'https://via.placeholder.com/400x200',
      name: json['name']?.toString() ?? 'N/A',
      id: json['id']?.toString() ?? 'N/A',
      industry: json['industry']?.toString(),
      establish_yr: json['establish_yr']?.toString(),
      description: json['description']?.toString(),
      address_1: json['address_1']?.toString(),
      address_2: json['address_2']?.toString(),
      pin: json['pin']?.toString(),
      city: json['city']?.toString() ?? 'N/A',
      state: json['state']?.toString(),
      employees: json['employees']?.toString(),
      entity: json['entity']?.toString(),
      avg_monthly: json['avg_monthly']?.toString(),
      latest_yearly: json['latest_yearly']?.toString(),
      ebitda: json['ebitda']?.toString(),
      rate: json['range_starting']?.toString(),
      type_sale: json['type_sale']?.toString(),
      url: json['url']?.toString(),
      features: json['features']?.toString(),
      facility: json['facility']?.toString(),
      income_source: json['income_source']?.toString(),
      reason: json['reason']?.toString(),
      postedTime: json['listed_on']?.toString() ?? 'N/A',
      topSelling: json['top_selling']?.toString() ?? 'N/A',
      // user: json['user']['id'].toString(),
      businessDocument: validateUrl(json['doc1']) ?? 'https://via.placeholder.com/400x200',
      businessProof: validateUrl(json['proof1']) ?? 'https://via.placeholder.com/400x200',
    );
  }
  static String? validateUrl(String? urls) {
    const String baseUrl = 'https://investryx.com/';

    if (urls == null || urls.isEmpty) {
      return null;
    }

    Uri? uri;
    try {
      uri = Uri.parse(urls);
      if (!uri.hasScheme) {
        urls = urls.startsWith('/') ? urls.substring(1) : urls;
        urls = baseUrl + urls;
        uri = Uri.parse(urls);
      }
      if (uri.hasScheme && (uri.hasAuthority || uri.host.isNotEmpty)) {
        return urls;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

}

