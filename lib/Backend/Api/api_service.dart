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
}
