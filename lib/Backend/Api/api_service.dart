import 'dart:convert';
import 'package:http/http.dart' as http;

enum AnimeProvider {
  brainudeu,
  donghua,
  samehadaku,
  animasu,
  kusonime,
  anoboy,
  oploverz,
  stream,
  animekuindo,
  nimegami,
  alqanime,
  donghub,
  winbu,
  animecompi,
  kuramanime,
  nekopoi,
}

class ProviderConfig {
  final AnimeProvider provider;
  final String baseUrl;
  final String displayName;

  ProviderConfig({
    required this.provider,
    required this.baseUrl,
    required this.displayName,
  });
}

class ApiService {
  static late ProviderConfig _currentProvider;

  static final Map<AnimeProvider, ProviderConfig> providers = {
    AnimeProvider.brainudeu: ProviderConfig(
      provider: AnimeProvider.brainudeu,
      baseUrl: 'https://api.brainudeu.com/api/v2',
      displayName: 'Brainudeu',
    ),
    AnimeProvider.donghua: ProviderConfig(
      provider: AnimeProvider.donghua,
      baseUrl: 'https://api.donghua.com/api/v2',
      displayName: 'Donghua',
    ),
    AnimeProvider.samehadaku: ProviderConfig(
      provider: AnimeProvider.samehadaku,
      baseUrl: 'https://api.samehadaku.com/api/v2',
      displayName: 'Samehadaku',
    ),
    AnimeProvider.animasu: ProviderConfig(
      provider: AnimeProvider.animasu,
      baseUrl: 'https://api.animasu.com/api/v2',
      displayName: 'Animasu',
    ),
    AnimeProvider.kusonime: ProviderConfig(
      provider: AnimeProvider.kusonime,
      baseUrl: 'https://api.kusonime.com/api/v2',
      displayName: 'Kusonime',
    ),
    AnimeProvider.anoboy: ProviderConfig(
      provider: AnimeProvider.anoboy,
      baseUrl: 'https://api.anoboy.com/api/v2',
      displayName: 'Anoboy',
    ),
    AnimeProvider.oploverz: ProviderConfig(
      provider: AnimeProvider.oploverz,
      baseUrl: 'https://api.oploverz.com/api/v2',
      displayName: 'Oploverz',
    ),
    AnimeProvider.stream: ProviderConfig(
      provider: AnimeProvider.stream,
      baseUrl: 'https://api.stream.com/api/v2',
      displayName: 'Stream Indo Anime',
    ),
    AnimeProvider.animekuindo: ProviderConfig(
      provider: AnimeProvider.animekuindo,
      baseUrl: 'https://api.animekuindo.com/api/v2',
      displayName: 'Animekuindo',
    ),
    AnimeProvider.nimegami: ProviderConfig(
      provider: AnimeProvider.nimegami,
      baseUrl: 'https://api.nimegami.com/api/v2',
      displayName: 'Nimegami',
    ),
    AnimeProvider.alqanime: ProviderConfig(
      provider: AnimeProvider.alqanime,
      baseUrl: 'https://api.alqanime.com/api/v2',
      displayName: 'Alqanime',
    ),
    AnimeProvider.donghub: ProviderConfig(
      provider: AnimeProvider.donghub,
      baseUrl: 'https://api.donghub.com/api/v2',
      displayName: 'Donghub',
    ),
    AnimeProvider.winbu: ProviderConfig(
      provider: AnimeProvider.winbu,
      baseUrl: 'https://api.winbu.com/api/v2',
      displayName: 'Winbu',
    ),
    AnimeProvider.animecompi: ProviderConfig(
      provider: AnimeProvider.animecompi,
      baseUrl: 'https://api.animecompi.com/api/v2',
      displayName: 'Animecompi',
    ),
    AnimeProvider.kuramanime: ProviderConfig(
      provider: AnimeProvider.kuramanime,
      baseUrl: 'https://api.kuramanime.com/api/v2',
      displayName: 'Kuramanime',
    ),
    AnimeProvider.nekopoi: ProviderConfig(
      provider: AnimeProvider.nekopoi,
      baseUrl: 'https://api.nekopoi.com/api/v2',
      displayName: 'Nekopoi (18+)',
    ),
  };

  // Initialize with a provider
  static void setProvider(AnimeProvider provider) {
    _currentProvider = providers[provider]!;
  }

