import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_list.dart';

class Inbox {
  static var client = http.Client();
  static final storage = FlutterSecureStorage(); // Initialize Flutter Secure Storage

  // Fetch Inbox Data
  static Future<List<InboxItems>?> fetchInboxData() async {
    try {
      // Fetch the token from Flutter Secure Storage
      final token = await storage.read(key: 'token');
      if (token == null) {
        log('Error: token not found in Flutter Secure Storage');
        return null;
      }

      final response = await client.get(
        Uri.parse('${ApiList.inbox!}'),
        headers: {
          'token': token, // Add token to request headers
        },
      );

      log('Response body: ${response.body}'); // Log the raw response

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Check if the data is a List or Map
        if (data is List) {
          List<InboxItems> inboxItems = data.map((json) => InboxItems.fromJson(json)).toList();
          return inboxItems;
        } else if (data is Map) {
          // If the response is a Map, look for the 'items' key
          var items = data['items'] as List?;
          if (items != null) {
            List<InboxItems> inboxItems = items.map((json) => InboxItems.fromJson(json)).toList();
            return inboxItems;
          } else {
            log('Items key is missing or null');
            return null;
          }
        } else {
          log('Unexpected response format: ${data.runtimeType}');
          return null;
        }
      } else {
        log('Failed to fetch inbox data: ${response.statusCode}');
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

  // Room Creation Function
  static Future<Map<String, dynamic>> roomCreation({
    required String receiverUserId,
  }) async {
    var body = jsonEncode({
      "receiverId": receiverUserId,
    });

    try {
      // Fetch the token from Flutter Secure Storage
      final token = await storage.read(key: 'token');
      if (token == null) {
        log('Error: Token not found in Flutter Secure Storage');
        return {'status': false};
      }

      var response = await client.post(
        Uri.parse(ApiList.inbox!),
        headers: {
          'Content-Type': 'application/json',
          'token': token, // Pass the token in the header
        },
        body: body,
      );

      log('Response: ${response.statusCode} - ${response.body}');
      var responseBody = json.decode(response.body);
      if(responseBody['status']){
        return {'status': true, 'id': responseBody['roomId'],'name':responseBody['name'],'image':responseBody['image']};
      } else{
        return {'status': false};
      }
    } on SocketException catch (e) {
      log('SocketException: ${e.message}');
      return {'status': false};
    } on http.ClientException catch (e) {
      log('ClientException: ${e.message}');
      return {'status': false};
    } catch (e) {
      log('Unexpected error: $e');
      return {'status': false};
    }
  }
}

class InboxItems {
  final String id;
  final String first_id;
  final String first_image;
  final String first_name;
  final String first_phone;
  final String second_id;
  final String second_image;
  final String second_name;
  final String second_phone;
  final String? message;
  final String time;

  InboxItems({
    required this.id,
    required this.first_id,
    required this.first_image,
    required this.first_name,
    required this.first_phone,
    required this.second_id,
    required this.second_image,
    required this.second_name,
    required this.second_phone,
    this.message,
    required this.time,
  });

  factory InboxItems.fromJson(Map<String, dynamic> json) {
    return InboxItems(
      id: json['id'].toString(),
      first_id: json['first_person']['id'].toString(),
      first_name: json['first_person']['first_name'].toString(),
      first_image: validateUrl(json['first_person']['image']) ?? 'https://via.placeholder.com/400x200',
      first_phone: json['first_person']['username']?.toString() ?? 'N/A', // Use username as phone
      second_id: json['second_person']['id'].toString(),
      second_image: validateUrl(json['second_person']['image']) ?? 'https://via.placeholder.com/400x200',
      second_name: json['second_person']['first_name'].toString(),
      second_phone: json['second_person']['username']?.toString() ?? 'N/A', // Use username as phone
      message: json['last_msg'],
      time: json['updated'] ?? 'N/A',
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