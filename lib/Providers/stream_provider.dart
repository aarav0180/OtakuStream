// import 'package:flutter/material.dart';
// import 'package:otaku_stream/Models/stream_model.dart';
// import '../Backend/Api/api_service.dart';
// import '../Services/stream_cache.dart';
//
// class StreamingProvider with ChangeNotifier {
//   EpisodeDetail? streamData;
//   bool isLoading = false;
//
//   Future<void> fetchAndCacheLinks(String animeId,String server, String category) async {
//     final cacheKey = 'anime_${animeId}_${server}_$category';
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       // Check cache first
//       final cachedData = await StreamCache.getFromCache(cacheKey);
//
//       if (cachedData != null) {
//         streamData = EpisodeDetail.fromJson(cachedData);
//       } else {
//         // Fetch from API and save to cache
//         final data = await ApiService.fetchEpisodeSources(animeId, server, category);
//         streamData = EpisodeDetail.fromJson(data);
//         await StreamCache.saveToCache(cacheKey, data);
//       }
//     } catch (error) {
//       debugPrint('Error fetching episodes: $error');
//     }
//
//     isLoading = false;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:otaku_stream/Models/stream_model.dart';
import '../Backend/Api/api_service.dart';
import '../Services/stream_cache.dart';

class StreamingProvider with ChangeNotifier {
  EpisodeDetail? streamData;
  bool isLoading = false;

  Future<void> fetchAndCacheLinks(String animeId, String server, String category) async {
    final cacheKey = 'anime_${animeId}_${server}_$category';
    isLoading = true;
    notifyListeners();

    try {
      // Load data from cache.
      final cachedData = await StreamCache.loadFromCache(cacheKey);

      // If there is cached data and it's not expired, use it.
      if (cachedData != null && !(await StreamCache.isCacheExpired(cacheKey))) {
        streamData = EpisodeDetail.fromJson(cachedData);
      } else {
        // If cached data is expired (or doesn't exist), clear the cache if needed.
        if (cachedData != null) {
          await StreamCache.clearCache(cacheKey);
        }
        // Fetch from API and save to cache.
        final data = await ApiService.fetchEpisodeSources(animeId, server, category);
        streamData = EpisodeDetail.fromJson(data);
        await StreamCache.saveToCache(cacheKey, data);
      }
    } catch (error) {
      debugPrint('Error fetching episodes: $error');
    }

    isLoading = false;
    notifyListeners();
  }
}
