/// Universal Response Adapter
/// Normalizes different anime provider API response structures into internal model schemas
class ResponseAdapter {
  /// Normalize home page response from any provider
  static Map<String, dynamic> normalizeHomeResponse(Map<String, dynamic> response) {
    // If already in expected format with spotlight/trending data
    if (response['data'] is Map) {
      final data = Map<String, dynamic>.from(response['data'] as Map);
      if (data.containsKey('spotlightAnimes') || data.containsKey('trendingAnimes')) {
        return {
          'success': response['success'] ?? response['status'] == 'success' || response['status'] == 200,
          'data': data,
        };
      }
    }

    // Parse raw anime list and normalize
    final items = parseAnimeList(response)
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();

    final normalized = items.asMap().entries.map((entry) {
      return _normalizeGenericAnimeItem(entry.value, entry.key + 1);
    }).toList();

    final top10 = normalized.take(10).toList();

    return {
      'success': response['success'] ?? true,
      'data': {
        'spotlightAnimes': normalized.isNotEmpty ? [normalized.first] : [],
        'trendingAnimes': normalized.take(5).toList(),
        'topAiringAnimes': top10,
        'top10Animes': top10,
        'recentlyUpdatedAnimes': normalized,
        'animes': normalized,
      }
    };
  }

  /// Normalize anime detail response
  static Map<String, dynamic> normalizeAnimeDetailResponse(Map<String, dynamic> response) {
    if (response['data'] is Map) {
      final data = Map<String, dynamic>.from(response['data'] as Map);
      if (data.containsKey('anime') || data.containsKey('info')) {
        return {
          'success': response['success'] ?? true,
          'data': data,
        };
      }
    }

    // Single anime detail normalization
    final anime = _normalizeGenericAnimeItem(response, 1);
    return {
      'success': response['success'] ?? true,
      'data': {
        'anime': anime,
        'info': anime,
      }
    };
  }

  /// Normalize episode list response
  static Map<String, dynamic> normalizeEpisodeResponse(Map<String, dynamic> response) {
    final episodes = parseEpisodeList(response)
        .whereType<Map>()
        .map((ep) => Map<String, dynamic>.from(ep as Map))
        .map((ep) => normalizeEpisodeItem(ep))
        .toList();

    return {
      'success': response['success'] ?? true,
      'data': episodes.isNotEmpty ? episodes : [],
    };
  }

  /// Normalize server/source list response
  static Map<String, dynamic> normalizeServerResponse(Map<String, dynamic> response) {
    final servers = parseStreamServers(response)
        .whereType<Map>()
        .map((srv) => Map<String, dynamic>.from(srv as Map))
        .map((srv) => normalizeServerItem(srv))
        .toList();

    return {
      'success': response['success'] ?? true,
      'data': servers.isNotEmpty ? servers : [],
    };
  }

  /// Normalize stream URL response
  static Map<String, dynamic> normalizeStreamResponse(Map<String, dynamic> response) {
    if (response['data'] is Map) {
      final data = Map<String, dynamic>.from(response['data'] as Map);
      if (data.containsKey('link') || data.containsKey('url') || data.containsKey('sources')) {
        return {
          'success': response['success'] ?? true,
          'data': data,
        };
      }
    }

    // Fallback: return as-is if structured
    return {
      'success': response['success'] ?? true,
      'data': response,
    };
  }

  /// Generic anime item normalization helper
  static Map<String, dynamic> _normalizeGenericAnimeItem(Map<String, dynamic> item, int index) {
    return {
      'mal_id': _extractId(item),
      'url': _extractUrl(item),
      'images': {
        'jpg': {
          'image_url': _extractImageUrl(item),
          'small_image_url': _extractImageUrl(item),
          'large_image_url': _extractImageUrl(item),
        }
      },
      'trailer': {
        'youtube_id': _extractTrailerId(item),
      },
      'approved': true,
      'titles': [
        {
          'type': 'Default',
          'title': _extractTitle(item),
        }
      ],
      'title': _extractTitle(item),
      'title_english': _extractTitle(item),
      'title_japanese': _extractTitle(item),
      'title_synonyms': _extractAlternativeTitles(item),
      'type': _extractType(item),
      'source': _extractSource(item),
      'episodes': _extractEpisodes(item),
      'status': _extractStatus(item),
      'airing': _extractAiring(item),
      'aired': {
        'from': _extractAiredDate(item),
        'to': null,
        'prop': {
          'from': {'year': _extractYear(item), 'month': 1, 'day': 1},
          'to': {'year': null, 'month': null, 'day': null}
        },
        'string': _extractAiredDate(item)
      },
      'duration': _extractDuration(item),
      'rating': 'PG-13',
      'score': _extractScore(item),
      'scored_by': 0,
      'rank': index,
      'popularity': 0,
      'members': 0,
      'genres': _extractGenres(item).map((g) => {'mal_id': 1, 'type': 'anime', 'name': g, 'url': ''}).toList(),
      'explicit_genres': [],
      'themes': [],
      'demographics': [],
      'studios': [
        {'mal_id': 1, 'type': 'anime', 'name': _extractStudio(item), 'url': ''}
      ],
      'relations': [],
      'external': [],
      'streaming': [],
    };
  }

