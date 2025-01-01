import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/anime_detail.dart';

class DetailCacheManager {
  static const String _cacheKeyPrefix = 'anime_detail_';

  // Save anime details to cache
  static Future<void> saveAnimeToCache(String animeId, AnimeDetail animeDetail) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(animeDetail.toJson());
    await prefs.setString('$_cacheKeyPrefix$animeId', jsonData);
  }

  // Load anime details from cache
  static Future<AnimeDetail?> loadAnimeFromCache(String animeId) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('$_cacheKeyPrefix$animeId');

    if (jsonData == null) return null;

    try {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonData);
      return AnimeDetail.fromJson(jsonMap);
    } catch (error) {
      print("Error decoding cached anime detail: $error");
      return null;
    }
  }

  // Clear cache for a specific anime
  static Future<void> clearAnimeCache(String animeId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_cacheKeyPrefix$animeId');
  }

  // Clear all anime caches
  static Future<void> clearAllCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    for (var key in keys) {
      if (key.startsWith(_cacheKeyPrefix)) {
        await prefs.remove(key);
      }
    }
  }
}
