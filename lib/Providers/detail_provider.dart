import 'package:flutter/material.dart';
import '../Backend/Api/api_service.dart';
import '../Models/anime_detail.dart';
import '../Services/detail_cache.dart';

class DetailProvider with ChangeNotifier {
  AnimeDetail? _animeDetail;
  bool _isLoading = false;

  AnimeDetail? get animeDetail => _animeDetail;
  bool get isLoading => _isLoading;

  Future<void> fetchAnimeDetail(String animeId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Load from cache
      _animeDetail = await DetailCacheManager.loadAnimeFromCache(animeId);

      // If cache is null, fetch from API
      if (_animeDetail == null) {
        final apiResponse = await ApiService.fetchAnimeDetail(animeId);
        _animeDetail = AnimeDetail.fromJson(apiResponse);
        print(apiResponse);

        // Save the fetched data to the cache
        await DetailCacheManager.saveAnimeToCache(animeId, _animeDetail!);
      }
    } catch (error, stackTrace) {
      print("Error fetching Anime Detail: $error");
      print("StackTrace: $stackTrace");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