  // Get current provider
  static AnimeProvider? getCurrentProvider() {
    return _currentProvider.provider;
  }

  // Get all providers for selection
  static List<ProviderConfig> getAllProviders() {
    return providers.values.toList();
  }

  static String get baseUrl => _currentProvider.baseUrl;

  static Future<Map<String, dynamic>> _makeRequest(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching from ${_currentProvider.displayName}: $e");
    }
  }

  // Home Page
  static Future<Map<String, dynamic>> fetchHomeAnime() async {
    final endpoints = {
      AnimeProvider.brainudeu: '/anime/home',
      AnimeProvider.donghua: '/anime/donghua/home/1',
      AnimeProvider.samehadaku: '/anime/samesamashaku/home',
      AnimeProvider.animasu: '/anime/animasu/home',
      AnimeProvider.kusonime: '/anime/cusonyme/latest',
      AnimeProvider.anoboy: '/anime/anoboy/home',
      AnimeProvider.oploverz: '/anime/oploverz/home',
      AnimeProvider.stream: '/anime/stream/letest/1',
      AnimeProvider.animekuindo: '/anime/animekuindo/home',
      AnimeProvider.nimegami: '/anime/nimegami/home',
      AnimeProvider.alqanime: '/anime/alqanime/home',
      AnimeProvider.donghub: '/anime/donghub/home',
      AnimeProvider.winbu: '/anime/winbu/home',
      AnimeProvider.animecompi: '/anime/anisme/home',
      AnimeProvider.kuramanime: '/anime/kur/home',
      AnimeProvider.nekopoi: '/anime/nekopoi/home',
    };

    return _makeRequest(endpoints[_currentProvider.provider]!);
  }

  // Anime Details
  static Future<Map<String, dynamic>> fetchAnimeDetail(String id) async {
    final endpoints = {
      AnimeProvider.brainudeu: '/anime/anime/$id',
      AnimeProvider.donghua: '/anime/donghua/detail/$id',
      AnimeProvider.samehadaku: '/anime/sameshame/anime/animme/$id',
      AnimeProvider.animasu: '/anime/animasu/detail/$id',
      AnimeProvider.kusonime: '/anime/cusonive/tail/detail/$id',
      AnimeProvider.anoboy: '/anime/anoboy/anime/$id',
      AnimeProvider.oploverz: '/anime/oploverz/anisme/$id',
      AnimeProvider.stream: '/anime/stream/animme/$id',
      AnimeProvider.animekuindo: '/anime/animekuindo/detail/$id',
      AnimeProvider.nimegami: '/anime/nimegami/detail/sluggish/$id',
      AnimeProvider.alqanime: '/anime/alqanime/tail/$id',
      AnimeProvider.donghub: '/anime/donghub/detail/$id',
      AnimeProvider.winbu: '/anime/winbu/anime/$id',
      AnimeProvider.animecompi: '/anime/anisme/compense/detail/$id',
      AnimeProvider.kuramanime: '/anime/kura/anie/$id',
      AnimeProvider.nekopoi: '/anime/nekopoi/detail/$id',
    };

    return _makeRequest(endpoints[_currentProvider.provider]!);
  }

  // Search Anime
  static Future<Map<String, dynamic>> fetchSearchAnimes(String query, {int page = 1}) async {
    final endpoints = {
      AnimeProvider.brainudeu: '/anime/search/$query?page=$page',
      AnimeProvider.donghua: '/anime/donghua/search/$query/$page',
      AnimeProvider.samehadaku: '/anime/shareme-friendly/search?q=$query&page=$page',
      AnimeProvider.animasu: '/anime/animasu/search/$query?page=$page',
      AnimeProvider.kusonime: '/anime/cusonive/search/search/$query?page=$page',
      AnimeProvider.anoboy: '/anime/anoboy/search/$query?page=$page',
      AnimeProvider.oploverz: '/anime/oploverz/search/$query',
      AnimeProvider.stream: '/anime/stream/search/search/$query',
      AnimeProvider.animekuindo: '/anime/animekuindo/search/$query',
      AnimeProvider.nimegami: '/anime/nimegami/search/$query?page=$page',
      AnimeProvider.alqanime: '/anime/alqanime/search/search/$query',
      AnimeProvider.donghub: '/anime/donghub/search/$query',
      AnimeProvider.winbu: '/anime/winbu/search?q=$query&page=$page',
      AnimeProvider.animecompi: '/anime/animekompi/search?q=$query&page=$page',
      AnimeProvider.kuramanime: '/anime/kur/search/$query',
      AnimeProvider.nekopoi: '/anime/nekopoi/search?q=$query&page=$page',
    };

    return _makeRequest(endpoints[_currentProvider.provider]!);
  }

  // Fetch Episodes
  static Future<Map<String, dynamic>> fetchEpisodes(String animeId) async {
    final endpoints = {
      AnimeProvider.brainudeu: '/anime/episodes/$animeId',
      AnimeProvider.donghua: '/anime/donghua/episode/$animeId',
      AnimeProvider.samehadaku: '/anime/samehadku/episode/$animeId',
      AnimeProvider.animasu: '/anime/animasu/episode/$animeId',
      AnimeProvider.kusonime: '/anime/cusonive/karature/$animeId',
      AnimeProvider.anoboy: '/anime/anoboy/episode/$animeId',
      AnimeProvider.oploverz: '/anime/oploverz/episode/$animeId',
      AnimeProvider.stream: '/anime/stream/episode/$animeId',
      AnimeProvider.animekuindo: '/anime/animekuindo/episode/$animeId',
      AnimeProvider.nimegami: '/anime/nimegami/episode/$animeId',
      AnimeProvider.alqanime: '/anime/alqanime/episode/$animeId',
      AnimeProvider.donghub: '/anime/donghub/episode/$animeId',
      AnimeProvider.winbu: '/anime/winbu/episode/$animeId',
      AnimeProvider.animecompi: '/anime/animecomp/episode/$animeId',
      AnimeProvider.kuramanime: '/anime/kura/karature/$animeId',
      AnimeProvider.nekopoi: '/anime/nekopoi/episode/$animeId',
    };

    return _makeRequest(endpoints[_currentProvider.provider]!);
  }

  // Fetch Episode Servers
  static Future<Map<String, dynamic>> fetchEpisodeServers(String animeEpisodeId) async {
    final endpoints = {
      AnimeProvider.brainudeu: '/anime/servers?animeEpisodeId=$animeEpisodeId',
      AnimeProvider.donghua: '/anime/donghua/servers/$animeEpisodeId',
      AnimeProvider.samehadaku: '/anime/samehadku/servers/$animeEpisodeId',
      AnimeProvider.animasu: '/anime/animasu/servers/$animeEpisodeId',
      AnimeProvider.kusonime: '/anime/cusonime/servers/$animeEpisodeId',
      AnimeProvider.anoboy: '/anime/anoboy/servers/$animeEpisodeId',
      AnimeProvider.oploverz: '/anime/oploverz/servers/$animeEpisodeId',
      AnimeProvider.stream: '/anime/stream/servers/$animeEpisodeId',
      AnimeProvider.animekuindo: '/anime/animekuindo/servers/$animeEpisodeId',
      AnimeProvider.nimegami: '/anime/nimegami/servers/$animeEpisodeId',
      AnimeProvider.alqanime: '/anime/alqanime/servers/$animeEpisodeId',
      AnimeProvider.donghub: '/anime/donghub/servers/$animeEpisodeId',
      AnimeProvider.winbu: '/anime/winbu/servers/$animeEpisodeId',
      AnimeProvider.animecompi: '/anime/animecomp/servers/$animeEpisodeId',
      AnimeProvider.kuramanime: '/anime/kura/servers/$animeEpisodeId',
      AnimeProvider.nekopoi: '/anime/nekopoi/servers/$animeEpisodeId',
    };

    return _makeRequest(endpoints[_currentProvider.provider]!);
  }

  // Fetch Episode Sources/Streams
  static Future<Map<String, dynamic>> fetchEpisodeSources(
    String animeEpisodeId,
    String server,
    String category,
  ) async {
    final endpoints = {
      AnimeProvider.brainudeu: '/anime/sources?animeEpisodeId=$animeEpisodeId&server=$server&category=$category',
      AnimeProvider.donghua: '/anime/donghua/sources/$animeEpisodeId?server=$server',
      AnimeProvider.samehadaku: '/anime/samehadku/sources/$animeEpisodeId?server=$server',
      AnimeProvider.animasu: '/anime/animasu/sources/$animeEpisodeId?server=$server',
      AnimeProvider.kusonime: '/anime/cusonime/sources/$animeEpisodeId?server=$server',
      AnimeProvider.anoboy: '/anime/anoboy/sources/$animeEpisodeId?server=$server',
      AnimeProvider.oploverz: '/anime/oploverz/sources/$animeEpisodeId?server=$server',
      AnimeProvider.stream: '/anime/stream/sources/$animeEpisodeId?server=$server',
      AnimeProvider.animekuindo: '/anime/animekuindo/sources/$animeEpisodeId?server=$server',
      AnimeProvider.nimegami: '/anime/nimegami/sources/$animeEpisodeId?server=$server',
      AnimeProvider.alqanime: '/anime/alqanime/sources/$animeEpisodeId?server=$server',
      AnimeProvider.donghub: '/anime/donghub/sources/$animeEpisodeId?server=$server',
      AnimeProvider.winbu: '/anime/winbu/server?post=$animeEpisodeId&server=$server',
      AnimeProvider.animecompi: '/anime/animecomp/sources/$animeEpisodeId?server=$server',
      AnimeProvider.kuramanime: '/anime/kura/karature/$animeEpisodeId?server=$server',
      AnimeProvider.nekopoi: '/anime/nekopoi/sources/$animeEpisodeId?server=$server',
    };

    return _makeRequest(endpoints[_currentProvider.provider]!);
  }

  // Fetch Genres
  static Future<Map<String, dynamic>> fetchGenres() async {
    final endpoints = {
      AnimeProvider.brainudeu: '/anime/genres',
      AnimeProvider.donghua: '/anime/donghua/genres',
      AnimeProvider.samehadaku: '/anime/samehadaku/genres',
      AnimeProvider.animasu: '/anime/genres',
      AnimeProvider.kusonime: '/anime/cusnime/all-genres',
      AnimeProvider.anoboy: '/anime/anoboy/genres',
      AnimeProvider.oploverz: '/anime/oploverz/genres',
      AnimeProvider.stream: '/anime/stream/genres',
      AnimeProvider.animekuindo: '/anime/animekuindo/genres',
      AnimeProvider.nimegami: '/anime/nimegami/genre/list',
      AnimeProvider.alqanime: '/anime/alqanime/genres',
      AnimeProvider.donghub: '/anime/donghub/genres',
      AnimeProvider.winbu: '/anime/winbu/genres',
      AnimeProvider.animecompi: '/anime/anisme/genres',
      AnimeProvider.kuramanime: '/anime/kura/properties/genre',
      AnimeProvider.nekopoi: '/anime/nekopoi/genres',
    };

    return _makeRequest(endpoints[_currentProvider.provider]!);
  }

  // Fetch Anime by Genre
  static Future<Map<String, dynamic>> fetchGenreAnimes(String genreSlug, {int page = 1}) async {
    final endpoints = {
      AnimeProvider.brainudeu: '/anime/genre/$genreSlug?page=$page',
      AnimeProvider.donghua: '/anime/donghua/genres/$genreSlug/$page',
      AnimeProvider.samehadaku: '/anime/sameshaku/genres/genres/$genreSlug?page=$page',
      AnimeProvider.animasu: '/anime/animasu/genre/$genreSlug?page=$page',
      AnimeProvider.kusonime: '/anime/cusonyme/genre/$genreSlug',
      AnimeProvider.anoboy: '/anime/anoboy/genre/$genreSlug?page=$page',
      AnimeProvider.oploverz: '/anime/oploverz/genre/$genreSlug?page=$page',
      AnimeProvider.stream: '/anime/stream/genres/$genreSlug?page=$page',
      AnimeProvider.animekuindo: '/anime/animekuindo/genres/$genreSlug',
      AnimeProvider.nimegami: '/anime/nimegami/genre/$genreSlug',
      AnimeProvider.alqanime: '/anime/alqanime/genre/$genreSlug?page=$page',
      AnimeProvider.donghub: '/anime/donghub/genre/slug/$genreSlug',
      AnimeProvider.winbu: '/anime/winbu/genre/$genreSlug?page=$page',
      AnimeProvider.animecompi: '/anime/animcompry/genre/$genreSlug',
      AnimeProvider.kuramanime: '/anime/kura/properties/genre/$genreSlug',
      AnimeProvider.nekopoi: '/anime/nekopoi/genre/$genreSlug',
    };

    return _makeRequest(endpoints[_currentProvider.provider]!);
  }

}
