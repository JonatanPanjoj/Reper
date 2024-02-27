class Section {
  final String id;
  final int position;
  final String name;
  final String song;

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
      'song': song,
      'position': position
    };
  }

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      name: json['name'],
      song: json['song'],
      position: json['position']
    );
  }

  Section copyWith({
    String? id,
    int? position,
    String? name,
    String? song,
  }) {
    return Section(
      id: id ?? this.id,
      position: position ?? this.position,
      name: name ?? this.name,
      song: song ?? this.song,
    );
  }
}
