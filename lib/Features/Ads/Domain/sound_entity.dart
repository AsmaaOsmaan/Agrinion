import 'dart:convert';

class SoundModel {
  int? id;
  String? soundUrl;
  SoundModel({
    this.id,
    this.soundUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sound_url': soundUrl,
    };
  }

  factory SoundModel.fromMap(Map<String, dynamic> map) {
    return SoundModel(
      id: map['id'],
      soundUrl: map['sound_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SoundModel.fromJson(String source) =>
      SoundModel.fromMap(json.decode(source));
}
