import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import Flutter Secure Storage
import 'package:path/path.dart';

import '../../api_list.dart';

class AdvisorAddPage {
  static var client = http.Client();
  static final storage = FlutterSecureStorage(); // Initialize Flutter Secure Storage

  static Future<Map<String, dynamic>> advisorAddPage({
    required String advisorName,
    required String designation,
    required String businessWebsite,
    required String state,
    required String city,
    required String contactNumber,
    required String describeExpertise,
    required String areaOfInterest,
    required List<File> brandLogo,
    required List<File> businessPhotos,
    required File businessProof,
    required List<File> businessDocuments,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        log('Error: token not found in Flutter Secure Storage');
        return {"status": "loggedout"};
      }

      var request = http.MultipartRequest('POST', Uri.parse(ApiList.advisorAddPage ?? ''));
      request.headers['token'] = token;

      request.fields['name'] = advisorName;
      request.fields['designation'] = designation;
      request.fields['url'] = businessWebsite;
      request.fields['state'] = state;
      request.fields['city'] = city;
      request.fields['number'] = contactNumber;
      request.fields['description'] = describeExpertise;
      request.fields['interest'] = areaOfInterest;

      for (var file in brandLogo) {
        request.files.add(await http.MultipartFile.fromPath(
          'logo',
          file.path,
          filename: basename(file.path),
        ));
      }

      for (var file in businessPhotos) {
        request.files.add(await http.MultipartFile.fromPath(
          'image1',
          file.path,
          filename: basename(file.path),
        ));
      }

      for (var file in businessDocuments) {
        request.files.add(await http.MultipartFile.fromPath(
          'doc1',
          file.path,
          filename: basename(file.path),
        ));
      }

      request.files.add(await http.MultipartFile.fromPath(
        'proof1',
        businessProof.path,
        filename: basename(businessProof.path),
      ));

      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      var decodedResponse = json.decode(responseString);

      if (response.statusCode == 200) {
        log('Advisor added successfully!');
        if (decodedResponse is Map<String, dynamic>) {
          if (decodedResponse['status'] == false) {
            if (decodedResponse['message'] == "User does not exist") {
              return {"status": "loggedout"};
            }
            return {"error": decodedResponse['message']};
          }
          return {"status": true, "message": "Advisor added successfully"};
        }
      }

      log('Failed to add advisor: ${response.statusCode}');
      return {"status": false, "error": "Failed to add advisor"};

    } catch (e) {
      log('Unexpected error: $e');
      return {"status": false, "error": e.toString()};
    }
  }
}
