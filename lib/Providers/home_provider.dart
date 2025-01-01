import 'package:flutter/material.dart';
import '../Backend/Api/api_service.dart';
import '../Models/homepage_model.dart';
import '../Services/home_cache.dart';

class HomeProvider with ChangeNotifier {
  HomeAnime? _homeAnime;
  bool _isLoading = false;

  HomeAnime? get homeAnime => _homeAnime;
  bool get isLoading => _isLoading;

  Future<void> fetchHomeAnime() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Check if cache is expired, if yes, clear it
      if (await AnimeCacheManager.isCacheExpired()) {
        await AnimeCacheManager.clearCache();
      }

      // Try to load data from the cache
      _homeAnime = await AnimeCacheManager.loadFromCache();

      // If cache is empty, fetch data from API
      if (_homeAnime == null) {
        final apiResponse = await ApiService.fetchHomeAnime();
        _homeAnime = HomeAnime.fromJson(apiResponse);
        notifyListeners();

        // Save the fetched data to the cache
        await AnimeCacheManager.saveToCache(_homeAnime!);
      }
    } catch (error) {
      print("Error in fetching Home Anime: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
