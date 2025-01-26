import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ServerCache {
  static Future<void> saveToCache(String key, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(data));
  }

  static Future<Map<String, dynamic>?> getFromCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    return data != null ? jsonDecode(data) : null;
  }

  static Future<void> clearCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}