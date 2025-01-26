class HomeAnime {
  bool success;
  Data data;

  HomeAnime({
    required this.success,
    required this.data,
  });

  factory HomeAnime.fromJson(Map<String, dynamic> json) {
    return HomeAnime(
      success: json['success'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

class Data {
  List<SpotlightAnime> spotlightAnimes;
  List<LatestCompletedAnime> trendingAnimes;
  List<Anime> latestEpisodeAnimes;
  List<Anime> topUpcomingAnimes;
  Top10Animes top10Animes;
  List<LatestCompletedAnime> topAiringAnimes;
  List<MostAnime> mostPopularAnimes;
  List<MostAnime> mostFavoriteAnimes;
  List<LatestCompletedAnime> latestCompletedAnimes;
  List<String> genres;

  Data({
    required this.spotlightAnimes,
    required this.trendingAnimes,
    required this.latestEpisodeAnimes,
    required this.topUpcomingAnimes,
    required this.top10Animes,
    required this.topAiringAnimes,
    required this.mostPopularAnimes,
    required this.mostFavoriteAnimes,
    required this.latestCompletedAnimes,
    required this.genres,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      spotlightAnimes: (json['spotlightAnimes'] as List)
          .map((e) => SpotlightAnime.fromJson(e))
          .toList(),
      trendingAnimes: (json['trendingAnimes'] as List)
          .map((e) => LatestCompletedAnime.fromJson(e))
          .toList(),
      latestEpisodeAnimes: (json['latestEpisodeAnimes'] as List)
          .map((e) => Anime.fromJson(e))
          .toList(),
      topUpcomingAnimes: (json['topUpcomingAnimes'] as List)
          .map((e) => Anime.fromJson(e))
          .toList(),
      top10Animes: Top10Animes.fromJson(json['top10Animes']),
      topAiringAnimes: (json['topAiringAnimes'] as List)
          .map((e) => LatestCompletedAnime.fromJson(e))
          .toList(),
      mostPopularAnimes: (json['mostPopularAnimes'] as List)
          .map((e) => MostAnime.fromJson(e))
          .toList(),
      mostFavoriteAnimes: (json['mostFavoriteAnimes'] as List)
          .map((e) => MostAnime.fromJson(e))
          .toList(),
      latestCompletedAnimes: (json['latestCompletedAnimes'] as List)
          .map((e) => LatestCompletedAnime.fromJson(e))
          .toList(),
      genres: List<String>.from(json['genres']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spotlightAnimes': spotlightAnimes.map((e) => e.toJson()).toList(),
      'trendingAnimes': trendingAnimes.map((e) => e.toJson()).toList(),
      'latestEpisodeAnimes': latestEpisodeAnimes.map((e) => e.toJson()).toList(),
      'topUpcomingAnimes': topUpcomingAnimes.map((e) => e.toJson()).toList(),
      'top10Animes': top10Animes.toJson(),
      'topAiringAnimes': topAiringAnimes.map((e) => e.toJson()).toList(),
      'mostPopularAnimes': mostPopularAnimes.map((e) => e.toJson()).toList(),
      'mostFavoriteAnimes': mostFavoriteAnimes.map((e) => e.toJson()).toList(),
      'latestCompletedAnimes': latestCompletedAnimes.map((e) => e.toJson()).toList(),
      'genres': genres,
    };
  }
}

class LatestCompletedAnime {
  String id;
  String name;
  String jname;
  String poster;
  Episodes? episodes;
  Type? type;
  int? rank;

  LatestCompletedAnime({
    required this.id,
    required this.name,
    required this.jname,
    required this.poster,
    this.episodes,
    this.type,
    this.rank,
  });

  factory LatestCompletedAnime.fromJson(Map<String, dynamic> json) {
    return LatestCompletedAnime(
      id: json['id'],
      name: json['name'],
      jname: json['jname'],
      poster: json['poster'],
      episodes: json['episodes'] != null
          ? Episodes.fromJson(json['episodes'])
          : null,
      type: json['type'] != null ? Type.values.byName(json['type']) : null,
      rank: json['rank'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'jname': jname,
      'poster': poster,
      'episodes': episodes?.toJson(),
      'type': type?.name,
      'rank': rank,
    };
  }
}

class Episodes {
  int? sub;
  int? dub;

  Episodes({
    required this.sub,
    required this.dub,
  });

  factory Episodes.fromJson(Map<String, dynamic> json) {
    return Episodes(
      sub: json['sub'],
      dub: json['dub'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sub': sub,
      'dub': dub,
    };
  }
}

enum Type {
  OVA,
  TV,
  ONA,
  Movie,
  Special,
  Null,
  Music
}

class Anime {
  String id;
  String name;
  String jname;
  String poster;
  String duration;
  String type;
  String? rating;
  Episodes episodes;

  Anime({
    required this.id,
    required this.name,
    required this.jname,
    required this.poster,
    required this.duration,
    required this.type,
    required this.rating,
    required this.episodes,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['id'],
      name: json['name'],
      jname: json['jname'],
      poster: json['poster'],
      duration: json['duration'],
      type: json['type'],
      rating: json['rating'],
      episodes: Episodes.fromJson(json['episodes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'jname': jname,
      'poster': poster,
      'duration': duration,
      'type': type,
      'rating': rating,
      'episodes': episodes.toJson(),
    };
  }
}

class MostAnime {
  String id;
  String name;
  String jname;
  String poster;
  Episodes episodes;
  Type type;

  MostAnime({
    required this.id,
    required this.name,
    required this.jname,
    required this.poster,
    required this.episodes,
    required this.type,
  });

  factory MostAnime.fromJson(Map<String, dynamic> json) {
    return MostAnime(
      id: json['id'],
      name: json['name'],
      jname: json['jname'],
      poster: json['poster'],
      episodes: Episodes.fromJson(json['episodes']),
      type: Type.values.byName(json['type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'jname': jname,
      'poster': poster,
      'episodes': episodes.toJson(),
      'type': type.name,
    };
  }
}

class SpotlightAnime {
  int rank;
  String id;
  String name;
  String description;
  String poster;
  String jname;
  Episodes episodes;
  Type type;
  List<String> otherInfo;

  SpotlightAnime({
    required this.rank,
    required this.id,
    required this.name,
    required this.description,
    required this.poster,
    required this.jname,
    required this.episodes,
    required this.type,
    required this.otherInfo,
  });

  factory SpotlightAnime.fromJson(Map<String, dynamic> json) {
    return SpotlightAnime(
      rank: json['rank'],
      id: json['id'],
      name: json['name'],
      description: json['description'],
      poster: json['poster'],
      jname: json['jname'],
      episodes: Episodes.fromJson(json['episodes']),
      type: Type.values.byName(json['type']),
      otherInfo: List<String>.from(json['otherInfo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'id': id,
      'name': name,
      'description': description,
      'poster': poster,
      'jname': jname,
      'episodes': episodes.toJson(),
      'type': type.name,
      'otherInfo': otherInfo,
    };
  }
}

class Top10Animes {
  List<LatestCompletedAnime> today;
  List<LatestCompletedAnime> week;
  List<LatestCompletedAnime> month;

  Top10Animes({
    required this.today,
    required this.week,
    required this.month,
  });

  factory Top10Animes.fromJson(Map<String, dynamic> json) {
    return Top10Animes(
      today: (json['today'] as List)
          .map((e) => LatestCompletedAnime.fromJson(e))
          .toList(),
      week: (json['week'] as List)
          .map((e) => LatestCompletedAnime.fromJson(e))
          .toList(),
      month: (json['month'] as List)
          .map((e) => LatestCompletedAnime.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'today': today.map((e) => e.toJson()).toList(),
      'week': week.map((e) => e.toJson()).toList(),
      'month': month.map((e) => e.toJson()).toList(),
    };
  }
}
