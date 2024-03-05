import 'package:cloud_firestore/cloud_firestore.dart';

class Song {
  final String id;
  final String createdBy;
  final String title;
  final String lyrics;
  final String artist;
  final List<String> images;
  final String pdfFile;
  final bool isPublic;
  final Timestamp createdAt;

  //Constructor
  Song({
    required this.id,
    required this.createdBy,
    required this.title,
    required this.lyrics,
    required this.artist,
    required this.images,
    required this.pdfFile,
    required this.isPublic,
    required this.createdAt,
  });

  // FromJson lo usamos para cuando lo envíamos a la base de datos
  // Convierte un Song() en json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_by': createdBy,
      'title': title,
      'lyrics': lyrics,
      'artist': artist,
      'images': images,
      'pdfFile': pdfFile,
      'isPublic': isPublic,
      'created_at': createdAt,
    };
  }

  // ToJson lo usamos para cuando viene de la base de datos
  // Convierte un json en Song()
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] ?? '',
      createdBy: json['created_by'] ?? '',
      title: json['title'] ?? '',
      lyrics: json['lyrics'] ?? '',
      artist: json['artist'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      pdfFile: json['pdfFile'] ?? '',
      isPublic: json['is_public'] ?? false,
      createdAt: json['created_at'],
    );
  }

  //Copia todos los atributos de la instancia + los nuevos que le enviemos
  Song copyWith({
    String? id,
    String? createdBy,
    String? title,
    String? lyrics,
    String? artist,
    List<String>? images,
    String? pdfFile,
    bool? isPublic,
    Timestamp? createdAt,
  }) {
    return Song(
      id: id ?? this.id,
      createdBy: createdBy ?? this.createdBy,
      title: title ?? this.title,
      lyrics: lyrics ?? this.lyrics,
      artist: artist ?? this.artist,
      images: images ?? List.from(this.images),
      pdfFile: pdfFile ?? this.pdfFile,
      isPublic: isPublic ?? this.isPublic,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
