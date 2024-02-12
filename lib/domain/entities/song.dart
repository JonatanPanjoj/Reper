class Song {
  final String id;
  final String createdBy;
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
      'created_by': createdBy,
      'title': title,
      'lyrics': lyrics,
      'artist': artist,
      'images': images,
      'pdfFile': pdfFile,
    };
  }

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      createdBy: json['created_by'],
      title: json['title'],
      lyrics: json['lyrics'],
      artist: json['artist'],
      images: List<String>.from(json['images'] ?? []),
      pdfFile: json['pdfFile'],
    );
  }
}
