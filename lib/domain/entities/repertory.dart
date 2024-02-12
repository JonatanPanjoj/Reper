class Repertory {
  final String id;
  final String name;
  final String image;
  final List<String> sections;

  Repertory({
    required this.id,
    required this.name,
    required this.image,
    required this.sections,
  });

  Repertory copyWith({
    String? id,
    String? name,
    String? image,
    List<String>? sections,
  }) {
    return Repertory(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      sections: sections ?? this.sections,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'sections': sections,
    };
  }

  factory Repertory.fromJson(Map<String, dynamic> json) {
    return Repertory(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      sections: List<String>.from(json['sections'] ?? []),
    );
  }

  factory Repertory.empty() {
    return Repertory(
      id: '',
      name: '',
      image: '',
      sections: [],
    );
  }

}
