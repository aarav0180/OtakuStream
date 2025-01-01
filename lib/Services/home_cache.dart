import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Models/homepage_model.dart';

class AnimeCacheManager {
  static const String cacheKey = 'homeAnimeCache';
  static const String cacheDateKey = 'cacheDate';
  static const int cacheDurationDays = 1;

  // Check if cache is expired
  static Future<bool> isCacheExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final lastCacheDate = prefs.getString(cacheDateKey);

    if (lastCacheDate == null) return true;

    final lastDate = DateTime.parse(lastCacheDate);
    final today = DateTime.now();
    return today.difference(lastDate).inDays >= cacheDurationDays;
  }

  // Clear the cache
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cacheKey);
    await prefs.remove(cacheDateKey);
  }

  // Load from cache
  static Future<HomeAnime?> loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(cacheKey);

    if (cachedData == null) return null;

    return HomeAnime.fromJson(jsonDecode(cachedData));
  }

  // Save to cache
  static Future<void> saveToCache(HomeAnime homeAnime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(cacheKey, jsonEncode(homeAnime.toJson()));
    await prefs.setString(cacheDateKey, DateTime.now().toIso8601String());
  }
}
