import 'package:flutter/material.dart';
import 'package:otaku_stream/Models/genre_model.dart';
import '../Backend/Api/api_service.dart';
import '../Services/genre_cache.dart';

class GenreProvider with ChangeNotifier {
  Genre? serverData;
  bool isLoading = false;

  Future<void> fetchAndCacheGenres(String genre, int currentPage) async {
    final cacheKey = 'genre_${genre}_$currentPage';
    isLoading = true;
    notifyListeners();

    try {
      // Check cache first
      final cachedData = await GenreCache.getFromCache(cacheKey);

      if (cachedData != null) {
        serverData = Genre.fromJson(cachedData);
      } else {
        // Fetch from API and save to cache
        final data = await ApiService.fetchGenreAnimes(genre, currentPage);
        serverData = Genre.fromJson(data);
        await GenreCache.saveToCache(cacheKey, data);
      }
    } catch (error) {
      debugPrint('Error fetching episodes: $error');
    }

    isLoading = false;
    notifyListeners();
  }
}