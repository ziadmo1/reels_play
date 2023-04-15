class MediaResponse {
  List<Medias>? medias;

  MediaResponse({this.medias});

  MediaResponse.fromJson(Map<String, dynamic> json) {
    if (json['medias'] != null) {
      medias = <Medias>[];
      json['medias'].forEach((v) {
        medias!.add(new Medias.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medias != null) {
      data['medias'] = this.medias!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medias {
  String? sId;
  String? type;
  Paths? paths;
  int? iV;

  Medias({this.sId, this.type, this.paths, this.iV});

  Medias.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    paths = json['paths'] != null ? new Paths.fromJson(json['paths']) : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['type'] = this.type;
    if (this.paths != null) {
      data['paths'] = this.paths!.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Paths {
  String? low;
  String? high;
  String? audio;
  String? sId;

  Paths({this.low, this.high, this.audio, this.sId});

  Paths.fromJson(Map<String, dynamic> json) {
    low = json['low'];
    high = json['high'];
    audio = json['audio'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['low'] = this.low;
    data['high'] = this.high;
    data['audio'] = this.audio;
    data['_id'] = this.sId;
    return data;
  }
}
