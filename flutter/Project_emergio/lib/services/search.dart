import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResult {
  final String name;
  final String description;
  final String imageUrl;
  final String location;
  final String type;
  final String id;
  final Map<String, dynamic> rawData;
  final bool isLiked;

  SearchResult({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.type,
    required this.id,
    required this.rawData,
    this.isLiked = false,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    final entityType = json['entity_type'] ?? 'Unknown';
    final name = entityType.toLowerCase() == 'investor'
        ? json['company'] ?? json['name'] ?? 'Unknown'
        : json['name'] ?? json['company'] ?? 'Unknown';

    return SearchResult(
      name: name,
      description: json['description'] ?? 'No description provided',
      imageUrl: validateUrl(json['image1']) ?? 'https://via.placeholder.com/400x200',
      location: json['city'] ?? 'No location provided',
      type: entityType,
      id: json['_id']?.toString() ?? '',
      rawData: json,
      isLiked: json['is_liked'] ?? false,
    );
  }

  static String? validateUrl(String? url) {
    const String baseUrl = 'https://investryx.com/';
    if (url == null || url.isEmpty) return null;
    try {
      Uri uri = Uri.parse(url);
      if (!uri.hasScheme) {
        url = url.startsWith('/') ? url.substring(1) : url;
        url = baseUrl + url;
      }
      return url;
    } catch (e) {
      return null;
    }
  }
}

class SearchServices {
  static const String baseUrl = 'https://investryx.com/api';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<List<String>> loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('recent_searches') ?? [];
  }

  Future<void> saveRecentSearch(String query, List<String> currentSearches) async {
    if (query.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    currentSearches.remove(query);
    currentSearches.insert(0, query);
    if (currentSearches.length > 6) {
      currentSearches.removeLast();
    }
    await prefs.setStringList('recent_searches', currentSearches);
  }

  Future<void> clearRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('recent_searches');
  }

  Future<List<SearchResult>> getRecentResults() async {
    try {
      final token = await _storage.read(key: 'token');

      if (token == null) {
        return [];
      }

      final url = '$baseUrl/recent-results';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'token': token,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['data'] as List;
        return results.map((item) => SearchResult.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      print('Error loading recent results: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> performSearch({
    required String query,
    String city = '',
    String state = '',
    String industry = '',
    String entityType = '',
    String establishFrom = '',
    String establishTo = '',
    String rangeStarting = '',
    String rangeEnding = '',
    bool filter = false,
  }) async {
    try {
      final queryParams = Uri(
        queryParameters: {
          'query': query,
          'city': city,
          'state': state,
          'industry': industry,
          'entity_type': entityType,
          'establish_from': establishFrom,
          'establish_to': establishTo,
          'range_starting': rangeStarting,
          'range_ending': rangeEnding,
          'filter': filter.toString(),
        },
      ).query;

      final token = await _storage.read(key: 'token');

      if (token == null) {
        return {
          'success': false,
          'error': 'Authentication error. Please login again.',
          'results': <SearchResult>[],
        };
      }

      final url = '$baseUrl/search?$queryParams';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'token': token,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['data'];

        if (results.isEmpty) {
          return {
            'success': false,
            'error': 'No results found for "$query"',
            'results': <SearchResult>[],
          };
        }

        final searchResults = List<SearchResult>.from(
          results.map((item) => SearchResult.fromJson(item)),
        );

        return {
          'success': true,
          'results': searchResults,
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to fetch results. Please try again.',
          'results': <SearchResult>[],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'An error occurred. Please check your connection and try again.',
        'results': <SearchResult>[],
      };
    }
  }
}