  // ============ Helper Methods for Extraction ============

  static String _extractId(Map<String, dynamic> item) {
    final idKeys = ['id', 'mal_id', '_id', 'anime_id'];
    for (final key in idKeys) {
      if (item.containsKey(key)) return item[key].toString();
    }
    return '';
  }

  static String _extractTitle(Map<String, dynamic> item) {
    final titleKeys = ['title', 'name', 'judul', 'english', 'jname'];
    for (final key in titleKeys) {
      if (item.containsKey(key) && item[key] != null && item[key].toString().isNotEmpty) {
        return item[key].toString();
      }
    }
    return '';
  }

  static String _extractImageUrl(Map<String, dynamic> item) {
    final imageKeys = [
      'image',
      'image_url',
      'poster',
      'poster_url',
      'cover',
      'cover_url',
      'images',
    ];
    for (final key in imageKeys) {
      if (item.containsKey(key) && item[key] != null) {
        final img = item[key];
        if (img is String) return img;
        if (img is Map && img.containsKey('jpg')) return img['jpg']['image_url'] ?? '';
      }
    }
    return '';
  }

  static String _extractType(Map<String, dynamic> item) {
    final typeKeys = ['type', 'kind', 'category'];
    for (final key in typeKeys) {
      if (item.containsKey(key) && item[key] != null) {
        return item[key].toString();
      }
    }
    return 'TV';
  }

  static String _extractStatus(Map<String, dynamic> item) {
    final statusKeys = ['status', 'airing_status', 'state', 'estado', 'air_status'];
    for (final key in statusKeys) {
      if (item.containsKey(key) && item[key] != null) {
        return item[key].toString();
      }
    }
    return '';
  }

  static int _extractEpisodes(Map<String, dynamic> item) {
    final episodeKeys = ['episodes', 'total_episodes', 'episode_count', 'jumlah_episode'];
    for (final key in episodeKeys) {
      if (item.containsKey(key) && item[key] != null) {
        try {
          return int.parse(item[key].toString().replaceAll(RegExp(r'[^0-9]'), ''));
        } catch (_) {}
      }
    }
    return 0;
  }

  static String _extractStudio(Map<String, dynamic> item) {
    final studioKeys = ['studio', 'studios', 'production', 'producer'];
    for (final key in studioKeys) {
      if (item.containsKey(key) && item[key] != null) {
        final studio = item[key];
        if (studio is String) return studio;
        if (studio is List && studio.isNotEmpty) return studio[0].toString();
      }
    }
    return '';
  }

  static List<String> _extractGenres(Map<String, dynamic> item) {
    final genreKeys = ['genres', 'category', 'categories', 'tags', 'tags_name', 'kategori'];
    for (final key in genreKeys) {
      if (item.containsKey(key) && item[key] != null) {
        final genres = item[key];
        if (genres is List) {
          return genres
              .map((g) => g is Map ? (g['name'] ?? g['title'] ?? g.toString()) : g.toString())
              .toList()
              .cast<String>();
        } else if (genres is String) {
          return genres.split(',').map((g) => g.trim()).toList();
        }
      }
    }
    return [];
  }

  static int _extractYear(Map<String, dynamic> item) {
    final yearKeys = ['year', 'aired', 'release_year', 'release_date', 'start_date', 'date'];
    for (final key in yearKeys) {
      if (item.containsKey(key) && item[key] != null) {
        try {
          final value = item[key].toString();
          if (value.length >= 4) {
            return int.parse(value.substring(0, 4));
          }
        } catch (_) {}
      }
    }
    return DateTime.now().year;
  }

