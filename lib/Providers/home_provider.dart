import 'package:flutter/material.dart';
import '../Backend/Api/api_service.dart';
import '../Backend/Adapters/response_adapter.dart';
import '../Backend/Error/api_error_handler.dart';
import '../Models/homepage_model.dart';
import '../Services/home_cache.dart';

class HomeProvider with ChangeNotifier {
  HomeAnime? _homeAnime;
  bool _isLoading = false;
  String? _lastError;

  HomeAnime? get homeAnime => _homeAnime;
  bool get isLoading => _isLoading;
  String? get lastError => _lastError;

  Future<void> fetchHomeAnime() async {
    _isLoading = true;
    _lastError = null;
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
        try {
          final apiResponse = await ApiService.fetchHomeAnime();
          _homeAnime = HomeAnime.fromJson(ResponseAdapter.normalizeHomeResponse(apiResponse));
          final animeList = ResponseAdapter.parseAnimeList(apiResponse);
          if (animeList.isEmpty) {
            _lastError = "Provider response was normalized, but no anime list was found.";
          }
          
          notifyListeners();

          // Save the fetched data to the cache
          if (_homeAnime != null) {
            await AnimeCacheManager.saveToCache(_homeAnime!);
          }
        } on Exception catch (apiError) {
          _lastError = ApiErrorHandler.getErrorMessage(apiError);
          print("API Error: $_lastError");
        }
      }
    } catch (error) {
      _lastError = ApiErrorHandler.getErrorMessage(error);
      print("Error in fetching Home Anime: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
