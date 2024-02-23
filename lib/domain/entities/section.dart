import 'package:reper/domain/entities/entities.dart';

class Section {
  final String id;
  final int position;
  final String name;
  final Song song;

  Section({
    required this.id,
    required this.name,
    required this.song,
    required this.position
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'song': song.toJson(),
      'position': position
    };
  }

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      name: json['name'],
      song: Song.fromJson(json['song']),
      position: json['position']
    );
  }

  Section copyWith({
    String? id,
    int? position,
    String? name,
    Song? song,
  }) {
    return Section(
      id: id ?? this.id,
      position: position ?? this.position,
      name: name ?? this.name,
      song: song ?? this.song,
    );
  }
}