  static List<String> _extractAlternativeTitles(Map<String, dynamic> item) {
    final altKeys = ['alternative_titles', 'other_titles', 'synonyms', 'judul_alternatif'];
    for (final key in altKeys) {
      if (item.containsKey(key) && item[key] != null) {
        final altTitles = item[key];
        if (altTitles is List) {
          return altTitles
              .map((t) => t is Map ? (t['title'] ?? t['name'] ?? t.toString()) : t.toString())
              .toList()
              .cast<String>();
        } else if (altTitles is String) {
          return altTitles.split(',').map((t) => t.trim()).toList();
        }
      }
    }
    return [];
  }

  static String _extractUrl(Map<String, dynamic> item) {
    final urlKeys = ['url', 'link', 'slug', 'href'];
    for (final key in urlKeys) {
      if (item.containsKey(key) && item[key] != null) {
        return item[key].toString();
      }
    }
    return '';
  }

  static String _extractSource(Map<String, dynamic> item) {
    final sourceKeys = ['source'];
    for (final key in sourceKeys) {
      if (item.containsKey(key) && item[key] != null) {
        return item[key].toString();
      }
    }
    return 'Original';
  }

  static bool _extractAiring(Map<String, dynamic> item) {
    final status = _extractStatus(item).toLowerCase();
    return status.contains('airing') || status.contains('ongoing');
  }

  static String _extractAiredDate(Map<String, dynamic> item) {
    final dateKeys = ['aired', 'air_date', 'start_date', 'date'];
    for (final key in dateKeys) {
      if (item.containsKey(key) && item[key] != null) {
        return item[key].toString();
      }
    }
    return '';
  }

  static String _extractDuration(Map<String, dynamic> item) {
    final durationKeys = ['duration'];
    for (final key in durationKeys) {
      if (item.containsKey(key) && item[key] != null) {
        return item[key].toString();
      }
    }
    return '24 min per ep';
  }

  static num _extractScore(Map<String, dynamic> item) {
    final scoreKeys = ['score', 'rating', 'imdb_rating', 'myanimelist_score'];
    for (final key in scoreKeys) {
      if (item.containsKey(key) && item[key] != null) {
        try {
          return num.parse(item[key].toString());
        } catch (_) {}
      }
    }
    return 0.0;
  }

  static String _extractTrailerId(Map<String, dynamic> item) {
    final trailerKeys = ['trailer_url', 'trailer', 'youtube_id', 'trailer_id'];
    for (final key in trailerKeys) {
      if (item.containsKey(key) && item[key] != null) {
        return item[key].toString();
      }
    }
    return '';
  }

  // ============ Episode Parsing & Normalization ============

  static List<dynamic> parseEpisodeList(Map<String, dynamic> response) {
    final episodeKeys = [
      'episodes',
      'data',
      'results',
      'content',
      'items',
      'list',
      'episode_list',
      'ep_list',
    ];

    for (final key in episodeKeys) {
      if (response.containsKey(key)) {
        final value = response[key];
        if (value is List) return value;
      }
    }
    return [];
  }

  static Map<String, dynamic> normalizeEpisodeItem(Map<String, dynamic> episode) {
    return {
      'id': _extractEpisodeId(episode),
      'episode_no': _extractEpisodeNumber(episode),
      'title': _extractEpisodeTitle(episode),
      'description': _extractEpisodeDescription(episode),
      'air_date': _extractEpisodeAirDate(episode),
      'thumbnail': _extractEpisodeThumbnail(episode),
      'url': _extractEpisodeUrl(episode),
    };
  }

  static String _extractEpisodeId(Map<String, dynamic> episode) {
    final idKeys = ['id', 'episode_id', 'mal_id', 'slug', '_id'];
    for (final key in idKeys) {
      if (episode.containsKey(key) && episode[key] != null) {
        return episode[key].toString();
      }
    }
    return '';
  }

  static int _extractEpisodeNumber(Map<String, dynamic> episode) {
    final noKeys = ['episode_no', 'number', 'ep_no', 'episode', 'no'];
    for (final key in noKeys) {
      if (episode.containsKey(key) && episode[key] != null) {
        try {
          return int.parse(episode[key].toString().replaceAll(RegExp(r'[^0-9]'), ''));
        } catch (_) {}
      }
    }
    return 0;
  }

