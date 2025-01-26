class Server {
  bool? success;
  Data? data;

  Server({
    this.success,
    this.data,
  });

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
      success: json['success'] as bool?,
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class Data {
  List<Dub>? sub;
  List<Dub>? dub;
  List<dynamic>? raw;
  String? episodeId;
  int? episodeNo;

  Data({
    this.sub,
    this.dub,
    this.raw,
    this.episodeId,
    this.episodeNo,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      sub: (json['sub'] as List<dynamic>?)
          ?.map((item) => Dub.fromJson(item as Map<String, dynamic>))
          .toList(),
      dub: (json['dub'] as List<dynamic>?)
          ?.map((item) => Dub.fromJson(item as Map<String, dynamic>))
          .toList(),
      raw: json['raw'] as List<dynamic>?,
      episodeId: json['episodeId'] as String?,
      episodeNo: json['episodeNo'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sub': sub?.map((item) => item.toJson()).toList(),
      'dub': dub?.map((item) => item.toJson()).toList(),
      'raw': raw,
      'episodeId': episodeId,
      'episodeNo': episodeNo,
    };
  }
}

class Dub {
  String? serverName;
  int? serverId;

  Dub({
    this.serverName,
    this.serverId,
  });

  factory Dub.fromJson(Map<String, dynamic> json) {
    return Dub(
      serverName: json['serverName'] as String?,
      serverId: json['serverId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serverName': serverName,
      'serverId': serverId,
    };
  }
}
