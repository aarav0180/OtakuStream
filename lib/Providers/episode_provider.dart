// import 'package:flutter/material.dart';
// import '../Backend/Api/api_service.dart';
// import '../Models/episode_details.dart';
// import '../Services/episode_cache.dart';
//
// class EpisodeProvider with ChangeNotifier {
//   Episode? episodeData;
//   bool isLoading = false;
//
//   Future<void> fetchAndCacheEpisodes(String animeId) async {
//     final cacheKey = 'episodes_$animeId';
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       // Check cache first
//       final cachedData = await EpisodeCache.getFromCache(cacheKey);
//
//       if (cachedData != null) {
//         episodeData = Episode.fromJson(cachedData);
//       } else {
//         // Fetch from API and save to cache
//         final data = await ApiService.fetchEpisodes(animeId);
//         episodeData = Episode.fromJson(data);
//         await EpisodeCache.saveToCache(cacheKey, data);
//       }
//     } catch (error) {
//       debugPrint('Error fetching episodes: $error');
//     }
//
//     isLoading = false;
//     notifyListeners();
//   }
// }

import 'package:flutter/cupertino.dart';
import '../Backend/Api/api_service.dart';
import '../Models/episode_details.dart';
import '../Services/episode_cache.dart';

class EpisodeProvider with ChangeNotifier {
  Episode? episodeData;
  bool isLoading = false;

  Future<void> fetchAndCacheEpisodes(String animeId) async {
    final cacheKey = 'episodes_$animeId';
    isLoading = true;
    notifyListeners();

    try {
      if (await EpisodeCache.isCacheExpired(cacheKey)) {
        await EpisodeCache.clearCache(cacheKey);
      }

      // Try to load data from the cache
      final cachedData = await EpisodeCache.loadFromCache(cacheKey);

      if (cachedData != null) {
        episodeData = Episode.fromJson(cachedData);
      } else {
        // Fetch from API and save to cache
        final apiResponse = await ApiService.fetchEpisodes(animeId);
        episodeData = Episode.fromJson(apiResponse);
        await EpisodeCache.saveToCache(cacheKey, apiResponse);
      }
    } catch (error) {
      debugPrint('Error fetching episodes: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