  static String _extractEpisodeTitle(Map<String, dynamic> episode) {
    final titleKeys = ['title', 'name', 'episode_title', 'judul'];
    for (final key in titleKeys) {
      if (episode.containsKey(key) && episode[key] != null) {
        return episode[key].toString();
      }
    }
    return '';
  }

  static String _extractEpisodeDescription(Map<String, dynamic> episode) {
    final descKeys = ['description', 'synopsis', 'summary', 'desc'];
    for (final key in descKeys) {
      if (episode.containsKey(key) && episode[key] != null) {
        return episode[key].toString();
      }
    }
    return '';
  }

  static String _extractEpisodeAirDate(Map<String, dynamic> episode) {
    final dateKeys = ['air_date', 'date', 'aired', 'release_date'];
    for (final key in dateKeys) {
      if (episode.containsKey(key) && episode[key] != null) {
        return episode[key].toString();
      }
    }
    return '';
  }

  static String _extractEpisodeThumbnail(Map<String, dynamic> episode) {
    final thumbKeys = ['image', 'thumbnail', 'poster', 'cover', 'image_url'];
    for (final key in thumbKeys) {
      if (episode.containsKey(key) && episode[key] != null) {
        return episode[key].toString();
      }
    }
    return '';
  }

  static String _extractEpisodeUrl(Map<String, dynamic> episode) {
    final urlKeys = ['url', 'link', 'href'];
    for (final key in urlKeys) {
      if (episode.containsKey(key) && episode[key] != null) {
        return episode[key].toString();
      }
    }
    return '';
  }

  // ============ Server/Source Parsing & Normalization ============

  static List<dynamic> parseStreamServers(Map<String, dynamic> response) {
    final serverKeys = [
      'servers',
      'sources',
      'data',
      'results',
      'links',
      'streams',
      'stream_links',
    ];

    for (final key in serverKeys) {
      if (response.containsKey(key)) {
        final value = response[key];
        if (value is List) return value;
      }
    }
    return [];
  }

  static Map<String, dynamic> normalizeServerItem(Map<String, dynamic> server) {
    return {
      'id': _extractServerId(server),
      'name': _extractServerName(server),
      'url': _extractServerUrl(server),
      'quality': _extractServerQuality(server),
      'type': _extractServerType(server),
    };
  }

  static String _extractServerId(Map<String, dynamic> server) {
    final idKeys = ['id', 'server_id', 'source_id', 'server', 'name', 'slug', 'host'];
    for (final key in idKeys) {
      if (server.containsKey(key) && server[key] != null) {
        return server[key].toString();
      }
    }
    return '';
  }

  static String _extractServerName(Map<String, dynamic> server) {
    final nameKeys = ['server', 'name', 'source', 'host', 'provider'];
    for (final key in nameKeys) {
      if (server.containsKey(key) && server[key] != null) {
        return server[key].toString();
      }
    }
    return '';
  }

  static String _extractServerUrl(Map<String, dynamic> server) {
    final urlKeys = ['url', 'link', 'embed_url', 'streaming_url', 'iframe'];
    for (final key in urlKeys) {
      if (server.containsKey(key) && server[key] != null) {
        return server[key].toString();
      }
    }
    return '';
  }

  static String _extractServerQuality(Map<String, dynamic> server) {
    final qualityKeys = ['quality', 'resolution', 'quality_tag'];
    for (final key in qualityKeys) {
      if (server.containsKey(key) && server[key] != null) {
        return server[key].toString();
      }
    }
    return '720p';
  }

  static String _extractServerType(Map<String, dynamic> server) {
    final typeKeys = ['type', 'category', 'kind'];
    for (final key in typeKeys) {
      if (server.containsKey(key) && server[key] != null) {
        return server[key].toString();
      }
    }
    return 'sub';
  }

  /// Parse generic anime list from various response formats
  static List<dynamic> parseAnimeList(Map<String, dynamic> response) {
    final animeKeys = [
      'animes',
      'data',
      'results',
      'items',
      'list',
      'content',
      'anime',
    ];

    for (final key in animeKeys) {
      if (response.containsKey(key)) {
        final value = response[key];
        if (value is List) return value;
      }
    }
    return [];
  }
}
