import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://anime-kohl-five.vercel.app/api/v2';

  static Future<Map<String, dynamic>> fetchHomeAnime() async {
    final response = await http.get(Uri.parse('$baseUrl/hianime/home'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);

    } else {
      throw Exception("Failed to load Home Anime: ${response.statusCode}");
    }
  }

  static Future<Map<String, dynamic>> fetchAnimeDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/hianime/anime/$id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);

    } else {
      throw Exception("Failed to load Home Anime: ${response.statusCode}");
    }
  }

  static Future<Map<String, dynamic>> fetchEpisodes(String animeId) async {
    final response = await http.get(Uri.parse('$baseUrl/hianime/anime/$animeId/episodes'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load episodes: ${response.statusCode}");
    }
  }

  static Future<Map<String, dynamic>> fetchEpisodeServers(String animeEpisodeId) async {
    final response = await http.get(Uri.parse('$baseUrl/hianime/episode/servers?animeEpisodeId=$animeEpisodeId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load servers: ${response.statusCode}");
    }
  }

  static Future<Map<String, dynamic>> fetchEpisodeSources(String animeEpisodeId, String server, String category) async {
    final response = await http.get(
      Uri.parse('$baseUrl/hianime/episode/sources?animeEpisodeId=$animeEpisodeId&server=$server&category=$category'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load sources: ${response.statusCode}");
    }
  }

  static Future<Map<String, dynamic>> fetchSearchAnimes(String query, int currentPage) async {
    final response = await http.get(Uri.parse('$baseUrl/hianime/search?q=$query&page=$currentPage'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load servers: ${response.statusCode}");
    }
  }

  static Future<Map<String, dynamic>> fetchGenreAnimes(String query, int currentPage) async {
    final response = await http.get(Uri.parse('$baseUrl/hianime/genre/$query?page=$currentPage'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load servers: ${response.statusCode}");
    }
  }

}
