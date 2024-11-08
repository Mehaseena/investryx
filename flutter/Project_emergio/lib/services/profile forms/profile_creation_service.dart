import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../api_list.dart';

class ProfileCreationService {
  static var _client = http.Client();
  static final _storage = FlutterSecureStorage();

  static Future<bool?> profileCreation({
    required String name,
    required File image,
    required String type,
    required String number,
    required String email,
    required String industry,
    required String state,
    required String city,
    required String about,
    String? webUrl,  // Made optional
    String? experience,  // Added as optional
    String? areaOfInterest,  // Added as optional
  }) async {
    try {
      // Fetch the token from Flutter Secure Storage
      final token = await _storage.read(key: 'token');
      if (token == null) {
        log('Error: Token not found in Flutter Secure Storage');
        return null;
      }

      // Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiList.saleProfile!),
      );

      // Add headers
      request.headers.addAll({
        'token': token,
      });

      // Add file
      var imageStream = http.ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = http.MultipartFile(
          'image', // This should match your API's expected field name
          imageStream,
          length,
          filename: image.path.split('/').last
      );
      request.files.add(multipartFile);

      // Add required fields
      var fields = {
        'name': name,
        'type': type,
        'email': email,
        'number': number,
        'industry': industry,
        'about': about,
        'state': state,
        'city': city,
      };

      // Add optional fields if they are provided
      if (webUrl != null) {
        fields['web_url'] = webUrl;
      }
      if (experience != null) {
        fields['experience'] = experience;
      }
      if (areaOfInterest != null) {
        fields['area_of_interest'] = areaOfInterest;
      }

      request.fields.addAll(fields);

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      log('Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 201) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        bool status = responseBody['status'];
        return status;
      } else {
        log('Failed to register: ${response.statusCode}');
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