import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../api_list.dart';

class ChangePassword {
  static var client = http.Client();

  static Future<bool?> changePassword({
    required String phoneNumber,
    required String password,
  }) async {
    var body = jsonEncode({
      "username": phoneNumber,
      "password": password,
    });

    try {
      var response = await client.post(
        Uri.parse(ApiList.changePassword!),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        bool status = responseBody['status'];
        if (status) {
          return true;
        } else {
          return false;
        }
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
