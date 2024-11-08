// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'api_list.dart';
//
//
// class MessageService {
//   static final client = http.Client();
//   static final storage = FlutterSecureStorage();
//
//   static Future<List<MessageData>?> fetchMessageData(String id) async {
//     try {
//       final token = await storage.read(key: 'token');
//       if (token == null) {
//         log('Error: token not found in Flutter Secure Storage');
//         return null;
//       }
//
//       final response = await client.get(
//         Uri.parse('${ApiList.message}?roomId=$id'),
//         headers: {
//           'token': token,
//         },
//       );
//
//       log('Response body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//
//         if (data is Map<String, dynamic> && data.containsKey('messages')) {
//           final messages = data['messages'] as List;
//           final defaultNumber = data['number'] as String?;
//           return messages.map((json) => MessageData.fromJson(json, defaultNumber)).toList();
//         } else {
//           log('Unexpected response format: ${data.runtimeType}');
//           return null;
//         }
//       } else {
//         log('Failed to fetch message data: ${response.statusCode}');
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
// class MessageData {
//   final String? message;
//   final String sendedBy;
//   final String sendedTo;
//   final String? time;
//   final String? phoneNumber;
//
//   MessageData({
//     this.message,
//     required this.sendedBy,
//     required this.sendedTo,
//     this.time,
//     this.phoneNumber,
//   });
//
//   factory MessageData.fromJson(Map<String, dynamic> json, String? defaultNumber) {
//     final senderObj = json['sended_by'];
//     final receiverObj = json['sended_to'];
//
//     final senderPhone = senderObj?['username'] as String?;
//     final receiverPhone = receiverObj?['username'] as String?;
//
//     return MessageData(
//       message: json['message'],
//       sendedBy: senderObj?['id']?.toString() ?? '',
//       sendedTo: receiverObj?['id']?.toString() ?? '',
//       time: json['timestamp'],
//       phoneNumber: defaultNumber ?? '', // Using the number from root JSON
//     );
//   }
// }



import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_list.dart';

class MessageService {
  static final _client = http.Client();
  static final _storage = FlutterSecureStorage();

  static Future<MessageDataResponse?> fetchMessageData(String id) async {
    try {
      final token = await _storage.read(key: 'token');
      if (token == null) {
        log('Error: token not found in Flutter Secure Storage');
        return null;
      }

      final response = await _client.get(
        Uri.parse('${ApiList.message}?roomId=$id'),
        headers: {
          'token': token,
        },
      );

      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('messages')) {
          final messages = data['messages'] as List;
          final number = data['number'] as String?; // Get number from API response

          return MessageDataResponse(
            messages: messages.map((json) => MessageData.fromJson(json)).toList(),
            phoneNumber: number ?? '',
          );
        } else {
          log('Unexpected response format: ${data.runtimeType}');
          return null;
        }
      } else {
        log('Failed to fetch message data: ${response.statusCode}');
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

class MessageDataResponse {
  final List<MessageData> messages;
  final String phoneNumber;

  MessageDataResponse({
    required this.messages,
    required this.phoneNumber,
  });
}

class MessageData {
  final String? message;
  final String sendedBy;
  final String sendedTo;
  final String? time;

  MessageData({
    this.message,
    required this.sendedBy,
    required this.sendedTo,
    this.time,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    final senderObj = json['sended_by'];
    final receiverObj = json['sended_to'];

    return MessageData(
      message: json['message'],
      sendedBy: senderObj?['id']?.toString() ?? '',
      sendedTo: receiverObj?['id']?.toString() ?? '',
      time: json['timestamp'],
    );
  }
}