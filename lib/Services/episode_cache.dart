// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class EpisodeCache {
//   static Future<void> saveToCache(String key, Map<String, dynamic> data) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(key, jsonEncode(data));
//   }
//
//   static Future<Map<String, dynamic>?> getFromCache(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getString(key);
//     return data != null ? jsonDecode(data) : null;
//   }
//
//   static Future<void> clearCache(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(key);
//   }
// }

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EpisodeCache {
  static const String cacheDateKeyPrefix = 'cacheDate_';
  static const int cacheDurationDays = 1;

  // Check if cache is expired
  static Future<bool> isCacheExpired(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final lastCacheDate = prefs.getString('$cacheDateKeyPrefix$key');

    if (lastCacheDate == null) return true;

    final lastDate = DateTime.parse(lastCacheDate);
    final today = DateTime.now();
    return today.difference(lastDate).inDays >= cacheDurationDays;
  }

  // Clear the cache
  static Future<void> clearCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    await prefs.remove('$cacheDateKeyPrefix$key');
  }

  // Load from cache
  static Future<Map<String, dynamic>?> loadFromCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(key);

    if (cachedData == null) return null;

    return jsonDecode(cachedData);
  }

  // Save to cache
  static Future<void> saveToCache(String key, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(data));
    await prefs.setString('$cacheDateKeyPrefix$key', DateTime.now().toIso8601String());
  }
}