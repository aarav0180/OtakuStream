import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'BASE-URL';

  static Future<Map<String, dynamic>> fetchHomeAnime() async {
    final response = await http.get(Uri.parse('/endpoint1'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);

    } else {
      throw Exception("Failed to load Home Anime: ${response.statusCode}");
    }
  }

  static Future<Map<String, dynamic>> fetchAnimeDetail(String id) async {
    final response = await http.get(Uri.parse('/endpoint2'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);

    } else {
      throw Exception("Failed to load Home Anime: ${response.statusCode}");
    }
  }

  static Future<Map<String, dynamic>> fetchEpisodes(String animeId) async {
    final response = await http.get(Uri.parse('/endpoint3'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load episodes: ${response.statusCode}");
    }
  }

  static Future<Map<String, dynamic>> fetchEpisodeServers(String animeEpisodeId) async {
    final response = await http.get(Uri.parse('/endpoint4'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load servers: ${response.statusCode}");
    }
  }

  static Future<Map<String, dynamic>> fetchEpisodeSources(String animeEpisodeId, String server, String category) async {
    final response = await http.get(
      Uri.parse('/endpoint4'),
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
