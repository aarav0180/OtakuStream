import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LaterAnimeCache {
  static const String _animeCacheKey = 'animeCache';

  static Future<void> saveAnimeToCache(String id, Map<String, dynamic> animeData) async {
    final prefs = await SharedPreferences.getInstance();
    final animeCache = prefs.getString(_animeCacheKey);
    Map<String, dynamic> cachedData = animeCache != null ? jsonDecode(animeCache) : {};
    cachedData[id] = animeData;
    await prefs.setString(_animeCacheKey, jsonEncode(cachedData));
  }

  /// Retrieve all cached anime
  static Future<Map<String, dynamic>> getCachedAnime() async {
    final prefs = await SharedPreferences.getInstance();
    final animeCache = prefs.getString(_animeCacheKey);
    return animeCache != null ? jsonDecode(animeCache) : {};
  }

  static Future<Map<String, dynamic>?> getAnimeById(String id) async {
    final cachedData = await getCachedAnime();
    return cachedData[id];
  }

  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_animeCacheKey);
  }

  static Future<void> removeAnimeFromCache(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final animeCache = prefs.getString(_animeCacheKey);
    if (animeCache != null) {
      Map<String, dynamic> cachedData = jsonDecode(animeCache);
      cachedData.remove(id); // Remove the anime by its ID
      await prefs.setString(_animeCacheKey, jsonEncode(cachedData)); // Update the cache
    }
  }
}
