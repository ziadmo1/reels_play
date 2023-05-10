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
  String? name;
  String? type;
  String? path;

  Medias({this.sId, this.name, this.type, this.path});

  Medias.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['path'] = this.path;
    return data;
  }
}
