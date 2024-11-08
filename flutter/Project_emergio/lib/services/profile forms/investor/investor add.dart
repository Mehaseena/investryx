// import 'dart:developer';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path/path.dart';
// import '../../api_list.dart';
//
// class InvestorAddPage {
//   static var client = http.Client();
//
//   static Future<bool?> investorAddPage({
//     required String name,
//     required String companyName,
//     required String industry,
//     required String description,
//     required String state,
//     required String city,
//     required String url,
//     required String rangeStarting,
//     required String rangeEnding,
//     required String evaluatingAspects,
//     required String locationInterested,
//     required File image1,
//     required File doc1,
//     required File proof1,
//   }) async {
//     try {
//       // Retrieve userId from SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       final userId = prefs.getInt('userId');
//       if (userId == null) {
//         log('Error: userId not found in SharedPreferences');
//         return false;
//       }
//
//       // Create multipart request
//       var request =
//           http.MultipartRequest('POST', Uri.parse(ApiList.investorAddPage!));
//       request.fields['name'] = name;
//       request.fields['company'] = companyName;
//       request.fields['industry'] = industry;
//       request.fields['description'] = description;
//       request.fields['state'] = state;
//       request.fields['city'] = city;
//       request.fields['url'] = url;
//       request.fields['range_starting'] = rangeStarting;
//       request.fields['range_ending'] = rangeEnding;
//       request.fields['location_interested'] = locationInterested;
//       request.fields['evaluating_aspects'] = evaluatingAspects;
//       request.fields['userId'] = userId.toString();
//
//       // Add files to the request
//       request.files.add(await http.MultipartFile.fromPath('image1', image1.path,
//           filename: basename(image1.path)));
//       request.files.add(await http.MultipartFile.fromPath('doc1', doc1.path,
//           filename: basename(doc1.path)));
//       request.files.add(await http.MultipartFile.fromPath('proof1', proof1.path,
//           filename: basename(proof1.path)));
//
//       // Send the request
//       var response = await request.send();
//
//       // Handle the response
//       if (response.statusCode == 200) {
//         log('File uploaded successfully!');
//         var responseString = await response.stream.bytesToString();
//         log('Response: $responseString');
//         return true;
//       } else {
//         log('Failed to upload file: ${response.statusCode}');
//         return false;
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
//   static Future<bool?> updateInvestor({
//     required String investorId,
//     required String userId,
//     required String name,
//     required String companyName,
//     required String industry,
//     required String description,
//     required String state,
//     required String city,
//     required String url,
//     required String rangeStarting,
//     required String rangeEnding,
//     required String evaluatingAspects,
//     required String locationInterested,
//     required File image1,
//     required File doc1,
//     required File proof1,
//   }) async {
//     try {
//       // Retrieve userId from SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       final userId = prefs.getInt('userId');
//       if (userId == null) {
//         log('Error: userId not found in SharedPreferences');
//         return false;
//       }
//
//       // Create multipart request
//       var request = http.MultipartRequest(
//           'PUT', Uri.parse('${ApiList.investorAddPage}$investorId'));
//       request.fields['name'] = name;
//       request.fields['company'] = companyName;
//       request.fields['industry'] = industry;
//       request.fields['description'] = description;
//       request.fields['state'] = state;
//       request.fields['city'] = city;
//       request.fields['url'] = url;
//       request.fields['range_starting'] = rangeStarting;
//       request.fields['range_ending'] = rangeEnding;
//       request.fields['location_interested'] = locationInterested;
//       request.fields['evaluating_aspects'] = evaluatingAspects;
//       request.fields['userId'] = userId.toString();
//
//       // Add files to the request
//       request.files.add(await http.MultipartFile.fromPath('image1', image1.path,
//           filename: basename(image1.path)));
//       request.files.add(await http.MultipartFile.fromPath('doc1', doc1.path,
//           filename: basename(doc1.path)));
//       request.files.add(await http.MultipartFile.fromPath('proof1', proof1.path,
//           filename: basename(proof1.path)));
//
//       // Send the request
//       var response = await request.send();
//
//       // Handle the response
//       if (response.statusCode == 200) {
//         log('Investor information updated successfully!');
//         var responseString = await response.stream.bytesToString();
//         log('Response: $responseString');
//         return true;
//       } else {
//         log('Failed to update investor information: ${response.statusCode}');
//         return false;
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


