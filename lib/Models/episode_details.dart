// class EpisodeModel {
//   final bool success;
//   final EpisodeData data;
//
//   EpisodeModel({required this.success, required this.data});
//
//   factory EpisodeModel.fromJson(Map<String, dynamic> json) {
//     return EpisodeModel(
//       success: json['success'] ?? false,
//       data: EpisodeData.fromJson(json['data'] ?? {}),
//     );
//   }
// }
//
// class EpisodeData {
//   final int totalEpisodes;
//   final List<Episode> episodes;
//
//   EpisodeData({
//     required this.totalEpisodes,
//     required this.episodes,
//   });
//
//   factory EpisodeData.fromJson(Map<String, dynamic> json) {
//     return EpisodeData(
//       totalEpisodes: json['totalEpisodes'] ?? 0,
//       episodes: (json['episodes'] as List? ?? [])
//           .map((e) => Episode.fromJson(e ?? {}))
//           .toList(),
//     );
//   }
// }
//
// class Episode {
//   final String title;
//   final String episodeId;
//   final int number;
//   final bool isFiller;
//   final List<SubDubData> sub;
//   final List<SubDubData> dub;
//   final List<SubDubData> raw;
//
//   Episode({
//     required this.title,
//     required this.episodeId,
//     required this.number,
//     required this.isFiller,
//     required this.sub,
//     required this.dub,
//     required this.raw,
//   });
//
//   factory Episode.fromJson(Map<String, dynamic> json) {
//     return Episode(
//       title: json['title'] ?? '',
//       episodeId: json['episodeId'] ?? '',
//       number: json['number'] ?? 0,
//       isFiller: json['isFiller'] ?? false,
//       sub: (json['sub'] as List? ?? [])
//           .map((e) => SubDubData.fromJson(e ?? {}))
//           .toList(),
//       dub: (json['dub'] as List? ?? [])
//           .map((e) => SubDubData.fromJson(e ?? {}))
//           .toList(),
//       raw: json['raw'] ?? [],
//     );
//   }
// }
//
// class SubDubData {
//   final String serverName;
//   final int serverId;
//   final EpisodeDetails? episodeDetails;
//
//   SubDubData({required this.serverName, required this.serverId, this.episodeDetails,});
//
//   factory SubDubData.fromJson(Map<String, dynamic> json) {
//     return SubDubData(
//       serverName: json['serverName'] ?? '',
//       serverId: json['serverId'] ?? 0,
//       episodeDetails: json['episodeDetails'] != null
//           ? EpisodeDetails.fromJson(json['episodeDetails'] ?? {})
//           : null,
//     );
//   }
// }
//
// class EpisodeDetails {
//   final List<Track> tracks;
//   final IntroOutro? intro;
//   final IntroOutro? outro;
//   final List<Source> sources;
//   final int anilistID;
//   final int malID;
//
//   EpisodeDetails({
//     required this.tracks,
//     this.intro,
//     this.outro,
//     required this.sources,
//     required this.anilistID,
//     required this.malID,
//   });
//
//   factory EpisodeDetails.fromJson(Map<String, dynamic> json) {
//     return EpisodeDetails(
//       tracks: (json['tracks'] as List? ?? [])
//           .map((e) => Track.fromJson(e ?? {}))
//           .toList(),
//       intro: json['intro'] != null
//           ? IntroOutro.fromJson(json['intro'] ?? {})
//           : null,
//       outro: json['outro'] != null
//           ? IntroOutro.fromJson(json['outro'] ?? {})
//           : null,
//       sources: (json['sources'] as List? ?? [])
//           .map((e) => Source.fromJson(e ?? {}))
//           .toList(),
//       anilistID: json['anilistID'] ?? 0,
//       malID: json['malID'] ?? 0,
//     );
//   }
// }
//
// class Track {
//   final String file;
//   final String label;
//   final String kind;
//   final bool isDefault;
//
//   Track({
//     required this.file,
//     required this.label,
//     required this.kind,
//     required this.isDefault,
//   });
//
//   factory Track.fromJson(Map<String, dynamic> json) {
//     return Track(
//       file: json['file'] ?? '',
//       label: json['label'] ?? '',
//       kind: json['kind'] ?? '',
//       isDefault: json['default'] ?? false,
//     );
//   }
// }
//
// class IntroOutro {
//   final int start;
//   final int end;
//
//   IntroOutro({required this.start, required this.end});
//
//   factory IntroOutro.fromJson(Map<String, dynamic> json) {
//     return IntroOutro(
//       start: json['start'] ?? 0,
//       end: json['end'] ?? 0,
//     );
//   }
// }
//
// class Source {
//   final String url;
//   final String type;
//
//   Source({required this.url, required this.type});
//
//   factory Source.fromJson(Map<String, dynamic> json) {
//     return Source(
//       url: json['url'] ?? '',
//       type: json['type'] ?? '',
//     );
//   }
// }

class Episode {
  bool success;
  Data data;

  Episode({
    required this.success,
    required this.data,
  });

  // From JSON
  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      success: json['success'] ?? false,
      data: Data.fromJson(json['data'] ?? {}),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

class Data {
  int totalEpisodes;
  List<EpisodeElement> episodes;

  Data({
    required this.totalEpisodes,
    required this.episodes,
  });

  // From JSON
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      totalEpisodes: json['totalEpisodes'] ?? 0,
      episodes: (json['episodes'] as List? ?? [])
          .map((e) => EpisodeElement.fromJson(e ?? {}))
          .toList(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'totalEpisodes': totalEpisodes,
      'episodes': episodes.map((e) => e.toJson()).toList(),
    };
  }
}

class EpisodeElement {
  String title;
  String episodeId;
  int number;
  bool isFiller;

  EpisodeElement({
    required this.title,
    required this.episodeId,
    required this.number,
    required this.isFiller,
  });

  // From JSON
  factory EpisodeElement.fromJson(Map<String, dynamic> json) {
    return EpisodeElement(
      title: json['title'] ?? '',
      episodeId: json['episodeId'] ?? '',
      number: json['number'] ?? 0,
      isFiller: json['isFiller'] ?? false,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'episodeId': episodeId,
      'number': number,
      'isFiller': isFiller,
    };
  }
}

