class AnimeDetail {
  bool? success;
  Data data;

  AnimeDetail({
    this.success,
    required this.data,
  });

  factory AnimeDetail.fromJson(Map<String, dynamic> json) {
    return AnimeDetail(
      success: json['success'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson() ,
    };
  }
}

class Data {
  Anime? anime;
  List<Season>? seasons;
  List<MostPopularAnime>? mostPopularAnimes;
  List<EdAnime>? relatedAnimes;
  List<EdAnime>? recommendedAnimes;

  Data({
    required this.anime,
    required this.seasons,
    required this.mostPopularAnimes,
    required this.relatedAnimes,
    required this.recommendedAnimes,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      anime: Anime.fromJson(json['anime']),
      seasons: List<Season>.from(json['seasons'].map((x) => Season.fromJson(x))),
      mostPopularAnimes: List<MostPopularAnime>.from(
          json['mostPopularAnimes'].map((x) => MostPopularAnime.fromJson(x))),
      relatedAnimes:
      List<EdAnime>.from(json['relatedAnimes'].map((x) => EdAnime.fromJson(x))),
      recommendedAnimes: List<EdAnime>.from(
          json['recommendedAnimes'].map((x) => EdAnime.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'anime': anime!.toJson(),
      'seasons': seasons!.map((x) => x.toJson()).toList(),
      'mostPopularAnimes': mostPopularAnimes!.map((x) => x.toJson()).toList(),
      'relatedAnimes': relatedAnimes!.map((x) => x.toJson()).toList(),
      'recommendedAnimes': recommendedAnimes!.map((x) => x.toJson()).toList(),
    };
  }
}

class Anime {
  Info? info;
  MoreInfo? moreInfo;

  Anime({
    required this.info,
    required this.moreInfo,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      info: Info.fromJson(json['info']),
      moreInfo: MoreInfo.fromJson(json['moreInfo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info': info!.toJson(),
      'moreInfo': moreInfo!.toJson(),
    };
  }
}

class Info {
  String? id;
  int? anilistId;
  int? malId;
  String? name;
  String? poster;
  String? description;
  Stats? stats;
  List<PromotionalVideo>? promotionalVideos;
  List<CharactersVoiceActor>? charactersVoiceActors;

  Info({
    required this.id,
    required this.anilistId,
    required this.malId,
    required this.name,
    required this.poster,
    required this.description,
    required this.stats,
    required this.promotionalVideos,
    required this.charactersVoiceActors,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      id: json['id'],
      anilistId: json['anilistId'],
      malId: json['malId'],
      name: json['name'],
      poster: json['poster'],
      description: json['description'],
      stats: Stats.fromJson(json['stats']),
      promotionalVideos: List<PromotionalVideo>.from(
          json['promotionalVideos'].map((x) => PromotionalVideo.fromJson(x))),
      charactersVoiceActors: List<CharactersVoiceActor>.from(
          json['charactersVoiceActors'].map((x) => CharactersVoiceActor.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'anilistId': anilistId,
      'malId': malId,
      'name': name,
      'poster': poster,
      'description': description,
      'stats': stats!.toJson(),
      'promotionalVideos': promotionalVideos!.map((x) => x.toJson()).toList(),
      'charactersVoiceActors':
      charactersVoiceActors!.map((x) => x.toJson()).toList(),
    };
  }
}

class CharactersVoiceActor {
  Character? character;
  Character? voiceActor;

  CharactersVoiceActor({
    required this.character,
    required this.voiceActor,
  });

  factory CharactersVoiceActor.fromJson(Map<String, dynamic> json) {
    return CharactersVoiceActor(
      character: Character.fromJson(json['character']),
      voiceActor: Character.fromJson(json['voiceActor']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'character': character!.toJson(),
      'voiceActor': voiceActor!.toJson(),
    };
  }
}

class Character {
  String? id;
  String? poster;
  String? name;
  String? cast;

  Character({
    required this.id,
    required this.poster,
    required this.name,
    required this.cast,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      poster: json['poster'],
      name: json['name'],
      cast: json['cast'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poster': poster,
      'name': name,
      'cast': cast,
    };
  }
}

class PromotionalVideo {
  String? title;
  String? source;
  String? thumbnail;

  PromotionalVideo({
    required this.title,
    required this.source,
    required this.thumbnail,
  });

  factory PromotionalVideo.fromJson(Map<String, dynamic> json) {
    return PromotionalVideo(
      title: json['title'],
      source: json['source'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'source': source,
      'thumbnail': thumbnail,
    };
  }
}

class Stats {
  String? rating;
  String? quality;
  Episodes? episodes;
  String? type;
  String? duration;

  Stats({
    required this.rating,
    required this.quality,
    required this.episodes,
    required this.type,
    required this.duration,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      rating: json['rating'],
      quality: json['quality'],
      episodes: Episodes.fromJson(json['episodes']),
      type: json['type'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'quality': quality,
      'episodes': episodes!.toJson(),
      'type': type,
      'duration': duration,
    };
  }
}

class Episodes {
  int? sub;
  int? dub;

  Episodes({
    required this.sub,
    this.dub,
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
  Movie,
  ONA,
  OVA,
  Special,
  TV,
  Null,
  Music
}

class MoreInfo {
  String? japanese;
  String? synonyms;
  String? aired;
  String? premiered;
  String? duration;
  String? status;
  String? malscore;
  List<String>? genres;
  String? studios;
  Iterable<dynamic>? producers;

  MoreInfo({
    required this.japanese,
    required this.synonyms,
    required this.aired,
    required this.premiered,
    required this.duration,
    required this.status,
    required this.malscore,
    required this.genres,
    required this.studios,
    required this.producers,
  });

  factory MoreInfo.fromJson(Map<String, dynamic> json) {
    return MoreInfo(
      japanese: json['japanese'],
      synonyms: json['synonyms'],
      aired: json['aired'],
      premiered: json['premiered'],
      duration: json['duration'],
      status: json['status'],
      malscore: json['malscore'],
      genres: (json['genres'] as List<dynamic>?)?.map((x) => x.toString()).toList(),
      studios: json['studios'],
      producers: (json['producers'] as List<dynamic>?)?.map((x) => x.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'japanese': japanese,
      'synonyms': synonyms,
      'aired': aired,
      'premiered': premiered,
      'duration': duration,
      'status': status,
      'malscore': malscore,
      'genres': genres,
      'studios': studios,
      'producers': producers,
    };
  }
}

class MostPopularAnime {
  String? id;
  String? name;
  String? jname;
  String? poster;
  Episodes? episodes;
  String? type;

  MostPopularAnime({
    required this.id,
    required this.name,
    required this.jname,
    required this.poster,
    required this.episodes,
    required this.type,
  });

  factory MostPopularAnime.fromJson(Map<String, dynamic> json) {
    return MostPopularAnime(
      id: json['id'],
      name: json['name'],
      jname: json['jname'],
      poster: json['poster'],
      episodes: Episodes.fromJson(json['episodes']),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'jname': jname,
      'poster': poster,
      'episodes': episodes!.toJson(),
      'type': type,
    };
  }
}

class EdAnime {
  String? id;
  String? name;
  String? jname;
  String? poster;
  String? duration;
  String? type;
  String? rating;
  Episodes? episodes;

  EdAnime({
    required this.id,
    required this.name,
    required this.jname,
    required this.poster,
    this.duration,
    required this.type,
    this.rating,
    required this.episodes,
  });

  factory EdAnime.fromJson(Map<String, dynamic> json) {
    return EdAnime(
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
      'episodes': episodes!.toJson(),
    };
  }
}

class Season {
  String? id;
  String? name;
  String? title;
  String? poster;
  bool? isCurrent;

  Season({
    required this.id,
    required this.name,
    required this.title,
    required this.poster,
    required this.isCurrent,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      poster: json['poster'],
      isCurrent: json['isCurrent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'poster': poster,
      'isCurrent': isCurrent,
    };
  }
}
