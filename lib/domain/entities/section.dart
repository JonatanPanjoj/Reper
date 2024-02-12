import 'package:reper/domain/entities/entities.dart';

class Section {
  final String id;
  final String name;
  final Song song;

  Section({
    required this.id,
    required this.name,
    required this.song,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'song': song.toJson(),
    };
  }

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      name: json['name'],
      song: Song.fromJson(json['song']),
    );
  }
}
