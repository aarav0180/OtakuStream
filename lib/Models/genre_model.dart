class Genre {
  bool? success;
  Data? data;

  Genre({
    this.success,
    this.data,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    success: json['success'],
    data: json['data'] != null ? Data.fromJson(json['data']) : null,
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'data': data?.toJson(),
  };
}

class Data {
  String? genreName;
  List<Anime>? animes;
  List<String>? genres;
  List<Anime>? topAiringAnimes;
  int? totalPages;
  bool? hasNextPage;
  int? currentPage;

  Data({
    this.genreName,
    this.animes,
    this.genres,
    this.topAiringAnimes,
    this.totalPages,
    this.hasNextPage,
    this.currentPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    genreName: json['genreName'],
    animes: json['animes'] != null
        ? List<Anime>.from(json['animes'].map((x) => Anime.fromJson(x)))
        : null,
    genres: json['genres'] != null
        ? List<String>.from(json['genres'].map((x) => x))
        : null,
    topAiringAnimes: json['topAiringAnimes'] != null
        ? List<Anime>.from(
        json['topAiringAnimes'].map((x) => Anime.fromJson(x)))
        : null,
    totalPages: json['totalPages'],
    hasNextPage: json['hasNextPage'],
    currentPage: json['currentPage'],
  );

  Map<String, dynamic> toJson() => {
    'genreName': genreName,
    'animes': animes?.map((x) => x.toJson()).toList(),
    'genres': genres,
    'topAiringAnimes': topAiringAnimes?.map((x) => x.toJson()).toList(),
    'totalPages': totalPages,
    'hasNextPage': hasNextPage,
    'currentPage': currentPage,
  };
}

class Anime {
  String? id;
  String? name;
  String? jname;
  String? poster;
  String? duration;
  Type? type;
  String? rating;
  Episodes? episodes;

  Anime({
    this.id,
    this.name,
    this.jname,
    this.poster,
    this.duration,
    this.type,
    this.rating,
    this.episodes,
  });

  factory Anime.fromJson(Map<String, dynamic> json) => Anime(
    id: json['id'],
    name: json['name'],
    jname: json['jname'],
    poster: json['poster'],
    duration: json['duration'],
    type: json['type'] != null ? typeValues.map[json['type']] : null,
    rating: json['rating'],
    episodes: json['episodes'] != null
        ? Episodes.fromJson(json['episodes'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'jname': jname,
    'poster': poster,
    'duration': duration,
    'type': type != null ? typeValues.reverse[type] : null,
    'rating': rating,
    'episodes': episodes?.toJson(),
  };
}

class Episodes {
  int? sub;
  int? dub;

  Episodes({
    this.sub,
    this.dub,
  });

  factory Episodes.fromJson(Map<String, dynamic> json) => Episodes(
    sub: json['sub'],
    dub: json['dub'],
  );

  Map<String, dynamic> toJson() => {
    'sub': sub,
    'dub': dub,
  };
}

enum Type {
  Movie,
  ONA,
  OVA,
  Special,
  TV,
  Null, }

final typeValues = EnumValues({
  'OVA': Type.OVA,
  'Special': Type.Special,
  'ONA': Type.ONA,
  'Movie': Type.Movie,
  'Null': Type.Null,
  'TV': Type.TV,
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
