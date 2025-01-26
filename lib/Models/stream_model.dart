class EpisodeDetail {
  bool? success;
  Data? data;

  EpisodeDetail({
    this.success,
    this.data,
  });

  // Factory constructor for deserialization
  factory EpisodeDetail.fromJson(Map<String, dynamic> json) {
    return EpisodeDetail(
      success: json['success'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  // Method for serialization
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class Data {
  List<Track>? tracks;
  Tro? intro;
  Tro? outro;
  List<Source>? sources;
  int? anilistId;
  int? malId;

  Data({
    this.tracks,
    this.intro,
    this.outro,
    this.sources,
    this.anilistId,
    this.malId,
  });

  // Factory constructor for deserialization
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      tracks: json['tracks'] != null
          ? (json['tracks'] as List).map((e) => Track.fromJson(e)).toList()
          : null,
      intro: json['intro'] != null ? Tro.fromJson(json['intro']) : null,
      outro: json['outro'] != null ? Tro.fromJson(json['outro']) : null,
      sources: json['sources'] != null
          ? (json['sources'] as List).map((e) => Source.fromJson(e)).toList()
          : null,
      anilistId: json['anilistId'],
      malId: json['malId'],
    );
  }

  // Method for serialization
  Map<String, dynamic> toJson() {
    return {
      'tracks': tracks?.map((e) => e.toJson()).toList(),
      'intro': intro?.toJson(),
      'outro': outro?.toJson(),
      'sources': sources?.map((e) => e.toJson()).toList(),
      'anilistId': anilistId,
      'malId': malId,
    };
  }
}

class Tro {
  int? start;
  int? end;

  Tro({
    this.start,
    this.end,
  });

  // Factory constructor for deserialization
  factory Tro.fromJson(Map<String, dynamic> json) {
    return Tro(
      start: json['start'],
      end: json['end'],
    );
  }

  // Method for serialization
  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'end': end,
    };
  }
}

class Source {
  String? url;
  String? type;

  Source({
    this.url,
    this.type,
  });

  // Factory constructor for deserialization
  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      url: json['url'],
      type: json['type'],
    );
  }

  // Method for serialization
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'type': type,
    };
  }
}

class Track {
  String? file;
  String? label;
  String? kind;
  bool? trackDefault;

  Track({
    this.file,
    this.label,
    this.kind,
    this.trackDefault,
  });

  // Factory constructor for deserialization
  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      file: json['file'],
      label: json['label'],
      kind: json['kind'],
      trackDefault: json['default'],
    );
  }

  // Method for serialization
  Map<String, dynamic> toJson() {
    return {
      'file': file,
      'label': label,
      'kind': kind,
      'default': trackDefault,
    };
  }
}