import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';  // Import Flutter Secure Storage
import 'package:path/path.dart';
import '../../api_list.dart';

class InvestorAddPage {
  static var client = http.Client();
  static final storage = FlutterSecureStorage();  // Initialize Flutter Secure Storage

  static Future<bool?> investorAddPage({
    required String name,
    required String companyName,
    required String industry,
    required String description,
    required String state,
    required String city,
    required String url,
    required String rangeStarting,
    required String rangeEnding,
    required String evaluatingAspects,
    required String locationInterested,
    required File image1,
    required File image2,
    required File image3,
    required File image4,
    required File doc1,
    required File proof1,
  }) async {
    try {
      // Retrieve token from Flutter Secure Storage
      final token = await storage.read(key: 'token');
      if (token == null) {
        log('Error: token not found in Flutter Secure Storage');
        return false;
      }

      // Create multipart request
      var request = http.MultipartRequest('POST', Uri.parse(ApiList.investorAddPage!));
      request.headers['token'] = token;  // Add token to request headers
      request.fields['name'] = name;
      request.fields['company'] = companyName;
      request.fields['industry'] = industry;
      request.fields['description'] = description;
      request.fields['state'] = state;
      request.fields['city'] = city;
      request.fields['url'] = url;
      request.fields['range_starting'] = rangeStarting;
      request.fields['range_ending'] = rangeEnding;
      request.fields['location_interested'] = locationInterested;
      request.fields['evaluating_aspects'] = evaluatingAspects;

      // Add files to the request
      request.files.add(await http.MultipartFile.fromPath('image1', image1.path,
          filename: basename(image1.path)));
      request.files.add(await http.MultipartFile.fromPath('image2', image2.path,
          filename: basename(image2.path)));
      request.files.add(await http.MultipartFile.fromPath('image3', image3.path,
          filename: basename(image3.path)));
      request.files.add(await http.MultipartFile.fromPath('image4', image4.path,
          filename: basename(image4.path)));
      request.files.add(await http.MultipartFile.fromPath('doc1', doc1.path,
          filename: basename(doc1.path)));
      request.files.add(await http.MultipartFile.fromPath('proof1', proof1.path,
          filename: basename(proof1.path)));

      // Send the request
      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        log('File uploaded successfully!');
        var responseString = await response.stream.bytesToString();
        log('Response: $responseString');
        return true;
      } else {
        log('Failed to upload file: ${response.statusCode}');
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

  static Future<bool?> updateInvestor({
    required String investorId,
    required String name,
    required String companyName,
    required String industry,
    required String description,
    required String state,
    required String city,
    required String url,
    required String rangeStarting,
    required String rangeEnding,
    required String evaluatingAspects,
    required String locationInterested,
    required File image1,
    File? image2,
    File? image3,
    File? image4,
    required File doc1,
    required File proof1,
  }) async {
    try {
      // Retrieve token from Flutter Secure Storage
      final token = await storage.read(key: 'token');
      if (token == null) {
        log('Error: token not found in Flutter Secure Storage');
        return false;
      }

      // Create multipart request
      var request = http.MultipartRequest(
          'PATCH', Uri.parse('${ApiList.investorAddPage}$investorId'));
      request.headers['token'] = token;  // Add token to request headers
      request.fields['name'] = name;
      request.fields['company'] = companyName;
      request.fields['industry'] = industry;
      request.fields['description'] = description;
      request.fields['state'] = state;
      request.fields['city'] = city;
      request.fields['url'] = url;
      request.fields['range_starting'] = rangeStarting;
      request.fields['range_ending'] = rangeEnding;
      request.fields['location_interested'] = locationInterested;
      request.fields['evaluating_aspects'] = evaluatingAspects;

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

      // Send the request
      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        log('Investor information updated successfully!');
        var responseString = await response.stream.bytesToString();
        log('Response: $responseString');
        return true;
      } else {
        log('Failed to update investor information: ${response.statusCode}');
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
