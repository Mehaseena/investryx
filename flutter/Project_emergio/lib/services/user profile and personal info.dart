// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Views/contact us page.dart';
// import 'api_list.dart';
//
//
//
// class UserProfile{
//   static var client = http.Client();
//
//   static Future<List<UserProfilee>?> fetchUserProfileData() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userId = prefs.getInt('userId');
//       if (userId == null) {
//         log('Error: userId not found in SharedPreferences');
//         return null;
//       }
//
//       var response = await client.get(Uri.parse('${ApiList.userProfile!}$userId'));
//
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body) as List;
//         List<UserProfilee> profiles = data.map((json) => UserProfilee.fromJson(json)).toList();
//         return profiles;
//       } else {
//         log('Failed to fetch user profile data: ${response.statusCode}');
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
//   static Future<void> deleteUserProfile(String userId) async {
//     try {
//       var response = await client.delete(Uri.parse('${ApiList.userProfile!}$userId'));
//
//       if (response.statusCode == 200) {
//         log('user profile deleted successfully');
//       } else {
//         log('Failed to delete user profile: ${response.statusCode}');
//         throw Exception('Failed to delete user profile');
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
// class UserProfilee {
//   final String id; // Add an id field
//   final String name;
//   final String email;
//   final String phone;
//
//
//   UserProfilee({
//     required this.id, // Initialize the id field
//     required this.name,
//     required this.email,
//     required this.phone,
//   });
//
//   factory UserProfilee.fromJson(Map<String, dynamic> json) {
//     return UserProfilee(
//       id: json['id'].toString(), // Convert id to string
//       name: json['name'] ?? 'N/A',
//       email: json['email'] ?? 'N/A',
//       phone: json['phone'] ?? 'N/A',
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
//

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Add this import
import 'api_list.dart';

class UserProfile {
  static var client = http.Client();
  static final storage = FlutterSecureStorage(); // Initialize secure storage

// Fetch User Profile Data
  static Future<UserProfileAndImage?> fetchUserProfileData() async {
    try {
      final token = await storage.read(key: 'token'); // Retrieve token from secure storage
      if (token == null) {
        log('Error: token not found in secure storage');
        return null;
      }

      var response = await client.get(
        Uri.parse('${ApiList.userProfile!}'),
        headers: {
          'token': token, // Add token to request headers
        },
      );

      print('Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          var data = jsonDecode(response.body); // Parse the response body

          // No need to check for 'user' key, directly map the response to UserProfileData
          UserProfileData profile = UserProfileData.fromJson(data);

          // Check if 'image' field exists and is valid
          if (data['image'] != null && data['image'] is String) {
            GetImage image = GetImage.fromJson(data);
            return UserProfileAndImage(profile: profile, image: image);
          } else {
            return UserProfileAndImage(profile: profile, image: null);
          }
        } else {
          log('Error: Response body is empty');
          return null;
        }
      } else {
        log('Failed to fetch user profile data: ${response.statusCode}');
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

  // Delete User Profile
  static Future<void> deleteUserProfile() async {
    try {
      final token = await storage.read(key: 'token'); // Retrieve token from secure storage
      if (token == null) {
        log('Error: token not found in secure storage');
        throw Exception('No token found');
      }

      var response = await client.delete(
        Uri.parse(ApiList.userProfile!),
        headers: {
          'token': token, // Add token to request headers
        },
      );

      if (response.statusCode == 200) {
        log('User profile deleted successfully');
      } else {
        log('Failed to delete user profile: ${response.statusCode}');
        throw Exception('Failed to delete user profile');
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

  // Update User Profile Data
  static Future<bool> updateUserProfileData(String token, String name,
      String email, String phone, File? imageFile) async {
    try {
      final token = await storage.read(key: 'token'); // Retrieve token from secure storage
      if (token == null) {
        log('Error: token not found in secure storage');
        return false;
      }

      var uri = Uri.parse('${ApiList.userProfile!}');
      var request = http.MultipartRequest('PUT', uri)
        ..headers['token'] = token // Add token to request headers
        ..fields['first_name'] = name
        ..fields['email'] = email
        ..fields['username'] = phone;

      if (imageFile != null) {
        request.files.add(
          http.MultipartFile(
            'image',
            imageFile.readAsBytes().asStream(),
            imageFile.lengthSync(),
            filename: imageFile.path.split('/').last,
          ),
        );
      }

      var response = await request.send();

      // Process the response
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print('Response: ${response.statusCode} - $responseBody');
        log('User profile updated successfully');

        // Update SharedPreferences (if needed)
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('name', name);
        // await prefs.setString('email', email);
        // await prefs.setString('phone', phone);
        // await prefs.setString('image', imageFile?.path ?? '');

        return true;
      } else {
        var responseBody = await response.stream.bytesToString();
        log('Failed to update user profile: ${response.statusCode} - $responseBody');
        return false;
      }
    } on SocketException catch (e) {
      log('SocketException: ${e.message}');
      return false;
    } on http.ClientException catch (e) {
      log('ClientException: ${e.message}');
      return false;
    } catch (e) {
      log('Unexpected error: $e');
      return false;
    }
  }
}

class UserProfileData {
  final int id;
  final String username;
  final String firstName;
  final String email;

  UserProfileData({
    required this.id,
    required this.username,
    required this.firstName,
    required this.email,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      email: json['email'],
    );
  }
}

class GetImage {
  final String image;

  GetImage({
    required this.image,
  });

  factory GetImage.fromJson(Map<String, dynamic> json) {
    return GetImage(
        image: json['image'] != null
            ? validateUrl(json['image'])
            : 'https://via.placeholder.com/400x200');
  }

  static String validateUrl(String? url) {
    const String baseUrl = 'https://investryx.com/';

    if (url == null || url.isEmpty) {
      return '';
    }

    try {
      // Handle relative URLs
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = url.startsWith('/') ? url.substring(1) : url;
        url = baseUrl + url;
      }

      final uri = Uri.parse(url);

      // Validate URL structure
      if (!uri.hasScheme || (!uri.hasAuthority && uri.host.isEmpty)) {
        return '';
      }

      return url;
    } catch (e) {
      print('URL validation error: $e');
      return '';
    }
  }

  // static String validateUrl(String? url) {
  //   const String baseUrl = 'https://investryx.com/';
  //
  //   if (url == null || url.isEmpty) {
  //     return '';
  //   }
  //
  //   Uri uri;
  //   try {
  //     uri = Uri.parse(url);
  //     if (!uri.hasScheme) {
  //       url = url.startsWith('/') ? url.substring(1) : url;
  //       url = baseUrl + url;
  //       uri = Uri.parse(url);
  //     }
  //     if (uri.hasScheme && (uri.hasAuthority || uri.host.isNotEmpty)) {
  //       return url;
  //     }
  //   } catch (e) {
  //     return '';
  //   }
  //   return '';
  // }
}

class UserProfileAndImage {
  final UserProfileData profile;
  final GetImage? image;

  UserProfileAndImage({
    required this.profile,
    this.image,
  });
}
