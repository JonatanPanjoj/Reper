import 'package:reper/domain/entities/entities.dart';

class Song {
  final String id;
  final AppUser createdBy;
  final String title;
  final String lyrics;
  final String artist;
  final List<String> images;
  final String pdfFile;

  Song({
    required this.id,
    required this.createdBy,
    required this.title,
    required this.lyrics,
    required this.artist,
    required this.images,
    required this.pdfFile,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_by': createdBy.toJson(),
      'title': title,
      'lyrics': lyrics,
      'artist': artist,
      'images': images,
      'pdfFile': pdfFile,
    };
  }

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] ?? '',
      createdBy: AppUser.fromJson(json['created_by']),
      title: json['title'] ?? '',
      lyrics: json['lyrics'] ?? '',
      artist: json['artist'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      pdfFile: json['pdfFile'] ?? '',
    );
  }

    Song copyWith({
    String? id,
    AppUser? createdBy,
    String? title,
    String? lyrics,
    String? artist,
    List<String>? images,
    String? pdfFile,
  }) {
    return Song(
      id: id ?? this.id,
      createdBy: createdBy ?? this.createdBy,
      title: title ?? this.title,
      lyrics: lyrics ?? this.lyrics,
      artist: artist ?? this.artist,
      images: images ?? List.from(this.images),
      pdfFile: pdfFile ?? this.pdfFile,
    );
  }
}
