import 'package:flutter/material.dart';
import '../Backend/Api/api_service.dart';
import '../Models/server_model.dart';
import '../Services/server_cache.dart';

class ServerProvider with ChangeNotifier {
  Server? serverData;
  bool isLoading = false;

  Future<void> fetchAndCacheServers(String animeId) async {
    final cacheKey = 'servers_$animeId';
    isLoading = true;
    notifyListeners();

    try {
      // Check cache first
      final cachedData = await ServerCache.getFromCache(cacheKey);

      if (cachedData != null) {
        serverData = Server.fromJson(cachedData);
      } else {
        // Fetch from API and save to cache
        final data = await ApiService.fetchEpisodeServers(animeId);
        serverData = Server.fromJson(data);
        await ServerCache.saveToCache(cacheKey, data);
      }
    } catch (error) {
      debugPrint('Error fetching episodes: $error');
    }

    isLoading = false;
    notifyListeners();
  }
}